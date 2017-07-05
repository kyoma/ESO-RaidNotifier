local RaidNotifier = RaidNotifier
local UI = RaidNotifier.UI

-- Constants for easy reading
local RAID_HEL_RA_CITADEL        = 1
local RAID_AETHERIAN_ARCHIVE     = 2
local RAID_SANCTUM_OPHIDIA       = 3
local RAID_DRAGONSTAR_ARENA      = 4
local RAID_MAW_OF_LORKHAJ        = 5
local RAID_MAELSTROM_ARENA       = 6
local RAID_HALLS_OF_FABRICATION  = 7

RaidNotifier.Defaults = {
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
		magicka_deto      = true,
		serpent_poison    = 1, --"Normal"
		--serpent_worldshaper = 2, --"Near"
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
		draining_ballista     = 1, --
		power_leech           = false,

		pinnacleBoss_conduit_spawn = true,
		pinnacleBoss_conduit_drain = 0, -- "Off"

		committee_overpower_auras = false,
		committee_fabricant_spawn = false,
		committee_reclaim_achieve = false,
	}, 

	dbg = {
		enable = false,
		notify = false,
		tracker = false,
		spamControl = true,
		verbose = false,
	},

}

function RaidNotifier:CreateSettingsMenu()

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
			serpent_worldshaper = {
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_OFF),
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_SELF), 
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_NEAR), 
				GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CHOICES_ALL), 
			},
			troll_boulder  = off_self_all,
			troll_poison   = off_self_all,
			overcharge     = off_self_all,
			call_lightning = off_self_all,
		},
		helra = {
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
	
	local Vars = RaidNotifier.Vars

	local function getChoiceValue(category, key)
		return choices[category][key][ Vars[category][key] + 1 ]
	end
	local function setChoiceValue(category, key, value)
		for i, str in ipairs(choices[category][key]) do
			if value == str then
				Vars[category][key] = i - 1
			end
		end
	end
	local function getDefaultChoiceValue(category, key)
		return choices[category][key][ RaidNotifier.Defaults[category][key] + 1 ]
	end

	local index = 0
	local optionsTable = {}
	local subTable     = nil
	local function MakeControlEntry(data, category, setting)
		index = index + 1
		data.reference = "RNSettingCtrl"..index
		if (category ~= nil and setting ~= nil) then
			data.category = category
			data.setting = setting
			data.default = (data.type == "dropdown" and getDefaultChoiceValue(category, setting) or RaidNotifier.Defaults[category][setting])
		else
			data.noSound = true
		end
		if subTable ~= nil and data.type ~= "submenu" then
			table.insert(subTable, data)
		else
			table.insert(optionsTable, data)
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
		text = GetString(RAIDNOTIFIER_DESCRIPTION),
	})

	MakeControlEntry({
		type = "header",
		name = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_HEADER),
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CENTER_SCREEN_ANNOUNCE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_CENTER_SCREEN_ANNOUNCE_TT),
		getFunc = function() return Vars.general.use_center_screen_announce end,
		setFunc = function(value)   Vars.general.use_center_screen_announce = value end,
		default = true,
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_BUFFFOOD_REMINDER),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_BUFFFOOD_REMINDER_TT),
		getFunc = function() return Vars.general.buffFood_reminder end,
		setFunc = function(value)   Vars.general.buffFood_reminder = value end,
		default = true,
	}, "general", "buffFood_reminder")
	MakeControlEntry({
		type = "slider",
		name = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_BUFFFOOD_REMINDER_INTERVAL),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_BUFFFOOD_REMINDER_INTERVAL_TT),
		min = 30,
		max = 120,
		step = 5,
		getFunc = function() return Vars.general.buffFood_reminder_interval end,
		setFunc = function(value)   Vars.general.buffFood_reminder_interval = value end,
		default = 60,
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_VANITY_PETS),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_VANITY_PETS_TT),
		getFunc = function() return Vars.general.vanity_pets end,
		setFunc = function(value)   Vars.general.vanity_pets = value end,
		default = true,
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_NO_ASSISTANTS),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_GENERAL_NO_ASSISTANTS_TT),
		getFunc = function() return Vars.general.no_assistants end,
		setFunc = function(value)   Vars.general.no_assistants = value end,
		default = true,
	})


	MakeSubmenu(GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_HEADER), GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_DESCRIPTION))
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_ENABLED),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_ENABLED_TT),
		getFunc = function() return Vars.ultimate.enabled end,
		setFunc = function(value)
				Vars.ultimate.enabled = value
				if self.raidId > 0 then 
					if value then 
						self:RegisterForUltimateChanges()
					else
						self:UnregisterForUltimateChanges()
					end
				end
			end,
		default = true,
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_HIDDEN),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_HIDDEN_TT),
		getFunc = function() return Vars.ultimate.hidden end,
		setFunc = function(value)
				Vars.ultimate.hidden = value 
				UI.SetElementHidden("ultimate", "ulti_window", value)
			end,
		default = false,
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_USECOLOR),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_USECOLOR_TT),
		getFunc = function() return Vars.ultimate.useColor end,
		setFunc = function(value)
				Vars.ultimate.useColor = value 
			end,
		default = true,
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_USEDISPLAYNAME),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_USEDISPLAYNAME_TT),
		getFunc = function() return Vars.ultimate.useDisplayName end,
		setFunc = function(value)
				Vars.ultimate.useDisplayName = value 
				self:UpdateUltimates()
			end,
		default = false,
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWHEALERS),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWHEALERS_TT),
		getFunc = function() return Vars.ultimate.showHealers end,
		setFunc = function(value)
				Vars.ultimate.showHealers = value 
				self:UpdateUltimates()
			end,
		default = true,
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWTANKS),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWTANKS_TT),
		getFunc = function() return Vars.ultimate.showTanks end,
		setFunc = function(value)
				Vars.ultimate.showTanks = value 
				self:UpdateUltimates()
			end,
		default = true,
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWDPS),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_SHOWDPS_TT),
		getFunc = function() return Vars.ultimate.showDps end,
		setFunc = function(value)
				Vars.ultimate.showDps = value 
				self:UpdateUltimates()
			end,
		default = false,
	})
	MakeControlEntry({
		type = "slider",
		min = 0,
        max = 250,
		name = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_OVERRIDECOST),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ULTIMATE_OVERRIDECOST_TT),
		getFunc = function() return Vars.ultimate.override_cost end,
		setFunc = function(value) Vars.ultimate.override_cost = value end,
		default = 0,
	})
	subTable = nil


	
	MakeControlEntry({
		type = "header",
		name = GetString(RAIDNOTIFIER_SETTINGS_TRIALS_HEADER)
	})
	MakeControlEntry({
		type = "description",
		text = GetString(RAIDNOTIFIER_SETTINGS_TRIALS_DESCRIPTION)
	})

	-- Hel Ra Citadel
	MakeSubmenu(GetString(RAIDNOTIFIER_SETTINGS_HELRA_HEADER), RaidNotifier:GetRaidDescription(RAID_HEL_RA_CITADEL))
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_HELRA_WARRIOR_STONEFORM),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_HELRA_WARRIOR_STONEFORM_TT),
		choices = choices.helra.warrior_stoneform,
		getFunc = function() return getChoiceValue("helra", "warrior_stoneform") end,
		setFunc = function(value)   setChoiceValue("helra", "warrior_stoneform", value) end,
	}, "helra", "warrior_stoneform")
	subTable = nil


	-- Aetherius Archive
	MakeSubmenu(GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_HEADER), RaidNotifier:GetRaidDescription(RAID_AETHERIAN_ARCHIVE))
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_STORMATRO_IMPENDINGSTORM),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_STORMATRO_IMPENDINGSTORM_TT),
		getFunc = function() return Vars.archive.stormatro_impendingstorm end,
		setFunc = function(value)   Vars.archive.stormatro_impendingstorm = value end,
	}, "archive", "stormatro_impendingstorm")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_STORMATRO_LIGHTNINGSTORM),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_STORMATRO_LIGHTNINGSTORM_TT),
		getFunc = function() return Vars.archive.stormatro_lightningstorm end,
		setFunc = function(value)   Vars.archive.stormatro_lightningstorm = value end,
	}, "archive", "stormatro_lightningstorm")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_STONEATRO_BOULDERSTORM),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_STONEATRO_BOULDERSTORM_TT),
		getFunc = function() return Vars.archive.stoneatro_boulderstorm end,
		setFunc = function(value)   Vars.archive.stoneatro_boulderstorm = value end,
	}, "archive", "stoneatro_boulderstorm")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_STONEATRO_BIGQUAKE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_STONEATRO_BIGQUAKE_TT),
		getFunc = function() return Vars.archive.stoneatro_bigquake end,
		setFunc = function(value)   Vars.archive.stoneatro_bigquake = value end,
	}, "archive", "stoneatro_bigquake")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_OVERCHARGE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_OVERCHARGE_TT),
		choices = choices.archive.overcharge,
		getFunc = function() return getChoiceValue("archive", "overcharge") end,
		setFunc = function(value)   setChoiceValue("archive", "overcharge", value) end,
	}, "archive", "overcharge")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_CALL_LIGHTNING),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_ARCHIVE_CALL_LIGHTNING_TT),
		choices = choices.archive.call_lightning,
		getFunc = function() return getChoiceValue("archive", "call_lightning") end,
		setFunc = function(value)   setChoiceValue("archive", "call_lightning", value) end,
	}, "archive", "call_lightning")
	subTable = nil


	-- Sanctum Ophidia
	MakeSubmenu(GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_HEADER), RaidNotifier:GetRaidDescription(RAID_SANCTUM_OPHIDIA))
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_MANTIKORA_QUAKE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_MANTIKORA_QUAKE_TT),
		getFunc = function() return Vars.sanctumOphidia.mantikora_quake end,
		setFunc = function(value)   Vars.sanctumOphidia.mantikora_quake = value end,
	}, "sanctumOphidia", "mantikora_quake")
	--MakeControlEntry({
	--    type = "dropdown",
	--    name = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_MANTIKORA_SPEAR),
	--    tooltip = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_MANTIKORA_SPEAR_TT),
	--    choices = choices.sanctumOphidia.mantikora_spear,
	--    getFunc = function() return getChoiceValue("sanctumOphidia", "mantikora_spear") end,
	--    setFunc = function(value)   setChoiceValue("sanctumOphidia", "mantikora_spear", value) end,
	--    default = 1,
	--}, "sanctumOphidia", "mantikora_spear")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_MAGICKA_DETONATION),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_MAGICKA_DETONATION_TT),
		getFunc = function() return Vars.sanctumOphidia.magicka_deto end,
		setFunc = function(value)   Vars.sanctumOphidia.magicka_deto = value end,
	}, "sanctumOphidia", "magicka_deto")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_SERPENT_POISON),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_SERPENT_POISON_TT),
		choices = choices.sanctumOphidia.serpent_poison,
		getFunc = function() return getChoiceValue("sanctumOphidia", "serpent_poison") end,
		setFunc = function(value)   setChoiceValue("sanctumOphidia", "serpent_poison", value) end,
	}, "sanctumOphidia", "serpent_poison")
	--MakeControlEntry({
	--    type = "dropdown",
	--    name = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_SERPENT_WORLDSHAPER),
	--    tooltip = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_SERPENT_WORLDSHAPER_TT),
	--	choices = choices.sanctumOphidia.serpent_worldshaper,
	--    getFunc = function() return getChoiceValue("sanctumOphidia", "serpent_worldshaper") end,
	--    setFunc = function(value)   setChoiceValue("sanctumOphidia", "serpent_worldshaper", value) end,
	--	default = 2,
	--}, "sanctumOphidia", "serpent_worldshaper")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_TROLL_BOULDER),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_TROLL_BOULDER_TT),
		choices = choices.sanctumOphidia.troll_boulder,
		getFunc = function() return getChoiceValue("sanctumOphidia", "troll_boulder") end,
		setFunc = function(value)   setChoiceValue("sanctumOphidia", "troll_boulder", value) end,
	}, "sanctumOphidia", "troll_boulder")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_TROLL_POISON),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_TROLL_POISON_TT),
		choices = choices.sanctumOphidia.troll_poison,
		getFunc = function() return getChoiceValue("sanctumOphidia", "troll_poison") end,
		setFunc = function(value)   setChoiceValue("sanctumOphidia", "troll_poison", value) end,
	}, "sanctumOphidia", "troll_poison")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_OVERCHARGE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_OVERCHARGE_TT),
		choices = choices.sanctumOphidia.overcharge,
		getFunc = function() return getChoiceValue("sanctumOphidia", "overcharge") end,
		setFunc = function(value)   setChoiceValue("sanctumOphidia", "overcharge", value) end,
	}, "sanctumOphidia", "overcharge")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_CALL_LIGHTNING),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_SANCTUM_CALL_LIGHTNING_TT),
		choices = choices.sanctumOphidia.call_lightning,
		getFunc = function() return getChoiceValue("sanctumOphidia", "call_lightning") end,
		setFunc = function(value)   setChoiceValue("sanctumOphidia", "call_lightning", value) end,
	}, "sanctumOphidia", "call_lightning")
	subTable = nil


	-- Maw of Lorkhaj
	MakeSubmenu(GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_HEADER), RaidNotifier:GetRaidDescription(RAID_MAW_OF_LORKHAJ))
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GRIPOFLORKHAJ),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GRIPOFLORKHAJ_TT),
		getFunc = function() return Vars.mawLorkhaj.zhaj_gripoflorkhaj end,
		setFunc = function(value)   Vars.mawLorkhaj.zhaj_gripoflorkhaj = value end,
	}, "mawLorkhaj", "zhaj_gripoflorkhaj")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GLYPHS),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GLYPHS_TT),
		getFunc = function() return Vars.mawLorkhaj.zhaj_glyphs end,
		setFunc = function(value)   
					Vars.mawLorkhaj.zhaj_glyphs = value 
					self.UI.SetElementHidden("mawLorkhaj", "zhaj_glyph_window", not value)
				end,
		noSound = true,
	}, "mawLorkhaj", "zhaj_glyphs")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GLYPHS_INVERT),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_ZHAJ_GLYPHS_INVERT_TT),
		getFunc = function() return Vars.mawLorkhaj.zhaj_glyphs_invert end,
		setFunc = function(value)   Vars.mawLorkhaj.zhaj_glyphs_invert = value; UI.InvertGlyphs() end,
		disabled = function() return not Vars.mawLorkhaj.zhaj_glyphs end, 
		noSound = true,
	}, "mawLorkhaj", "zhaj_glyphs_invert")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_TWIN_ASPECTS),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_TWIN_ASPECTS_TT),
		choices = choices.mawLorkhaj.twinBoss_aspects,
		getFunc = function() return getChoiceValue("mawLorkhaj", "twinBoss_aspects") end,
		setFunc = function(value)   setChoiceValue("mawLorkhaj", "twinBoss_aspects", value) end,
	}, "mawLorkhaj", "twinBoss_aspects")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_UNSTABLE_VOID),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_UNSTABLE_VOID_TT),
		choices = choices.mawLorkhaj.rakkhat_unstablevoid,
		getFunc = function() return getChoiceValue("mawLorkhaj", "rakkhat_unstablevoid") end,
		setFunc = function(value)   setChoiceValue("mawLorkhaj", "rakkhat_unstablevoid", value) end,
	}, "mawLorkhaj", "rakkhat_unstablevoid")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_THRESHINGWINGS),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_THRESHINGWINGS_TT),
		getFunc = function() return Vars.mawLorkhaj.rakkhat_threshingwings end,
		setFunc = function(value)   Vars.mawLorkhaj.rakkhat_threshingwings = value end,
	}, "mawLorkhaj", "rakkhat_threshingwings")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_DARKNESSFALLS),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_DARKNESSFALLS_TT),
		getFunc = function() return Vars.mawLorkhaj.rakkhat_darknessfalls end,
		setFunc = function(value)   Vars.mawLorkhaj.rakkhat_darknessfalls = value end,
		default = false,
	}, "mawLorkhaj", "rakkhat_darknessfalls")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_DARKBARRAGE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_DARKBARRAGE_TT),
		getFunc = function() return Vars.mawLorkhaj.rakkhat_darkbarrage end,
		setFunc = function(value)   Vars.mawLorkhaj.rakkhat_darkbarrage = value end,
		default = false,
	}, "mawLorkhaj", "rakkhat_darkbarrage")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_LUNARBASTION1),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_LUNARBASTION1_TT),
		choices = choices.mawLorkhaj.rakkhat_lunarbastion1,
		getFunc = function() return getChoiceValue("mawLorkhaj", "rakkhat_lunarbastion1") end,
		setFunc = function(value)   setChoiceValue("mawLorkhaj", "rakkhat_lunarbastion1", value) end,
	}, "mawLorkhaj", "rakkhat_lunarbastion1")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_LUNARBASTION2),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_RAKKHAT_LUNARBASTION2_TT),
		choices = choices.mawLorkhaj.rakkhat_lunarbastion2,
		getFunc = function() return getChoiceValue("mawLorkhaj", "rakkhat_lunarbastion2") end,
		setFunc = function(value)   setChoiceValue("mawLorkhaj", "rakkhat_lunarbastion2", value) end,
	}, "mawLorkhaj", "rakkhat_lunarbastion2")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_SHATTERED),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_SHATTERED_TT),
		getFunc = function() return Vars.mawLorkhaj.shattered end,
		setFunc = function(value)   Vars.mawLorkhaj.shattered = value end,
	}, "mawLorkhaj", "shattered")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_SUNEATER_ECLIPSE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_SUNEATER_ECLIPSE_TT),
		choices = choices.mawLorkhaj.suneater_eclipse,
		getFunc = function() return getChoiceValue("mawLorkhaj", "suneater_eclipse") end,
		setFunc = function(value)   setChoiceValue("mawLorkhaj", "suneater_eclipse", value) end,
	}, "mawLorkhaj", "suneater_eclipse")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_MARKEDFORDEATH),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAWLORKHAJ_MARKEDFORDEATH_TT),
		getFunc = function() return Vars.mawLorkhaj.markedfordeath end,
		setFunc = function(value)   Vars.mawLorkhaj.markedfordeath = value end,
	}, "mawLorkhaj", "markedfordeath")


	-- Dragonstar Arena
	MakeSubmenu(GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_HEADER), RaidNotifier:GetRaidDescription(RAID_DRAGONSTAR_ARENA))
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_GENERAL_TAKING_AIM),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_GENERAL_TAKING_AIM_TT),
		getFunc = function() return Vars.dragonstar.general_taking_aim end,
		setFunc = function(value)   Vars.dragonstar.general_taking_aim = value end,
	}, "dragonstar", "general_taking_aim")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_GENERAL_CRYSTAL_BLAST),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_GENERAL_CRYSTAL_BLAST_TT),
		getFunc = function() return Vars.dragonstar.general_crystal_blast end,
		setFunc = function(value)   Vars.dragonstar.general_crystal_blast = value end,
	}, "dragonstar", "general_crystal_blast")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA2_CRUSHING_SHOCK),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA2_CRUSHING_SHOCK_TT),
		getFunc = function() return Vars.dragonstar.arena2_crushing_shock end,
		setFunc = function(value)   Vars.dragonstar.arena2_crushing_shock = value end,
	}, "dragonstar", "arena2_crushing_shock")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA6_DRAIN_RESOURCE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA6_DRAIN_RESOURCE_TT),
		choices = choices.dragonstar.arena6_drain_resource,
		getFunc = function() return getChoiceValue("dragonstar", "arena6_drain_resource") end,
		setFunc = function(value)   setChoiceValue("dragonstar", "arena6_drain_resource", value) end,
	}, "dragonstar", "arena6_drain_resource")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA7_UNSTABLE_CORE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA7_UNSTABLE_CORE_TT),
		getFunc = function() return Vars.dragonstar.arena7_unstable_core end,
		setFunc = function(value)   Vars.dragonstar.arena7_unstable_core = value end,
	}, "dragonstar", "arena7_unstable_core")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA8_FIRE_CHARGE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA8_FIRE_CHARGE_TT),
		choices = choices.dragonstar.arena8_fire_charge,
		getFunc = function() return getChoiceValue("dragonstar", "arena8_fire_charge") end,
		setFunc = function(value)   setChoiceValue("dragonstar", "arena8_fire_charge", value) end,
	}, "dragonstar", "arena8_fire_charge")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA8_ICE_CHARGE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_DRAGONSTAR_ARENA8_ICE_CHARGE_TT),
		choices = choices.dragonstar.arena8_ice_charge,
		getFunc = function() return getChoiceValue("dragonstar", "arena8_ice_charge") end,
		setFunc = function(value)   setChoiceValue("dragonstar", "arena8_ice_charge", value) end,
	}, "dragonstar", "arena8_ice_charge")
	subTable = nil


	-- Maelstrom Arena
	MakeSubmenu(GetString(RAIDNOTIFIER_SETTINGS_MAELSTROM_HEADER), RaidNotifier:GetRaidDescription(RAID_MAELSTROM_ARENA))
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAELSTROM_STAGE7_POISON),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAELSTROM_STAGE7_POISON_TT),
		getFunc = function() return Vars.maelstrom.stage7_poison end,
		setFunc = function(value)   Vars.maelstrom.stage7_poison = value end,
	}, "maelstrom", "stage7_poison")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_MAELSTROM_STAGE9_SYNERGY),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_MAELSTROM_STAGE9_SYNERGY_TT),
		getFunc = function() return Vars.maelstrom.stage9_synergy end,
		setFunc = function(value)   Vars.maelstrom.stage9_synergy = value end,
	}, "maelstrom", "stage9_synergy")
	subTable = nil


	-- Halls of Fabrication
	MakeSubmenu(GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_HEADER), RaidNotifier:GetRaidDescription(RAID_HALLS_OF_FABRICATION))
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_TAKING_AIM),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_TAKING_AIM_TT),
		choices = choices.hallsFab.taking_aim,
		getFunc = function() return getChoiceValue("hallsFab", "taking_aim") end,
		setFunc = function(value)   setChoiceValue("hallsFab", "taking_aim", value) end,
	}, "hallsFab", "taking_aim")
	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_DRAINING_BALLISTA),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_DRAINING_BALLISTA_TT),
		choices = choices.hallsFab.draining_ballista,
		getFunc = function() return getChoiceValue("hallsFab", "draining_ballista") end,
		setFunc = function(value)   setChoiceValue("hallsFab", "draining_ballista", value) end,
	}, "hallsFab", "draining_ballista")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_STRIKE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_STRIKE_TT),
		getFunc = function() return Vars.hallsFab.conduit_strike end,
		setFunc = function(value)   Vars.hallsFab.conduit_strike = value end,
   }, "hallsFab", "conduit_strike")
   	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_POWER_LEECH),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_POWER_LEECH_TT),
		getFunc = function() return Vars.hallsFab.power_leech end,
		setFunc = function(value)   Vars.hallsFab.power_leech = value end,
   }, "hallsFab", "power_leech")
   	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_SPAWN),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_SPAWN_TT),
		getFunc = function() return Vars.hallsFab.pinnacleBoss_conduit_spawn end,
		setFunc = function(value)   Vars.hallsFab.pinnacleBoss_conduit_spawn = value end,
   }, "hallsFab", "pinnacleBoss_conduit_spawn")
  	MakeControlEntry({
		type = "dropdown",
		name = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_DRAIN),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_CONDUIT_DRAIN_TT),
		choices = choices.hallsFab.pinnacleBoss_conduit_drain,
		getFunc = function() return getChoiceValue("hallsFab", "pinnacleBoss_conduit_drain") end,
		setFunc = function(value)   setChoiceValue("hallsFab", "pinnacleBoss_conduit_drain", value) end,
	}, "hallsFab", "pinnacleBoss_conduit_drain")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_OVERPOWER_AURAS),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_OVERPOWER_AURAS_TT),
		getFunc = function() return Vars.hallsFab.committee_overpower_auras end,
		setFunc = function(value)   Vars.hallsFab.committee_overpower_auras = value end,
	}, "hallsFab", "committee_overpower_auras")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_FABRICANT_SPAWN),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_FABRICANT_SPAWN_TT),
		getFunc = function() return Vars.hallsFab.committee_fabricant_spawn end,
		setFunc = function(value)   Vars.hallsFab.committee_fabricant_spawn = value end,
	}, "hallsFab", "committee_fabricant_spawn")
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_RECLAIM_ACHIEVE),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_HALLSFAB_RECLAIM_ACHIEVE_TT),
		getFunc = function() return Vars.hallsFab.committee_reclaim_achive end,
		setFunc = function(value)   Vars.hallsFab.committee_reclaim_achive = value end,
	}, "hallsFab", "committee_reclaim_achive")
	subTable = nil


	MakeControlEntry({
		type = "header",
		name = GetString(RAIDNOTIFIER_SETTINGS_DEBUG_HEADER),
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_DEBUG),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_DEBUG_TT),
		getFunc = function() return Vars.dbg.enabled end,
		setFunc = function(value)   Vars.dbg.enabled = value end,
	})
	MakeControlEntry({
		type = "checkbox",
		name = GetString(RAIDNOTIFIER_SETTINGS_DEBUGNOTIFY),
		tooltip = GetString(RAIDNOTIFIER_SETTINGS_DEBUGNOTIFY_TT),
		getFunc = function() return Vars.dbg.notify end,
		setFunc = function(value)   Vars.dbg.notify = value end,
	})

	self.optionsData = optionsTable

    LAM:RegisterAddonPanel("RaidNotifierPanel", self.panelData)
    LAM:RegisterOptionControls("RaidNotifierPanel", self.optionsData)

	local function SetupCustomDialog()
		local customControl = RaidNotifier_ConfigDialog
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
			setup = function(dialog, data)
				customControl.selectSound = customControl:GetNamedChild("SelectSound")
				customControl.selectedSoundID = self:GetSoundValue(data.category, data.setting)
				customControl.selectSound.dropdown:SetSelectedItemText(self:GetSoundName(customControl.selectedSoundID))
			end,
			buttons =
			{
				{
					control = customControl:GetNamedChild("Confirm"),
					text = SI_DIALOG_CONFIRM,
					callback = function(dialog)
									self:SetSoundValue(dialog.data.category, dialog.data.setting, dialog.selectedSoundID)
								end,
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

		SetupCustomDialog()

		--loop through controls to add our Sound-Config-Button-Clicky-Thing (tm)
		for i = 1, index do
			local control = GetControl("RNSettingCtrl"..i)
			if (control and not control.data.noSound) then
				control.soundBtn = WINDOW_MANAGER:CreateControlFromVirtual(nil, control, "RaidNotifier_ConfigButton")
				control.soundBtn:SetAnchor(RIGHT, control.combobox or control[control.data.type], LEFT, -5, 0)
				control.soundBtn:SetHandler("OnClicked", function() 
						ZO_Dialogs_ShowDialog("RAID_NOTIFIER_CONFIG_DIALOG", control.data)
					end)
				control.soundBtn.data = {tooltipText=function()
														return zo_strformat("Sound: <<1>>", self:GetSoundName(nil, control.data.category, control.data.setting)) 
													end}
				control.soundBtn:SetHidden(false)
			end
		end
	end
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", OnPanelCreation)

end