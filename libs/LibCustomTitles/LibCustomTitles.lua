--[[
Author: Ayantir
Filename: LibCustomTitles.lua
Version: 10
]]--

--[[

This software is under : CreativeCommons CC BY-NC-SA 4.0
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

You are free to:

    Share — copy and redistribute the material in any medium or format
    Adapt — remix, transform, and build upon the material
    The licensor cannot revoke these freedoms as long as you follow the license terms.


Under the following terms:

    Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial — You may not use the material for commercial purposes.
    ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
    No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


Please read full licence at : 
http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode

]]--


--[[

Author: Kyoma
Version 18
Changes: Rewrote how custom titles are added and stored to help reduce conflict between authors
	- Moved table with custom titles into seperate section with register function
	- Use achievementId instead of raw title name to make it work with all languages
	- Make it default to english custom title if nothing is specified for the user's language
	- Support for LibTitleLocale to fix issues with title differences for males and females

	(Added the option to make a title hidden from the user itself) *mhuahahahaha*
	
	(v18) 
	- Added support for colors and even a simple gradient
	- Moved language check to title registration
]]--


local libLoaded
local LIB_NAME, VERSION = "LibCustomTitlesRN", 18
local LibCustomTitles, oldminor = LibStub:NewLibrary(LIB_NAME, VERSION)
if not LibCustomTitles then return end

local function RegisterTitle(module, ...)
	table.insert(module.titles, {...})
end

LibCustomTitlesModules = LibCustomTitlesModules or {}
function LibCustomTitles:RegisterModule(name, version)

	local module = LibCustomTitlesModules[name]
	if (module and module.version and module.version > version) then
		return nil
	end

	module = {}
	module.version = version
	module.titles = {}
	module.RegisterTitle = RegisterTitle

	--override any previous titles from an older version
	LibCustomTitlesModules[name] = module
	return module
end

function LibCustomTitles:InitTitles()
	for name, module in pairs(LibCustomTitlesModules) do
		for _, title in ipairs(module.titles) do
			self:RegisterTitle(unpack(title))
		end
	end
	LibCustomTitlesModules = nil --remove from global
end

local lang = GetCVar("Language.2")

local customTitles = {}
function LibCustomTitles:RegisterTitle(displayName, charName, override, title, extra)

	if type(title) == "table" then
		title = title[lang] or title["en"]
	end

	local hidden = (extra == true) --support old format
	if type(extra) == "table" then
		hidden = extra["hidden"]
		if extra["color"] then
			title = self:ApplyColor(title, extra["color"])
		end
	end

	if hidden and (displayName == GetUnitDisplayName("player") or charName == GetUnitName("player")) then
		return
	end

	local playerGender = GetUnitGender("player")
	local genderTitle

	if type(override) == "boolean" then --override all titles
		override = override and "-ALL-" or "-NONE-"
	elseif type(override) == "number" then --get override title from achievementId
		local hasRewardOfType, titleName = GetAchievementRewardTitle(override, playerGender) --gender is 1 or 2
		if hasRewardOfType and titleName then
			genderTitle = select(2, GetAchievementRewardTitle(override, 3 - playerGender))  -- cuz 3-2=1 and 3-1=2
			override = titleName
		end
	elseif type(override) == "table" then --use language table with strings
		override = override[lang] or override["en"]
	end

	if type(override) == "string" then 
		if not customTitles[displayName] then 
			customTitles[displayName] = {}
		end
		local charOrAccount = customTitles[displayName]
		if charName then
			if not customTitles[displayName][charName]  then 
				customTitles[displayName][charName] = {}
			end
			charOrAccount = customTitles[displayName][charName]
		end
		charOrAccount[override] = title
		if genderTitle and genderTitle ~= override then
			charOrAccount[genderTitle] = title
		end
	end
end

