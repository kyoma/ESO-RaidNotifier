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
		UI.LoadElements()
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

	function UI.GetElement(category, setting)
		return elements[GetKey(category, setting)]
	end

end


-- -----------------
-- -- GLYPH WINDOW
do -----------------

	local window  = nil 

	function UI.StartGlyphTimer(index, cooldown)
		window = window or UI.GetElement("mawLorkhaj", "zhaj_glyph_window")
		if not window then return end

		local glyph = window.glyphs[index]
		if not glyph then return end

		glyph.timer:SetText(ZO_FormatTimeMilliseconds(cooldown, TIME_FORMAT_STYLE_DESCRIPTIVE_MINIMAL_SHOW_TENTHS_SECS)) 
		glyph.start = GetFrameTimeMilliseconds()
		glyph.cooldown = cooldown
		glyph.timer:SetHidden(false)
		glyph.overlay:SetHidden(true)
	end 

	function UI.StopGlyphTimer(index)
		window = window or UI.GetElement("mawLorkhaj", "zhaj_glyph_window")
		if not window then return end

		local glyph = window.glyphs[index]
		if not glyph then return end

		glyph.timer:SetHidden(true)
		glyph.start = 0
		glyph.overlay:SetHidden(false)
	end
	
	function UI.SetupGlyphWindow(window, inverted)
		window = window or UI.GetElement("mawLorkhaj", "zhaj_glyph_window")
		if not window then return end

		for _, control in ipairs(window.glyphs) do
			local isValidAnchor, point, relativeTo, relativePoint, offsetX, offsetY = control:GetAnchor()
			control:ClearAnchors()
			offsetY = math.abs(offsetY)
			if inverted then
				point = BOTTOM
				offsetY = offsetY * -1
			else
				point = TOP
			end
			control:SetAnchor(point, nil, nil, offsetX, offsetY)
		end
	end

	function UI.GlyphUpdateHandler(window)
		window = window or UI.GetElement("mawLorkhaj", "zhaj_glyph_window")
		if not window then return end

		for i, glyph in ipairs(window.glyphs) do
			if glyph.start > 0 then
				local duration = glyph.start + glyph.cooldown - GetFrameTimeMilliseconds()
				if duration <= 0 then
					glyph.start = 0
					glyph.timer:SetHidden(true)
					glyph.overlay:SetHidden(false)
				else
					glyph.timer:SetText(ZO_FormatTimeMilliseconds(duration, TIME_FORMAT_STYLE_DESCRIPTIVE_MINIMAL_SHOW_TENTHS_SECS))
				end
			end
		end
	end 

end