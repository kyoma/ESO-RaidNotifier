local RaidNotifier = RaidNotifier
local UI   = RaidNotifier.UI
local Util = RaidNotifier.Util

local tinsert	 			= table.insert
local tremove				= table.remove
local tsort		 			= table.sort

-- Constants for easy reading
local RAID_HEL_RA_CITADEL        = 1
local RAID_AETHERIAN_ARCHIVE     = 2
local RAID_SANCTUM_OPHIDIA       = 3
local RAID_DRAGONSTAR_ARENA      = 4
local RAID_MAW_OF_LORKHAJ        = 5
local RAID_MAELSTROM_ARENA       = 6
local RAID_HALLS_OF_FABRICATION  = 7

-- ------------------
-- DEFAULT SETTINGS
do ------------------

	-- local DEFAULT_SOUND = "default_sound" -- will remain as the actual value
	-- local DEFAULT_PRIORITY = 3
	-- local ALL_ROLES =
	-- {
		-- [1] = true, -- Damage
		-- [2] = true, -- Healer
		-- [3] = true, -- Tank
	-- }

	-- local defaults = 
	-- {
		-- useAccountWide = true, --very special setting!!

		-- general = 
		-- { -- no need for advanced settings
			-- buffFood_reminder           = true,
			-- buffFood_reminder_interval  = 60,
			-- use_center_screen_announce  = true,
			-- vanity_pets                 = true,
			-- no_assistants               = true,
			-- last_pet                    = 0,
			-- default_sound               = SOUNDS.CHAMPION_POINTS_COMMITTED,
		-- },
		-- ultimate = 
		-- { -- no need for advanced settings
			-- enabled                     = false,
			-- hidden                      = false,
			-- useColor                    = true,
			-- useDisplayName              = false,
			-- showHealers                 = true,
			-- showTanks                   = true,
			-- showDps                     = false,
			-- ulti_window                 = {100, 600},
			-- override_cost               = 0,
		-- },

		-- helra = 
		-- {
			-- warrior_stoneform           = {value = 1, --[[Self]]       sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
		-- },
		-- archive =
		-- {
			-- stormatro_impendingstorm    = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- stormatro_lightningstorm    = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- stoneatro_boulderstorm      = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- stoneatro_bigquake          = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- overcharge                  = {value = 0, --[[Off]]        sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
			-- call_lightning              = {value = 1, --[[Self]]       sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
		-- },
		-- sanctumOphidia =
		-- {
			-- magicka_deto                = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- serpent_poison              = {value = 1, --[[Normal]]     sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- serpent_world_shaper        = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- mantikora_quake             = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- troll_boulder               = {value = 0, --[[Off]]        sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- troll_poison                = {value = 0, --[[Off]]        sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- overcharge                  = {value = 0, --[[Off]]        sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- call_lightning              = {value = 1, --[[Self]]       sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
		-- },
		-- dragonstar = 
		-- {
			-- general_taking_aim          = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- general_crystal_blast       = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- arena2_crushing_shock       = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- arena6_drain_resource       = {value = 1, --[[Self]]       sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
			-- arena7_unstable_core        = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- arena8_ice_charge           = {value = 1, --[[Self]]       sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
			-- arena8_fire_charge          = {value = 1, --[[Self]]       sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
		-- },
		-- mawLorkhaj =
		-- {
			-- twinBoss_aspects            = {value = 2, --[[Normal]]     sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- rakkhat_unstablevoid        = {value = 1, --[[Self]]       sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
			-- rakkhat_threshingwings      = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- rakkhat_darknessfalls       = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- rakkhat_darkbarrage         = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- rakkhat_lunarbastion1       = {value = 0, --[[Off]]        sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
			-- rakkhat_lunarbastion2       = {value = 0, --[[Off]]        sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
			-- suneater_eclipse            = {value = 1, --[[Self]]       sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
			-- zhaj_gripoflorkhaj          = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- zhaj_glyphs                 = {value = 1, --[[Normal]]     position = {100, 400}},
		-- },
		-- maelstrom =
		-- {
			-- stage7_poison               = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- stage9_synergy              = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
		-- },
		-- hallsFab = 
		-- {
			-- conduit_strike              = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- taking_aim                  = {value = 1, --[[Self]]       sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
			-- draining_ballista           = {value = 1, --[[Self]]       sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
			-- power_leech                 = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- pinnacleBoss_conduit_spawn  = {value = true,               sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- pinnacleBoss_conduit_drain  = {value = 0, --[[Off]]        sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY,    roles = ALL_ROLES},
			-- pinnacleBoss_scalded        = {value = true,               position = {100, 400}},
			-- committee_auras             = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- committee_auras_dynamic     = {value = false,              }, -- TODO: combine with "committee_auras" as dropdown once fully tested
			-- committee_fabricant_spawn   = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
			-- committee_reclaim_achieve   = {value = false,              sound = DEFAULT_SOUND,    priority = DEFAULT_PRIORITY},
		-- }, 

		-- dbg = 
		-- { -- no need for advanced settings
			-- enable                      = false,
			-- notify                      = false,
			-- tracker                     = false,
			-- spamControl                 = true,
			-- verbose                     = false,
			-- myEnemyOnly                 = false,
			-- devMode                     = false,
		-- },
	-- }
	
	local defaults = {
		useAccountWide = true, 
		general = {
			buffFood_reminder = true,
			buffFood_reminder_interval = 60,
			use_center_screen_announce = true,
			vanity_pets = true,
			no_assistants = true,
			last_pet = 0,
		},
		ultimate = {
			enabled         = false,
			hidden          = false,
			useColor        = true,
			useDisplayName  = false,
			showHealers     = true,
			showTanks       = true,
			showDps         = false,
			ulti_window     = {100, 600},
			override_cost   = 0,
		},
		sounds = {
		},
		helra = {
			yokeda_meteor 	  = 1, -- "Self"
			warrior_stoneform = 1, -- "Self"
		},
		archive = {
			stormatro_impendingstorm = false,
			stormatro_lightningstorm = false,
			stoneatro_boulderstorm = false,
			stoneatro_bigquake     = false,
			overcharge        = 0, --"Off"
			call_lightning    = 1, --"Self"
		},
		sanctumOphidia = {
			magicka_deto          = true,
			serpent_poison        = 1, --"Normal"
			serpent_world_shaper  = true,
			--mantikora_spear   = 1, --"Self"
			mantikora_quake   = false,
			troll_boulder     = 0, --"Off"
			troll_poison      = 0, --"Off"
			overcharge        = 0, --"Off"
			call_lightning    = 1, --"Self"
		},
		dragonstar = {
			general_taking_aim     = false,
			general_crystal_blast  = true,
			arena2_crushing_shock  = true,
			arena6_drain_resource  = 1, --"Self"
			arena7_unstable_core   = true,
			arena8_ice_charge      = 1, --"Self"
			arena8_fire_charge     = 1, --"Self"
		},
		mawLorkhaj = {
			twinBoss_aspects = 2,     -- "Normal"
			rakkhat_unstablevoid = 1, -- "Self"
			rakkhat_threshingwings = true,
			rakkhat_darknessfalls = false,
			rakkhat_darkbarrage = false, 
			rakkhat_lunarbastion1 = 0, -- "Off"
			rakkhat_lunarbastion2 = 0, -- "Off"
			suneater_eclipse = 1, -- "Self"
			zhaj_gripoflorkhaj = true,
			zhaj_glyphs = false,
			zhaj_glyph_window = {100, 400},
			zhaj_glyphs_invert = false,
		},
		maelstrom = {
			stage7_poison  = true,
			stage9_synergy = true,
		},
		hallsFab = {
			conduit_strike        = true, 
			taking_aim            = 1, -- "Self"
			draining_ballista     = 1, -- "Self"
			power_leech           = false,

			pinnacleBoss_conduit_spawn   = true,
			pinnacleBoss_conduit_drain   = 0, -- "Off"
			pinnacleBoss_scalded         = true,
			pinnacleBoss_scalded_display = {100, 400},

			committee_overpower_auras = false,
			committee_overpower_auras_dynamic = false,
			committee_fabricant_spawn = false,
			committee_reclaim_achieve = false,
		}, 

		dbg = {
			enable = false,
			notify = false,
			tracker = false,
			spamControl = true,
			verbose = false,
			myEnemyOnly = false,
			devMode = false,
		},
	}

	function RaidNotifier:GetSetting(settings, category, key)
		if key ~= nil then
			return settings[category] and settings[category][key]
		else -- we passed the category itself already
			return settings[category]
		end
		
	end

	function RaidNotifier:GetDefaults()
		return defaults
	end
end

-- ------------------------
-- PROFILE FUNCTIONS
-- ------------------------
local profileGuard			= false
local profileCopyList		= {}
local profileDeleteList		= {}
local profileCopyToCopy, profileDeleteToDelete, profileDeleteDropRef
local function CopyProfile()
	local usingGlobal	= RNVars.Default[GetDisplayName()]['$AccountWide'].useAccountWide
	local destProfile	= (usingGlobal) and '$AccountWide' or GetUnitName('player')
	local sourceData, destData

	for account, accountData in pairs(RNVars.Default) do
		for profile, data in pairs(accountData) do
			if (profile == profileCopyToCopy) then
				sourceData = data -- get source data to copy
			end

			if (profile == destProfile) then
				destData = data -- get destination to copy to
			end
		end
	end

	if (not sourceData or not destData) then -- something went wrong, abort
		--CHAT_SYSTEM:AddMessage(strformat('%s: %s', "[RaidNotifier]", "Cannot copy profile."))
	else
		Util.CopyTable(sourceData, destData)
		ReloadUI()
	end
end

local function DeleteProfile()
	for account, accountData in pairs(RNVars.Default) do
		for profile, data in pairs(accountData) do
			if (profile == profileDeleteToDelete) then -- found unwanted profile
				accountData[profile] = nil
				break
			end
		end
	end

	for i, profile in ipairs(profileDeleteList) do
		if (profile == profileDeleteToDelete) then
			tremove(profileDeleteList, i)
			break
		end
	end

	profileDeleteToDelete = false
	profileDeleteDropRef:UpdateChoices()
	profileDeleteDropRef:UpdateValue()
end

local function PopulateProfileLists()
	local usingGlobal	= RNVars.Default[GetDisplayName()]["$AccountWide"].useAccountWide
	local currentPlayer	= GetUnitName("player")
	local version		= RaidNotifier.SV_Version

	for account, accountData in pairs(RNVars.Default) do
		for profile, data in pairs(accountData) do
			if (data.version == version) then -- only populate current DB version
				if (usingGlobal) then
					if (profile ~= "$AccountWide") then
						tinsert(profileCopyList, profile) -- don't add accountwide to copy selection
						tinsert(profileDeleteList, profile) -- don't add accountwide to delete selection
					end
				else
					if (profile ~= currentPlayer) then
						tinsert(profileCopyList, profile) -- don't add current player to copy selection

						if (profile ~= "$AccountWide") then
							tinsert(profileDeleteList, profile) -- don't add accountwide or current player to delete selection
						end
					end
				end
			end
		end
	end

	tsort(profileCopyList)
	tsort(profileDeleteList)
end


function RaidNotifier:CreateSettingsMenu()

	PopulateProfileLists()

	local defaults = self:GetDefaults()
	local savedVars = self.Vars

	self:TryConvertSettings(savedVars, defaults)

	local LAM = LibStub:GetLibrary("LibAddonMenu-2.0")
	self.panelData = {
		type = "panel",
		name = self.DisplayName,
		author = self.Author,
		version = self.Version,
		registerForRefresh = true,
		registerForDefaults = true,
	}

	local off_self_all = {
		GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_OFF),
		GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_SELF), 
		GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_ALL), 
	}
	local choices = {
		mawLorkhaj = {
			twinBoss_aspects = {
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_OFF),
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_MINIMAL), 
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_NORMAL),
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_FULL), 
			},
			rakkhat_unstablevoid = off_self_all,
			rakkhat_lunarbastion1 = {
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_OFF),
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_SELF), 
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_OTHER),
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_ALL), 
			},
			rakkhat_lunarbastion2 = {
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_OFF),
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_SELF), 
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_OTHER),
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_ALL), 
			},
			suneater_eclipse = {
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_OFF),
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_SELF), 
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_NEAR), 
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_ALL), 
			},
        },
		sanctumOphidia = {
			mantikora_spear = off_self_all,
			serpent_poison = {
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_OFF),
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_NORMAL),
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_FULL), 
			},
			troll_boulder  = off_self_all,
			troll_poison   = off_self_all,
			overcharge     = off_self_all,
			call_lightning = off_self_all,
		},
		helra = {
			yokeda_meteor = off_self_all,
			warrior_stoneform = off_self_all,
		},
		archive = {
			overcharge     = off_self_all,
			call_lightning = off_self_all,
		},
		dragonstar = {
			arena6_drain_resource = off_self_all,
			arena8_ice_charge = off_self_all,
			arena8_fire_charge = off_self_all,
		},
		hallsFab = {
			pinnacleBoss_conduit_drain = off_self_all,
			taking_aim = off_self_all,
			draining_ballista = off_self_all,
		},
    }

	-- quick get/set value functions
	local function getValue(category, key)
		local setting = savedVars[category][key]
		if type(setting) == "table" then
			return setting.value
		else
			return setting
		end
	end
	local function setValue(category, key, value)
		local setting = savedVars[category][key]
		if type(setting) == "table" and type(value) ~= "table" then
			setting.value = value
		else
			savedVars[category][key] = value
		end
	end

	local index = 0
	local optionsTable = {}
	local subTable     = nil
	local function MakeControlEntry(data, category, key)

		if (category ~= nil and key ~= nil) then
			-- for the majority of the settings 
			data.category = category
			data.key      = key
			
			-- build simple table with zero-based values for choices
			if data.choices and not data.choicesValues then
				data.choicesValues = {}
				for i=1, #data.choices do
					tinsert(data.choicesValues, i-1)
				end
			end

			-- setup default value
			local default = self:GetSetting(defaults, category, key)
			data.default = default
			if type(default) == "table" then
				data.default = default.value -- the rest is handled in our dialog
				-- setup reference if it supports sounds or roles
				if (default.sound ~= nil or default.roles ~= nil) then
					index = index + 1
					data.reference = "RNSettingCtrl"..index
				end
			elseif not data.noAlert then
				index = index + 1
				data.reference = "RNSettingCtrl"..index
			end
			
			-- add get/set functions if they were not provided
			if not data.getFunc then
				data.getFunc = function() return getValue(data.category, data.key) end
			end
			if not data.setFunc then
				data.setFunc = function(value) setValue(data.category, data.key, value) end
			end

		end

		-- add to appropriate table
		if subTable ~= nil and data.type ~= "submenu" then
			tinsert(subTable, data)
		else
			tinsert(optionsTable, data)
		end
	end

	local function MakeSubmenu(title, description)
		subTable = {}
		MakeControlEntry({
			type = "submenu",
			name = title,
			controls = subTable,
		})
		MakeControlEntry({
			type = "description",
			text = description,
		})
		MakeControlEntry({
			type = "divider",
			alpha = 1,
		})
	end

	MakeControlEntry({
		type = "description",
		text = RAIDNOTIFIER_DESCRIPTION,
	})

	MakeControlEntry({
		type = "header",
		name = RAIDNOTIFIER_SETTINGS_GENERAL_HEADER,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_GENERAL_CENTER_SCREEN_ANNOUNCE,
		tooltip = RAIDNOTIFIER_SETTINGS_GENERAL_CENTER_SCREEN_ANNOUNCE_TT,
		noAlert = true,
	}, "general", "use_center_screen_announce")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_GENERAL_BUFFFOOD_REMINDER,
		tooltip = RAIDNOTIFIER_SETTINGS_GENERAL_BUFFFOOD_REMINDER_TT,
	}, "general", "buffFood_reminder")
	MakeControlEntry({
		type = "slider",
		name = RAIDNOTIFIER_SETTINGS_GENERAL_BUFFFOOD_REMINDER_INTERVAL,
		tooltip = RAIDNOTIFIER_SETTINGS_GENERAL_BUFFFOOD_REMINDER_INTERVAL_TT,
		min = 30, max = 120, step = 5,
		noAlert = true,
	}, "general", "buffFood_reminder_interval")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_GENERAL_VANITY_PETS,
		tooltip = RAIDNOTIFIER_SETTINGS_GENERAL_VANITY_PETS_TT,
		noAlert = true,
	}, "general", "vanity_pets")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_GENERAL_NO_ASSISTANTS,
		tooltip = RAIDNOTIFIER_SETTINGS_GENERAL_NO_ASSISTANTS_TT,
		noAlert = true,
	}, "general", "no_assistants")


	MakeSubmenu(RAIDNOTIFIER_SETTINGS_ULTIMATE_HEADER, RAIDNOTIFIER_SETTINGS_ULTIMATE_DESCRIPTION)
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ULTIMATE_ENABLED,
		tooltip = RAIDNOTIFIER_SETTINGS_ULTIMATE_ENABLED_TT,
		getFunc = function() return savedVars.ultimate.enabled end,
		setFunc = function(value)
				savedVars.ultimate.enabled = value
				if self.raidId > 0 then 
					if value then 
						self:RegisterForUltimateChanges()
					else
						self:UnregisterForUltimateChanges()
					end
				end
			end,
		default = false,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ULTIMATE_HIDDEN,
		tooltip = RAIDNOTIFIER_SETTINGS_ULTIMATE_HIDDEN_TT,
		getFunc = function() return savedVars.ultimate.hidden end,
		setFunc = function(value)
				savedVars.ultimate.hidden = value 
				UI.SetElementHidden("ultimate", "ulti_window", value)
			end,
		default = false,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ULTIMATE_USECOLOR,
		tooltip = RAIDNOTIFIER_SETTINGS_ULTIMATE_USECOLOR_TT,
		getFunc = function() return savedVars.ultimate.useColor end,
		setFunc = function(value)
				savedVars.ultimate.useColor = value 
				self:UpdateUltimates()
			end,
		default = true,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ULTIMATE_USEDISPLAYNAME,
		tooltip = RAIDNOTIFIER_SETTINGS_ULTIMATE_USEDISPLAYNAME_TT,
		getFunc = function() return savedVars.ultimate.useDisplayName end,
		setFunc = function(value)
				savedVars.ultimate.useDisplayName = value 
				self:UpdateUltimates()
			end,
		default = false,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWHEALERS,
		tooltip = RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWHEALERS_TT,
		getFunc = function() return savedVars.ultimate.showHealers end,
		setFunc = function(value)
				savedVars.ultimate.showHealers = value 
				self:UpdateUltimates()
			end,
		default = true,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWTANKS,
		tooltip = RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWTANKS_TT,
		getFunc = function() return savedVars.ultimate.showTanks end,
		setFunc = function(value)
				savedVars.ultimate.showTanks = value 
				self:UpdateUltimates()
			end,
		default = true,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWDPS,
		tooltip = RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWDPS_TT,
		getFunc = function() return savedVars.ultimate.showDps end,
		setFunc = function(value)
				savedVars.ultimate.showDps = value 
				self:UpdateUltimates()
			end,
		default = false,
	})
	MakeControlEntry({
		type = "slider",
		min = 0,
        max = 250,
		name = RAIDNOTIFIER_SETTINGS_ULTIMATE_OVERRIDECOST,
		tooltip = RAIDNOTIFIER_SETTINGS_ULTIMATE_OVERRIDECOST_TT,
		getFunc = function() return savedVars.ultimate.override_cost end,
		setFunc = function(value) savedVars.ultimate.override_cost = value end,
		default = 0,
	})
	subTable = nil --end submenu



	MakeSubmenu(RAIDNOTIFIER_SETTINGS_PROFILE_HEADER, RAIDNOTIFIER_SETTINGS_PROFILE_DESCRIPTION)
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_PROFILE_USEGLOBAL,
		tooltip = RAIDNOTIFIER_SETTINGS_PROFILE_USEGLOBAL_TT,
		warning = RAIDNOTIFIER_SETTINGS_PROFILE_USEGLOBAL_WARNING,
		getFunc = function()
			return RNVars.Default[GetDisplayName()]["$AccountWide"].useAccountWide 
		end,
		setFunc = function(value) 
			RNVars.Default[GetDisplayName()]["$AccountWide"].useAccountWide = value
			ReloadUI()
		end,
		default = true,
	})
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_PROFILE_COPY,
		tooltip = RAIDNOTIFIER_SETTINGS_PROFILE_COPY_TT,
		choices = profileCopyList,
		getFunc = function()
			if (#profileCopyList >= 1) then -- there are entries, set first as default
				profileCopyToCopy = profileCopyList[1]
				return profileCopyList[1]
			end
		end,
		setFunc = function(value)
			profileCopyToCopy = value
		end,
		disabled = function() return not profileGuard end,
	})
	MakeControlEntry({
		type = "button",
		name = RAIDNOTIFIER_SETTINGS_PROFILE_COPYBUTTON,
		warning = RAIDNOTIFIER_SETTINGS_PROFILE_COPYBUTTON,
		func = function(btn)  CopyProfile() end,
		disabled = function() return not profileGuard end,
	})
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_PROFILE_DELETE,
		tooltip = RAIDNOTIFIER_SETTINGS_PROFILE_DELETE_TT,
		choices = profileDeleteList,
		getFunc = function()
			if (#profileDeleteList >= 1) then
				if (not profileDeleteToDelete) then -- nothing selected yet, return first
					profileDeleteToDelete = profileDeleteList[1]
					return profileDeleteList[1]
				else
					return profileDeleteToDelete
				end
			end
		end,
		setFunc = function(value)
			profileDeleteToDelete = value
		end,
		disabled = function() return not profileGuard end,
		reference = "RNSettingDeleteDropRef",
	})
	MakeControlEntry({
		type = "button",
		name = RAIDNOTIFIER_SETTINGS_PROFILE_DELETEBUTTON,
		func = function(btn)  DeleteProfile() end,
		disabled = function() return not profileGuard end,
	})
	MakeControlEntry({type = "divider", alpha = 1})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_PROFILE_GUARD,
		getFunc = function() return profileGuard end,
		setFunc = function(value)   profileGuard = value end,
	})
	subTable = nil --end submenu


	MakeControlEntry({
		type = "header",
		name = RAIDNOTIFIER_SETTINGS_TRIALS_HEADER
	})
	MakeControlEntry({
		type = "description",
		text = RAIDNOTIFIER_SETTINGS_TRIALS_DESCRIPTION
	})

	-- Hel Ra Citadel
	MakeSubmenu(RAIDNOTIFIER_SETTINGS_HELRA_HEADER, RaidNotifier:GetRaidDescription(RAID_HEL_RA_CITADEL))
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_HELRA_YOKEDA_METEOR,
		tooltip = RAIDNOTIFIER_SETTINGS_HELRA_YOKEDA_METEOR_TT,
		choices = choices.helra.yokeda_meteor,
		disabled = function() return not self:IsDevMode() end,
		warning = RAIDNOTIFIER_SETTINGS_DEBUG_DEVMODE_WARNING,
	}, "helra", "yokeda_meteor")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_HELRA_WARRIOR_STONEFORM,
		tooltip = RAIDNOTIFIER_SETTINGS_HELRA_WARRIOR_STONEFORM_TT,
		choices = choices.helra.warrior_stoneform,
	}, "helra", "warrior_stoneform")
	subTable = nil --end submenu


	-- Aetherius Archive
	MakeSubmenu(RAIDNOTIFIER_SETTINGS_ARCHIVE_HEADER, RaidNotifier:GetRaidDescription(RAID_AETHERIAN_ARCHIVE))
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ARCHIVE_STORMATRO_IMPENDINGSTORM,
		tooltip = RAIDNOTIFIER_SETTINGS_ARCHIVE_STORMATRO_IMPENDINGSTORM_TT,
	}, "archive", "stormatro_impendingstorm")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ARCHIVE_STORMATRO_LIGHTNINGSTORM,
		tooltip = RAIDNOTIFIER_SETTINGS_ARCHIVE_STORMATRO_LIGHTNINGSTORM_TT,
	}, "archive", "stormatro_lightningstorm")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ARCHIVE_STONEATRO_BOULDERSTORM,
		tooltip = RAIDNOTIFIER_SETTINGS_ARCHIVE_STONEATRO_BOULDERSTORM_TT,
	}, "archive", "stoneatro_boulderstorm")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_ARCHIVE_STONEATRO_BIGQUAKE,
		tooltip = RAIDNOTIFIER_SETTINGS_ARCHIVE_STONEATRO_BIGQUAKE_TT,
	}, "archive", "stoneatro_bigquake")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_ARCHIVE_OVERCHARGE,
		tooltip = RAIDNOTIFIER_SETTINGS_ARCHIVE_OVERCHARGE_TT,
		choices = choices.archive.overcharge,
	}, "archive", "overcharge")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_ARCHIVE_CALL_LIGHTNING,
		tooltip = RAIDNOTIFIER_SETTINGS_ARCHIVE_CALL_LIGHTNING_TT,
		choices = choices.archive.call_lightning,
	}, "archive", "call_lightning")
	subTable = nil --end submenu


	-- Sanctum Ophidia
	MakeSubmenu(RAIDNOTIFIER_SETTINGS_SANCTUM_HEADER, RaidNotifier:GetRaidDescription(RAID_SANCTUM_OPHIDIA))
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_SANCTUM_MANTIKORA_QUAKE,
		tooltip = RAIDNOTIFIER_SETTINGS_SANCTUM_MANTIKORA_QUAKE_TT,
	}, "sanctumOphidia", "mantikora_quake")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_SANCTUM_MAGICKA_DETONATION,
		tooltip = RAIDNOTIFIER_SETTINGS_SANCTUM_MAGICKA_DETONATION_TT,
	}, "sanctumOphidia", "magicka_deto")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_SANCTUM_SERPENT_POISON,
		tooltip = RAIDNOTIFIER_SETTINGS_SANCTUM_SERPENT_POISON_TT,
		choices = choices.sanctumOphidia.serpent_poison,
	}, "sanctumOphidia", "serpent_poison")
	MakeControlEntry({
	    type = "checkbox",
	    name = RAIDNOTIFIER_SETTINGS_SANCTUM_SERPENT_WORLD_SHAPER,
	    tooltip = RAIDNOTIFIER_SETTINGS_SANCTUM_SERPENT_WORLD_SHAPER_TT,
		disabled = function() return not self:IsDevMode() end,
		warning = RAIDNOTIFIER_SETTINGS_DEBUG_DEVMODE_WARNING,
	}, "sanctumOphidia", "serpent_world_shaper")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_SANCTUM_TROLL_BOULDER,
		tooltip = RAIDNOTIFIER_SETTINGS_SANCTUM_TROLL_BOULDER_TT,
		choices = choices.sanctumOphidia.troll_boulder,
	}, "sanctumOphidia", "troll_boulder")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_SANCTUM_TROLL_POISON,
		tooltip = RAIDNOTIFIER_SETTINGS_SANCTUM_TROLL_POISON_TT,
		choices = choices.sanctumOphidia.troll_poison,
	}, "sanctumOphidia", "troll_poison")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_SANCTUM_OVERCHARGE,
		tooltip = RAIDNOTIFIER_SETTINGS_SANCTUM_OVERCHARGE_TT,
		choices = choices.sanctumOphidia.overcharge,
	}, "sanctumOphidia", "overcharge")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_SANCTUM_CALL_LIGHTNING,
		tooltip = RAIDNOTIFIER_SETTINGS_SANCTUM_CALL_LIGHTNING_TT,
		choices = choices.sanctumOphidia.call_lightning,
	}, "sanctumOphidia", "call_lightning")
	subTable = nil --end submenu


	-- Maw of Lorkhaj
	MakeSubmenu(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_HEADER, RaidNotifier:GetRaidDescription(RAID_MAW_OF_LORKHAJ))
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GRIPOFLORKHAJ,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GRIPOFLORKHAJ_TT,
	}, "mawLorkhaj", "zhaj_gripoflorkhaj")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GLYPHS,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GLYPHS_TT,
		getFunc = function() return savedVars.mawLorkhaj.zhaj_glyphs end,
		setFunc = function(value)   
					savedVars.mawLorkhaj.zhaj_glyphs = value 
					RaidNotifier.OnBossesChanged()
				end,
		noAlert = true,
	}, "mawLorkhaj", "zhaj_glyphs")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GLYPHS_INVERT,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GLYPHS_INVERT_TT,
		getFunc = function() return savedVars.mawLorkhaj.zhaj_glyphs_invert end,
		setFunc = function(value)   savedVars.mawLorkhaj.zhaj_glyphs_invert = value; UI.InvertGlyphs() end,
		disabled = function() return not savedVars.mawLorkhaj.zhaj_glyphs end, 
		noAlert = true,
	}, "mawLorkhaj", "zhaj_glyphs_invert")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_TWIN_ASPECTS,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_TWIN_ASPECTS_TT,
		choices = choices.mawLorkhaj.twinBoss_aspects,
	}, "mawLorkhaj", "twinBoss_aspects")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_UNSTABLE_VOID,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_UNSTABLE_VOID_TT,
		choices = choices.mawLorkhaj.rakkhat_unstablevoid,
	}, "mawLorkhaj", "rakkhat_unstablevoid")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_THRESHINGWINGS,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_THRESHINGWINGS_TT,
	}, "mawLorkhaj", "rakkhat_threshingwings")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_DARKNESSFALLS,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_DARKNESSFALLS_TT,
	}, "mawLorkhaj", "rakkhat_darknessfalls")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_DARKBARRAGE,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_DARKBARRAGE_TT,
	}, "mawLorkhaj", "rakkhat_darkbarrage")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_LUNARBASTION1,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_LUNARBASTION1_TT,
		choices = choices.mawLorkhaj.rakkhat_lunarbastion1,
	}, "mawLorkhaj", "rakkhat_lunarbastion1")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_LUNARBASTION2,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_LUNARBASTION2_TT,
		choices = choices.mawLorkhaj.rakkhat_lunarbastion2,
	}, "mawLorkhaj", "rakkhat_lunarbastion2")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_SHATTERED,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_SHATTERED_TT,
	}, "mawLorkhaj", "shattered")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_SUNEATER_ECLIPSE,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_SUNEATER_ECLIPSE_TT,
		choices = choices.mawLorkhaj.suneater_eclipse,
	}, "mawLorkhaj", "suneater_eclipse")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_MARKEDFORDEATH,
		tooltip = RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_MARKEDFORDEATH_TT,
	}, "mawLorkhaj", "markedfordeath")
	subTable = nil --end submenu


	-- Dragonstar Arena
	MakeSubmenu(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_HEADER, RaidNotifier:GetRaidDescription(RAID_DRAGONSTAR_ARENA))
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_GENERAL_TAKING_AIM,
		tooltip = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_GENERAL_TAKING_AIM_TT,
	}, "dragonstar", "general_taking_aim")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_GENERAL_CRYSTAL_BLAST,
		tooltip = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_GENERAL_CRYSTAL_BLAST_TT,
	}, "dragonstar", "general_crystal_blast")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA2_CRUSHING_SHOCK,
		tooltip = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA2_CRUSHING_SHOCK_TT,
	}, "dragonstar", "arena2_crushing_shock")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA6_DRAIN_RESOURCE,
		tooltip = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA6_DRAIN_RESOURCE_TT,
		choices = choices.dragonstar.arena6_drain_resource,
	}, "dragonstar", "arena6_drain_resource")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA7_UNSTABLE_CORE,
		tooltip = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA7_UNSTABLE_CORE_TT,
	}, "dragonstar", "arena7_unstable_core")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA8_FIRE_CHARGE,
		tooltip = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA8_FIRE_CHARGE_TT,
		choices = choices.dragonstar.arena8_fire_charge,
	}, "dragonstar", "arena8_fire_charge")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA8_ICE_CHARGE,
		tooltip = RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA8_ICE_CHARGE_TT,
		choices = choices.dragonstar.arena8_ice_charge,
	}, "dragonstar", "arena8_ice_charge")
	subTable = nil --end submenu


	-- Maelstrom Arena
	MakeSubmenu(RAIDNOTIFIER_SETTINGS_MAELSTROM_HEADER, RaidNotifier:GetRaidDescription(RAID_MAELSTROM_ARENA))
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_MAELSTROM_STAGE7_POISON,
		tooltip = RAIDNOTIFIER_SETTINGS_MAELSTROM_STAGE7_POISON_TT,
	}, "maelstrom", "stage7_poison")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_MAELSTROM_STAGE9_SYNERGY,
		tooltip = RAIDNOTIFIER_SETTINGS_MAELSTROM_STAGE9_SYNERGY_TT,
	}, "maelstrom", "stage9_synergy")
	subTable = nil --end submenu


	-- Halls of Fabrication
	MakeSubmenu(RAIDNOTIFIER_SETTINGS_HALLSFAB_HEADER, RaidNotifier:GetRaidDescription(RAID_HALLS_OF_FABRICATION))
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_TAKING_AIM,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_TAKING_AIM_TT,
		choices = choices.hallsFab.taking_aim,
	}, "hallsFab", "taking_aim")
	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_DRAINING_BALLISTA,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_DRAINING_BALLISTA_TT,
		choices = choices.hallsFab.draining_ballista,
	}, "hallsFab", "draining_ballista")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_STRIKE,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_STRIKE_TT,
	}, "hallsFab", "conduit_strike")
   	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_POWER_LEECH,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_POWER_LEECH_TT,
	}, "hallsFab", "power_leech")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_SCALDED_DEBUFF,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_SCALDED_DEBUFF_TT,
		--disabled = function() return not self:IsDevMode() end,
		--warning = RAIDNOTIFIER_SETTINGS_DEBUG_DEVMODE_WARNING,
		noAlert = true,
	}, "hallsFab", "pinnacleBoss_scalded")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_SPAWN,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_SPAWN_TT,
   }, "hallsFab", "pinnacleBoss_conduit_spawn")
  	MakeControlEntry({
		type = "dropdown",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_DRAIN,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_DRAIN_TT,
		choices = choices.hallsFab.pinnacleBoss_conduit_drain,
	}, "hallsFab", "pinnacleBoss_conduit_drain")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_OVERPOWER_AURAS,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_OVERPOWER_AURAS_TT,
	}, "hallsFab", "committee_overpower_auras")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_OVERPOWER_AURAS_DYNAMIC,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_OVERPOWER_AURAS_DYNAMIC_TT,
		disabled = function() return not self:IsDevMode() or not savedVars.hallsFab.committee_overpower_auras end,
		warning = RAIDNOTIFIER_SETTINGS_DEBUG_DEVMODE_WARNING,
		noAlert = true,
	}, "hallsFab", "committee_overpower_auras_dynamic")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_FABRICANT_SPAWN,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_FABRICANT_SPAWN_TT,
	}, "hallsFab", "committee_fabricant_spawn")
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_HALLSFAB_RECLAIM_ACHIEVE,
		tooltip = RAIDNOTIFIER_SETTINGS_HALLSFAB_RECLAIM_ACHIEVE_TT,
	}, "hallsFab", "committee_reclaim_achieve")
	subTable = nil --end submenu


	MakeControlEntry({
		type = "header",
		name = RAIDNOTIFIER_SETTINGS_DEBUG_HEADER,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_DEBUG,
		tooltip = RAIDNOTIFIER_SETTINGS_DEBUG_TT,
		getFunc = function() return savedVars.dbg.enabled end,
		setFunc = function(value)   savedVars.dbg.enabled = value end,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_DEBUG_DEVMODE,
		tooltip = RAIDNOTIFIER_SETTINGS_DEBUG_DEVMODE_TT,
		getFunc = function() return savedVars.dbg.devMode end,
		setFunc = function(value)   savedVars.dbg.devMode = value end,
	})
	MakeSubmenu(RAIDNOTIFIER_SETTINGS_DEBUG_TRACKER_HEADER, RAIDNOTIFIER_SETTINGS_DEBUG_TRACKER_DESCRIPTION)
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_DEBUG_TRACKER_ENABLED,
		--tooltip = RAIDNOTIFIER_SETTINGS_DEBUG_TRACKER_ENABLED_TT, -- dont need tooltip for this
		getFunc = function() return savedVars.dbg.tracker end,
		setFunc = function(value)
				savedVars.dbg.tracker = value 
				self:ToggleDebugTracker(savedVars.dbg.tracker)
			end,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_DEBUG_TRACKER_SPAMCONTROL,
		tooltip = RAIDNOTIFIER_SETTINGS_DEBUG_TRACKER_SPAMCONTROL_TT,
		getFunc = function() return savedVars.dbg.spamControl end,
		setFunc = function(value)   savedVars.dbg.spamControl = value end,
		disabled = function() return not savedVars.dbg.tracker end,
	})
	MakeControlEntry({
		type = "checkbox",
		name = RAIDNOTIFIER_SETTINGS_DEBUG_TRACKER_MYENEMYONLY,
		tooltip = RAIDNOTIFIER_SETTINGS_DEBUG_TRACKER_MYENEMYONLY_TT,
		getFunc = function() return savedVars.dbg.myEnemyOnly end,
		setFunc = function(value)   savedVars.dbg.myEnemyOnly = value end,
		disabled = function() return not savedVars.dbg.tracker end,
	})
	subTable = nil --end submenu



	self.optionsData = optionsTable
	LAM:RegisterAddonPanel("RaidNotifierPanel", self.panelData)
	LAM:RegisterOptionControls("RaidNotifierPanel", self.optionsData)


	--function RaidNotifier:GetSoundValue(category, key)
	--	local setting = self:GetSetting(savedVars, category, key)
	--	return setting.sound 
	--end
	--function RaidNotifier:SetSoundValue(category, key, value)
	--	local setting = self:GetSetting(savedVars, category, key)
	--	setting.sound = value
	--end


	local function InitializeCustomDialog()
		local customControl = RaidNotifier_ConfigDialog
		
		local function SetupDialog(dialog, data)
			customControl.selectSound = customControl:GetNamedChild("SelectSound")
			customControl.selectedSoundID = self:GetSoundValue(data.category, data.key)
			customControl.selectSound.dropdown:SetSelectedItemText(self:GetSoundName(customControl.selectedSoundID))
		end
	
		local function OnDialogConfirm(dialog)
			self:SetSoundValue(dialog.data.category, dialog.data.key, dialog.selectedSoundID)
		end

	    ZO_Dialogs_RegisterCustomDialog("RAID_NOTIFIER_CONFIG_DIALOG",
		{
			customControl = customControl,
			title =
			{
				text = "Select Sound Dialog",
			},
			mainText =
			{
				text = "Chose the sound to use for this alert",
			},
			setup = SetupDialog,
			buttons =
			{
				{
					control = customControl:GetNamedChild("Confirm"),
					text = SI_DIALOG_CONFIRM,
					callback = OnDialogConfirm,
				},
				{
					control = customControl:GetNamedChild("Cancel"),
					text = SI_DIALOG_CANCEL,
				}
			}
		})
		
		local function OnSoundSelected(comboBox, entryText, entry)
			customControl.selectedSoundID = entry.id
			PlaySound(entry.id)
		end
		
		local function PopulateSoundDropdown(comboBox)

			comboBox:SetSortsItems(false)
			for _, entry in pairs(self:GetSounds()) do
				entry.callback = OnSoundSelected
				comboBox:AddItem(entry, ZO_COMBOBOX_SUPRESS_UPDATE)
			end
			comboBox:UpdateItems()
		end

		PopulateSoundDropdown(customControl:GetNamedChild("SelectSound").dropdown)
	end

	local function OnPanelCreation(panel)
		if panel:GetName() ~= "RaidNotifierPanel" then return end

		InitializeCustomDialog()

		--store reference
		profileDeleteDropRef = RNSettingDeleteDropRef

		local function GetConfigButtonTooltipText(control)
			return string.format("Sound: %s", self:GetSoundName(nil, control.data.category, control.data.key))
		end

		--loop through controls to add our Sound-Config-Button-Clicky-Thing (tm)
		for i = 1, index do
			local control = GetControl("RNSettingCtrl"..i)
			if (control) then
				--local setting = self:GetSetting(savedVars, control.data.category, control.data.key)
				--if (type(setting) == "table" and setting.sound ~= nil) then
				if (control and not control.data.noAlert) then
					control.soundBtn = WINDOW_MANAGER:CreateControlFromVirtual(nil, control, "RaidNotifier_ConfigButton")
					control.soundBtn:SetAnchor(RIGHT, control.combobox or control[control.data.type], LEFT, -1, 0)
					control.soundBtn:SetHandler("OnClicked", function() 
							ZO_Dialogs_ShowDialog("RAID_NOTIFIER_CONFIG_DIALOG", control.data)
						end)
					control.soundBtn.data = {tooltipText=function() return GetConfigButtonTooltipText(control) end}
					control.soundBtn:SetHidden(false)
					
					-- re-anchor the warning control
					if control.warning then
						control.warning:ClearAnchors()
						control.warning:SetAnchor(RIGHT, control.soundBtn, LEFT, 5, 0)
					end
				end
			end
		end
		
	end
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", OnPanelCreation)

end


function RaidNotifier:TryConvertSettings(settings, defaults)

	for category,content in pairs(defaults) do
		if (category ~= "useAccountWide") then
			for key, default in pairs(content) do
				local value = settings[category][key]
				if type(value) ~= type(default) then --type mismatch
					if type(default) == "table" then -- advanced structure, try to preserve old value
						settings[category][key] = Util.CopyTable(default) -- store value
						if type(default.value) == type(value) then
							self.p("Converted '%s -> %s' and keeping old value: %s", category, key, tostring(value))
							settings[category][key].value = value
						else
							self.p("Converted '%s -> %s' and types mismatch, new value: %s", category, key, tostring(default.value))
						end
						-- try to preserve sound setting
						local soundId = settings.sounds[category.."_"..key]
						if soundId ~= nil then
							self.p("Preserved soundId '%s'", soundId)
							settings[category][key].sound = soundId
						end
					else
						settings[category][key] = default
						self.p("Mismatching type for '%s -> %s', new value: %s", category, key, tostring(default))
					end
				end
			end
		end
	end

end