local MAX_GRADIENT_STEPS = 10 --after that text just starts to disappear
function LibCustomTitles:ApplyColor(text, color)

	if type(color) == "string" then 	-- just a simple color
		return "|c"..color:gsub("#","")..text.."|r"
	elseif type(color) ~= "table" then --wrong format??
		return text
	end
	
	local function hex2rgb(hex)
		hex = hex:gsub("#","")
		return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
	end
	
	local gStart = {hex2rgb(color[1])}
	local gEnd   = {hex2rgb(color[2])}

	local len = string.len(text:gsub(" ", ""))
	local numSteps = zo_min(len, MAX_GRADIENT_STEPS)
	local stepSize = len / numSteps --we dont round this down directly

	local gSteps = {
		(gEnd[1]-gStart[1])/numSteps, 
		(gEnd[2]-gStart[2])/numSteps, 
		(gEnd[3]-gStart[3])/numSteps
	}

	local function FormatGradient(step)
		return ("|c%02X%02X%02X"):format(zo_floor(gStart[1] + gSteps[1] * step), zo_floor(gStart[2] + gSteps[2] * step), zo_floor(gStart[3] + gSteps[3] * step))
	end

	local step = 0
	local substep = 0
	local gradientText = FormatGradient(step)
	for c in text:gmatch(".") do
		if c ~= " " then --ignore spaces
			substep = substep + 1
			if substep >= stepSize then
				substep = substep - stepSize
				step = step + 1
				gradientText = gradientText..FormatGradient(step)
			end
		end
		gradientText = gradientText..c
	end
	gradientText = gradientText.."|r"

	return gradientText
end

function LibCustomTitles:Init()

	self:InitTitles()

	local CT_NO_TITLE = 0
	local CT_TITLE_ACCOUNT = 1
	local CT_TITLE_CHARACTER = 2

	local function GetCustomTitleType(displayName, unitName)
		if customTitles[displayName] then
			if customTitles[displayName][unitName] then
				return CT_TITLE_CHARACTER
			end
			return CT_TITLE_ACCOUNT
		end
		return CT_NO_TITLE
	end

	local function GetCustomTitle(originalTitle, customTitle)
		if customTitle[originalTitle] then
			return customTitle[originalTitle]
		elseif originalTitle == "" and customTitle["-NONE-"] then
			return customTitle["-NONE-"]
		elseif customTitle["-ALL-"] then
			return customTitle["-ALL-"]
		end
	end

	local function GetModifiedTitle(originalTitle, displayName, unitName, registerType)
		if registerType == CT_TITLE_CHARACTER then
			return GetCustomTitle(originalTitle, customTitles[displayName][unitName]) or originalTitle
		elseif registerType == CT_TITLE_ACCOUNT then
			return GetCustomTitle(originalTitle, customTitles[displayName]) or originalTitle
		end
		return originalTitle
	end

	local GetUnitTitle_original = GetUnitTitle
	GetUnitTitle = function(unitTag)
		local unitTitleOriginal = GetUnitTitle_original(unitTag)
		local unitDisplayName = GetUnitDisplayName(unitTag)
		local unitCharacterName = GetUnitName(unitTag)
		local registerType = GetCustomTitleType(unitDisplayName, unitCharacterName)
		if registerType ~= CT_NO_TITLE then
			return GetModifiedTitle(unitTitleOriginal, unitDisplayName, unitCharacterName, registerType)
		end
		return unitTitleOriginal
	end

	local GetTitle_original = GetTitle
	GetTitle = function(index)
		local titleOriginal = GetTitle_original(index)
		local displayName = GetDisplayName()
		local characterName = GetUnitName("player")
		local registerType = GetCustomTitleType(displayName, characterName)
		if registerType ~= CT_NO_TITLE then
			return GetModifiedTitle(titleOriginal, displayName, characterName, registerType)
		end
		return titleOriginal
	end

end

local function OnAddonLoaded()
	if not libLoaded then
		libLoaded = true
		local LCC = LibStub('LibCustomTitlesRN')
		LCC:Init()
		EVENT_MANAGER:UnregisterForEvent(LIB_NAME, EVENT_ADD_ON_LOADED)
	end
end

EVENT_MANAGER:RegisterForEvent(LIB_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)



--[[
public static String Rainbow(Int32 numOfSteps, Int32 step)
{
	var r = 0.0;
	var g = 0.0;
	var b = 0.0;
	var h = (Double)step / numOfSteps;
	var i = (Int32)(h * 6);
	var f = h * 6.0 - i;
	var q = 1 - f;

	switch (i % 6)
	{
		case 0:
			r = 1;
			g = f;
			b = 0;
			break;
		case 1:
			r = q;
			g = 1;
			b = 0;
			break;
		case 2:
			r = 0;
			g = 1;
			b = f;
			break;
		case 3:
			r = 0;
			g = q;
			b = 1;
			break;
		case 4:
			r = f;
			g = 0;
			b = 1;
			break;
		case 5:
			r = 1;
			g = 0;
			b = q;
			break;
	}
	return "#" + ((Int32)(r * 255)).ToString("X2") + ((Int32)(g * 255)).ToString("X2") + ((Int32)(b * 255)).ToString("X2");
}

--]]



















