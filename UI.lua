local RaidNotifier = RaidNotifier
local UI = RaidNotifier.UI

do 
	local UI_FRAGMENT

	local function GetKey(c, s)
		return c.."_"..s
	end

	function UI.AddFragment()
		if not UI_FRAGMENT then 
			UI_FRAGMENT = ZO_HUDFadeSceneFragment:New(RaidNotifierUI)
		end
		HUD_SCENE:AddFragment(UI_FRAGMENT)
		HUD_UI_SCENE:AddFragment(UI_FRAGMENT)
	end
	function UI.RemoveFragment()
		if not UI_FRAGMENT then 
			UI_FRAGMENT = ZO_HUDFadeSceneFragment:New(RaidNotifierUI)
		end
		HUD_SCENE:RemoveFragment(UI_FRAGMENT)
		HUD_UI_SCENE:RemoveFragment(UI_FRAGMENT)
	end

	local elements = {}
	function UI.RegisterElement(control, hidden)
		elements[GetKey(control.category, control.setting)] = control
		control:SetHandler("OnMoveStop", UI.SaveElement)
		-- update handler, name of handler as string in the "RaidNotifier.UI" namespace
		if control.onUpdate ~= nil then
			control:SetHandler("OnUpdate", function() UI[control.onUpdate](control) end)
		end
		if control.onInitialize ~= nil then
			UI[control.onInitialize](control)
		end
		if hidden ~= nil then
			control:SetHidden(hidden)
		end
	end
	function UI.LoadElements()
		local parent = RaidNotifierUI
		for k, elem in pairs(elements) do
			local settings = RaidNotifier.Vars[elem.category]
			elem:ClearAnchors()
			elem:SetAnchor(TOPLEFT, parent, TOPLEFT, unpack(settings[elem.setting]))
		end
	end
	function UI.SaveElement(control)
		local settings = RaidNotifier.Vars[control.category]
		settings[control.setting] = {control:GetLeft(), control:GetTop()}
	end

	function UI.SetElementHidden(category, setting, hidden)
		local control = elements[GetKey(category, setting)]
		if control then -- and control:IsHidden() ~= hidden then
			control:SetHidden(hidden)
		end
	end
	
	function UI.HideAllElements()
		for k, elem in pairs(elements) do
			elem:SetHidden(true)
		end
	end

	function UI.GetElement(category, setting)
		return elements[GetKey(category, setting)]
	end

end




-- -------------------
-- -- RNTIMER OBJECT
do -------------------

	local Util     = RaidNotifier.Util
	
	local OnUpdate   = nil --forwarding
	local refCounter = Util.RefCounter:New("RNTimerCounter",
		-- on getting atleast one reference
		function() 
			--d("Registering for update")
			EVENT_MANAGER:RegisterForUpdate(RaidNotifier.Name, 100, OnUpdate) 
		end,
		-- on reaching zero references
		function()
			--d("Unregistering for update")
			EVENT_MANAGER:UnregisterForUpdate(RaidNotifier.Name) 
		end)

	-- The master list for all timers, active and inactive
	-- TODO: switch to a proper pool?
	local RNTimerList = {}
	OnUpdate = function()
		local currentTimeMs = GetFrameTimeMilliseconds()
		for _, timer in ipairs(RNTimerList) do
			timer:Update(currentTimeMs)
		end
	end

	-- Now for the actual object, still a WIP so structure may change drastically
	RNTimer = ZO_Object:Subclass()
	function RNTimer:New(...)
		local object = ZO_Object.New(self)
		object:Initialize(...)
		return object
	end

	function RNTimer:Initialize(control, formatter, onCompleteFn)
		self.control = control

		local function DefaultFormatter(remaining)
			return ZO_FormatTimeMilliseconds(remaining, TIME_FORMAT_STYLE_DESCRIPTIVE_MINIMAL_SHOW_TENTHS_SECS)
		end
		self.formatter = formatter or DefaultFormatter

		self.onCompleteFn = onCompleteFn

		self.startMs   = 0
		self.duration  = 0
		self.endMs     = 0

		table.insert(RNTimerList, self)
	end

	function RNTimer:GetTimerInfo()
		return self.startMs, self.duration, self.endMs
	end

	function RNTimer:SetText(text)
		self.control:SetText(text)
	end

	function RNTimer:Reset()
		self.startMs   = 0
		self.duration  = 0
		self.endMs     = 0
		-- placed here since calling OnComplete _might_ become optional in the future
		refCounter:Decr()
	end

	function RNTimer:OnComplete(forceStopped)
		--TODO: hide control by default here?
		if self.onCompleteFn then
			self.onCompleteFn(self, forceStopped)
		end
		self:Reset()
	end

	function RNTimer:Start(startMs, duration, endMs)
		-- increment counter only if we weren't already active
		if self.startMs <= 0 then
			refCounter:Incr()
		end
		-- endMs can be omitted
		self.startMs   = startMs
		self.duration  = duration
		if endMs == nil then
			endMs = startMs + duration
		end
		self.endMs     = endMs

		self:Update(startMs) -- use Update to apply (initial) layout
	end

	-- Use this to force a timer to stop
	function RNTimer:Stop()
		--only stop if we are active
		if (self.startMs > 0) then
			self:OnComplete(true) -- handles resetting
		end
	end

	-- return: hasEnded
	function RNTimer:Update(currentFrameTimeMs)
		if (self.startMs > 0) then
			local remaining = self.endMs - currentFrameTimeMs
			if remaining <= 0 then
				self:OnComplete() -- handles resetting
				return true
			else
				self:SetText(self.formatter(remaining))
			end
		end
		return false
	end

