local RaidNotifier = RaidNotifier
local UI = RaidNotifier.UI

UI.MAP_MOL_BASE = "Art/maps/reapersmarch/Maw_of_Lorkaj_Base_0.dds"
UI.MAP_MOL_SUTHAY_SANCTUARY = "Art/maps/reapersmarch/MawLorkajSuthaySanctuary_Base_0.dds"
UI.MAP_MOL_SEVEN_RIDDLES = "Art/maps/reapersmarch/MawLorkajSevenRiddles_Base_0.dds"

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

	function UI.InvertGlyphs()
		window = window or UI.GetElement("mawLorkhaj", "zhaj_glyph_window")
		if not window then return end
		for i, glyph in ipairs(window.glyphs) do
			local _, _, _, _, offsetX, offsetY = glyph:GetAnchor(0)
			glyph:SetAnchor(CENTER, self, CENTER, -1*offsetX, -1*offsetY)
		end
		local label = window:GetNamedChild("Exit")
		local _, point = label:GetAnchor(0)
		label:ClearAnchors()
		label:SetAnchor(point == TOP and BOTTOM or TOP, self, point == TOP and BOTTOM or TOP)
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