end


-- --------------------
-- -- SCALDED DISPLAY
do --------------------

	local display  = nil -- the parent display
	local timerObj = nil -- the timer object (NOT THE ACTUAL CONTROL)
	
	local Util     = RaidNotifier.Util
	
	function UI.UpdateScaldedStacks(stacks, startTime, endTime)
		display = display or UI.GetElement("hallsFab", "pinnacleBoss_scalded_display")
		if not display then return end

		if (stacks > 0) then
			local r,g,b = Util.HSL2RGB((10 - stacks) / 30, 1, 0.5)
			display.debuff:SetColor(r,g,b,1)
			display.debuff:SetText(("%d%%"):format(stacks * 10))

			display:SetHidden(false)
			timerObj:Start(startTime*1000, nil, endTime*1000)
		else
			timerObj:Stop()
			display:SetHidden(true)
		end
	end
	
	function UI.InitializeScaldedDisplay(control)
		display = control
		
		display.debuff = display:GetNamedChild("Debuff")
		display.timer  = display:GetNamedChild("Timer")
		
		local function OnComplete(control, forceStopped)
			-- hide display (maybe not needed since we also listen to when the effect fades)
			display:SetHidden(true)
		end
		timerObj = RNTimer:New(display.timer, nil, OnComplete)
	end

end



-- -----------------
-- -- GLYPH WINDOW
do -----------------

	local window      = nil -- the window itself
	local glyphTimers = {}  -- the glyph objects (NOT THE ACTUAL CONTROLS)

	-- GlyphTimer: handles showing and hiding of the overlay and timer
	--             in addition to updating the timer itself.
	local RNGlyphTimer = RNTimer:Subclass()
	function RNGlyphTimer:New(...)
		return RNTimer.New(self, ...)
	end
	function RNGlyphTimer:Initialize(control, formatter, onCompleteFn)
		RNTimer.Initialize(self, control, formatter, onCompleteFn)
		
		self.bg       = control:GetNamedChild("BG")
		self.overlay  = control:GetNamedChild("Overlay")
		self.timer    = control:GetNamedChild("Timer")

		-- show overlay when inactive
		self.timer:SetHidden(true)
		self.overlay:SetHidden(false)
	end
	function RNGlyphTimer:Reset()
		RNTimer.Reset(self)
		-- show overlay when inactive
		self.timer:SetHidden(true)
		self.overlay:SetHidden(false)
	end
	function RNGlyphTimer:Start(startMs, duration, endMs)
		RNTimer.Start(self, startMs, duration, endMs) -- will call Update()
		self.timer:SetHidden(false)
		self.overlay:SetHidden(true)
	end
	function RNGlyphTimer:SetText(text)
		self.timer:SetText(text)
	end

	-- Wrapper functions
	function UI.StartGlyphTimer(index, cooldown)
		window = window or UI.GetElement("mawLorkhaj", "zhaj_glyph_window")
		if not window then return end

		local glyph = glyphTimers[index]
		if not glyph then return end
		
		glyph:Start(GetFrameTimeMilliseconds(), cooldown)
	end 
	function UI.StopGlyphTimer(index)
		window = window or UI.GetElement("mawLorkhaj", "zhaj_glyph_window")
		if not window then return end

		local glyph = glyphTimers[index]
		if not glyph then return end
		
		glyph:Stop() -- just calls OnComplete, nothing special for now
	end

	-- Called upon loading and when the setting is changed
	function UI.InvertGlyphs()
		window = window or UI.GetElement("mawLorkhaj", "zhaj_glyph_window")
		if not window then return end

		for _, glyph in ipairs(glyphTimers) do
			local _, _, _, _, offsetX, offsetY = glyph.control:GetAnchor(0)
			glyph.control:SetAnchor(CENTER, nil, CENTER, -1*offsetX, -1*offsetY)
		end
		local label = window:GetNamedChild("Exit")
		local _, point = label:GetAnchor(0)
		label:ClearAnchors()
		label:SetAnchor(point == TOP and BOTTOM or TOP, nil, point == TOP and BOTTOM or TOP)
	end

	-- Called upon registering; handles GlyphTimer object creation
	function UI.InitializeGlyphs(control)
		window = control
		glyphTimers = {}
		for i=1,7 do
			glyphTimers[i] = RNGlyphTimer:New(window:GetNamedChild("Glyph"..i))
		end
		-- change the textures for the magical 'player glyph' 
		local playerGlyph = glyphTimers[7]
		playerGlyph.bg:SetTexture("RaidNotifier/assets/white_circle.dds")
		playerGlyph.overlay:SetTexture("RaidNotifier/assets/dummy.dds")
	end

end