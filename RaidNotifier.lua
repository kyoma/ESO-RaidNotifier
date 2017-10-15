RaidNotifier = RaidNotifier or {}
RaidNotifier.Util = {}

local RaidNotifier = RaidNotifier

RaidNotifier.Name            = "RaidNotifier"
RaidNotifier.DisplayName     = "Raid Notifier"
RaidNotifier.Version         = "2.2.8"
RaidNotifier.Author          = "|c009ad6Kyoma, Woeler, silentgecko|r"
RaidNotifier.SV_Name         = "RNVars"
RaidNotifier.SV_Version      = 4


-- Constants for easy reading
local RAID_HEL_RA_CITADEL        = 1
local RAID_AETHERIAN_ARCHIVE     = 2
local RAID_SANCTUM_OPHIDIA       = 3
local RAID_DRAGONSTAR_ARENA      = 4
local RAID_MAW_OF_LORKHAJ        = 5
local RAID_MAELSTROM_ARENA       = 6
local RAID_HALLS_OF_FABRICATION  = 7
local RAID_ASYLUM_SANCTORIUM     = 8


-- Debugging
local function p() end
local function dbg() end

function RaidNotifier:IsDevMode()
	return self.Vars.dbg.devMode == true
end

local ActionResults = 
{
	ACTION_RESULT_BEGIN,
	ACTION_RESULT_BEGIN_CHANNEL,
	ACTION_RESULT_EFFECT_GAINED,
	ACTION_RESULT_EFFECT_GAINED_DURATION,
	ACTION_RESULT_EFFECT_FADED,
	ACTION_RESULT_INTERRUPT, 
	ACTION_RESULT_DIED,
	--ACTION_RESULT_DIED_XP, -- only interested in spawns/minions which don't give exp??
}

local ALERT_PRIORITY_HIGHEST = 5
local ALERT_PRIORITY_HIGH    = 4
local ALERT_PRIORITY_NORMAL  = 3
local ALERT_PRIORITY_LOW     = 2
local ALERT_PRIORITY_LOWEST  = 1

------------------------------------
-- -- NOTIFICATION SYSTEM & SOUNDS
do ---------------------------------

	local lastAnnounceIndex = 0
	local lastNotifyTimes = {}
	local function GetKey(r, s)
		return (r.."_"..s)
	end

	local DEFAULT_SOUND = "Default_Sound"
	local Sounds = 
	{
		{name = "-Default-", 				 id = DEFAULT_SOUND},
		{name = "-None-", 					 id = SOUNDS.NONE},
		{name = "Add Guild Member", 		 id = SOUNDS.GUILD_ROSTER_ADDED},
		{name = "Book Acquired", 			 id = SOUNDS.BOOK_ACQUIRED},
		{name = "Book Collection Completed", id = SOUNDS.BOOK_COLLECTION_COMPLETED},
		{name = "Champion Point Committed",  id = SOUNDS.CHAMPION_POINTS_COMMITTED},
		{name = "Champion Point Gained", 	 id = SOUNDS.CHAMPION_POINT_GAINED},
		{name = "Dark Fissure Closed", 		 id = SOUNDS.SKILL_XP_DARK_FISSURE_CLOSED},
		{name = "Emperor Coronated", 		 id = SOUNDS.EMPEROR_CORONATED_ALDMERI},
		{name = "Gate Closed", 				 id = SOUNDS.AVA_GATE_CLOSED},
		{name = "Morph Ability", 			 id = SOUNDS.ABILITY_MORPH_PURCHASED},
		{name = "Objective Complete", 		 id = SOUNDS.OBJECTIVE_COMPLETED},
		{name = "Quest Abandoned", 			 id = SOUNDS.QUEST_ABANDONED},
		{name = "Quest Accepted",			 id = SOUNDS.QUEST_ACCEPTED},
		{name = "Quest Complete", 			 id = SOUNDS.QUEST_COMPLETED},
		{name = "Quickslot Empty", 			 id = SOUNDS.QUICKSLOT_USE_EMPTY},
		{name = "Quickslot Open", 			 id = SOUNDS.QUICKSLOT_OPEN},
		{name = "Remove Guild Member", 		 id = SOUNDS.GUILD_ROSTER_REMOVED},
		{name = "Skill Added", 				 id = SOUNDS.SKILL_LINE_ADDED},
		{name = "Skill Leveled", 			 id = SOUNDS.SKILL_LINE_LEVELED_UP},
		{name = "Stat Purchase", 			 id = SOUNDS.STATS_PURCHASE},
		{name = "Synergy Ready", 			 id = SOUNDS.ABILITY_SYNERGY_READY},
	}
	function RaidNotifier:GetSounds()
		return Sounds
	end
	function RaidNotifier:GetSoundName(soundId, category, setting)
		if soundId == nil then
			soundId = self:GetSoundValue(category, setting)
		end
		for _, entry in ipairs(self:GetSounds()) do
			if soundId == entry.id then return entry.name end
		end
		return ""
	end
	function RaidNotifier:GetSoundValue(category, setting)
		return self.Vars.sounds[GetKey(category, setting)] or DEFAULT_SOUND
	end
	function RaidNotifier:SetSoundValue(category, setting, value)
		self.Vars.sounds[GetKey(category, setting)] = value
	end

	function RaidNotifier:GetLastNotify(category, setting)
		local key = GetKey(category, setting)
		return lastNotifyTimes[key] or 0
	end
	function RaidNotifier:SetLastNotify(category, setting, value)
		local key = GetKey(category, setting)
		lastNotifyTimes[key] = value
	end

	local CSA  = CENTER_SCREEN_ANNOUNCE
	local LCSA = LibStub:GetLibrary("LibCSA")
	-- TODO: Overhaul this completely and make a better alternative, gonna take a while
	function RaidNotifier:AddAnnouncement(text, category, setting, interval)

		local duration = 3000
		local soundId = self:GetSoundValue(category, setting)
		if soundId == DEFAULT_SOUND then -- 
			soundId = self.Vars.general.default_sound
		end

		if not text or text == "" then
			p("Invalid text for '%s -> %s'", category, setting)
			return
		end

		if (interval) then 
			local currentTime = GetTimeStamp()
			if (interval > GetDiffBetweenTimeStamps(currentTime, self:GetLastNotify(category, setting))) then
				return
			end
			self:SetLastNotify(category, setting, currentTime)
		end

		if (self.Vars.general.use_center_screen_announce and not LCSA:HasActiveCountdown()) then
			CSA:AddMessage(EVENT_BROADCAST, CSA_CATEGORY_SMALL_TEXT, soundId, text, nil, nil, nil, nil, nil, duration)
			CSA.nextUpdateTimeSeconds = 0 --they renamed it in ESO:Morrowind
		else
			lastAnnounceIndex = lastAnnounceIndex + 1
			RaidNotifierUICenterAnnounce:SetHidden(false)
			RaidNotifierUICenterAnnounce:SetText(text)
		
			local index = lastAnnounceIndex
			zo_callLater(function()
				--only hide it if we are the last/most recent announcement
				if index == lastAnnounceIndex then
					RaidNotifierUICenterAnnounce:SetHidden(true)
				end
			end, duration)
		
			if soundId ~= nil then PlaySound(soundId) end
		end
	end

	function RaidNotifier:StartCountdown(timer, text, category, setting, interval)
		local soundId = self:GetSoundValue(category, setting)

		if not text or text == "" then
			p("Invalid text for '%s -> %s'", category, setting)
			return
		--elseif self.Vars.debug_notify then 
		--	dbg("Alert for '%s -> %s', sound '%s' \n\"%s\"", category, setting, soundId, text)
		end
		if (interval) then 
			local currentTime = GetTimeStamp()
			if (interval > GetDiffBetweenTimeStamps(currentTime, self:GetLastNotify(category, setting))) then
				return
			end
			self:SetLastNotify(category, setting, currentTime)
		end
		return LCSA:CreateCountdown(timer, soundId, nil, text, nil)
	end
	function RaidNotifier:StopCountdown(countdownIndex)
		--if countdownIndex then 
			dbg("Stopping countdown #%d", countdownIndex or -1)
			LCSA:EndCountdown(countdownIndex)
		--end
	end

end


-- ----------------------
-- -- ULTIMATE EXCHANGE
do ----------------------

	local window = nil

	local LGS = LibStub:GetLibrary("LibGroupSocket")
	local ultimateHandler = LGS:GetHandler(LGS.MESSAGE_TYPE_ULTIMATE)
	local ultimateAbilityId = 46537  -- Aggressive Warhorn Rank IV
	local ultimateGroupId   = 29     -- hardcoded for now
	local ultimates = {}

	function RaidNotifier.OnUltimateReceived(unitTag, ultimateCurrent, ultimateCost) --, ultimateGroupId, isSelf)
		local self     = RaidNotifier
		local userName = GetUnitDisplayName(unitTag)
		ultimates[userName] = 
		{
			userName = userName,
			name     = GetUnitName(unitTag),
			roles    = {GetGroupMemberRoles(unitTag)},
			current  = ultimateCurrent,
			percent  = math.floor((ultimateCurrent / ultimateCost) * 100), --round it down?
		}
		self:UpdateUltimates()
	end

	function RaidNotifier:UpdateUltimates()
		local settings = self.Vars.ultimate
		if settings.hidden then return end

		local sortedUlti = {}
		for userName, data in pairs(ultimates) do
			local r1,r2,r3 = unpack(data.roles)
			if (r1 and settings.showDps or r2 and settings.showHealers or r3 and settings.showTanks) then
				table.insert(sortedUlti, data)
			end
		end
		table.sort(sortedUlti, function(a, b) return a.percent > b.percent end)

		self:UpdateUltimateWindow(sortedUlti) --ignore mode
	end

	local function ToggleLibGroupSocket(enabled)
		local settings = RaidNotifier.Vars.ultimate
		if settings.enabled then 
			local button = ZO_GroupMenu_Keyboard_LibGroupSocketToggle
			if not button then -- wait for button
				zo_callLater(function() ToggleLibGroupSocket(enabled) end, 1000)
			else
				ZO_CheckButton_SetCheckState(button, enabled)
				button:toggleFunction(enabled)
			end
		end
	end

	local listening = false
	function RaidNotifier:RegisterForUltimateChanges()
		local settings = self.Vars.ultimate
		if not settings.enabled then return end
		
		if listening then return end
		listening = true
		dbg("RegisterForUltimateChanges")

		self:SetElementHidden("ultimate", "ulti_window", settings.hidden)

		if ultimateHandler.SetUltimateGroupId then 
			ultimateHandler:SetUltimateGroupId(ultimateGroupId)
		end
		ultimateHandler:RegisterForUltimateChanges(self.OnUltimateReceived)
		ultimateHandler:Refresh()
		ToggleLibGroupSocket(true) -- force LibGroupSocket to send data

		local function OnWeaponPairChanged()
			--get dynamic ultimate cost, should work with any cost reduction passives & sets
			if settings.override_cost > 0 then
				ultimateHandler:SetUltimateCost(settings.override_cost)
			else
				ultimateHandler:SetUltimateCost(GetAbilityCost(ultimateAbilityId))
			end
		end
		OnWeaponPairChanged()
		EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_WEAPON_PAIR_LOCK_CHANGED, OnWeaponPairChanged)


		local function OnGroupUpdate()
			local groupSize = GetGroupSize()
			if (groupSize == 0) then
				self:SetElementHidden("ultimate", "ulti_window", true)
				ToggleLibGroupSocket(false)
			else
				self:SetElementHidden("ultimate", "ulti_window", settings.hidden)
				ToggleLibGroupSocket(true)
			end
			local newMembers = {}
			for i=1, groupSize do
				local userName = GetUnitDisplayName("group"..i)
				if userName and userName ~= "" then 
					newMembers[userName] = IsUnitOnline("group"..i)
				end
			end
			for userName, data in pairs(ultimates) do
				if not newMembers[userName] then
					ultimates[userName] = nil
				end
			end
			zo_callLater(function() self:UpdateUltimates() end, 200) -- slight delay
		end
		OnGroupUpdate()
		EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_GROUP_MEMBER_JOINED, OnGroupUpdate)
		EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_GROUP_MEMBER_LEFT,   OnGroupUpdate)
		EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_GROUP_UPDATE,        OnGroupUpdate)
		EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_GROUP_MEMBER_CONNECTED_STATUS , OnGroupUpdate)

		local function OnRolesChanged(_, unitTag, dps, healer, tank)
			local userName = GetUnitDisplayName(unitTag)
			if ultimates[userName] then
				ultimates[userName].roles = {dps, healer, tank}
			end
			self:UpdateUltimates()
		end
		EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_GROUP_MEMBER_ROLES_CHANGED, OnRolesChanged)
	end

	function RaidNotifier:UnregisterForUltimateChanges()
		if not listening then return end
		listening = false
		dbg("UnregisterForUltimateChanges")
		
		self:SetElementHidden("ultimate", "ulti_window", true)

		ultimateHandler:UnregisterForUltimateChanges(self.OnUltimateReceived)
		ToggleLibGroupSocket(false) -- force LibGroupSocket to send data

		EVENT_MANAGER:UnregisterForEvent(self.Name, EVENT_WEAPON_PAIR_LOCK_CHANGED)
		EVENT_MANAGER:UnregisterForEvent(self.Name, EVENT_GROUP_MEMBER_JOINED)
		EVENT_MANAGER:UnregisterForEvent(self.Name, EVENT_GROUP_MEMBER_LEFT)
		EVENT_MANAGER:UnregisterForEvent(self.Name, EVENT_GROUP_UPDATE)
		--EVENT_MANAGER:UnregisterForEvent(self.Name, EVENT_UNIT_FRAME_UPDATE)
		EVENT_MANAGER:UnregisterForEvent(self.Name, EVENT_GROUP_MEMBER_ROLES_CHANGED)
	end

	SLASH_COMMANDS["/rnulti"] = function(str) 
		local args = {zo_strsplit(" ", str)}

		local self     = RaidNotifier
		local settings = self.Vars.ultimate
		if (args == nil or #args == 0) then
			settings.hidden = not settings.hidden
			p("%s Ultimate Exchange", settings.hidden and "Hide" or "Show")
		elseif (args[1] == "show") then
			p("Show Ultimate Exchange")
			settings.hidden = false
		elseif (args[1] == "hide") then
			p("Hide Ultimate Exchange")
			settings.hidden = true
		elseif (args[1] == "enable" or args[1] == "on" or args[1] =="1") then
			p("Enable Ultimate Exchange")
			settings.enabled = true
			settings.hidden = false
			self:RegisterForUltimateChanges()
		elseif (args[1] == "disable" or args[1] == "off" or args[1] == "0") then
			p("Disable Ultimate Exchange")
			settings.enabled = false
			settings.hidden = true
			self:UnregisterForUltimateChanges()
		elseif (args[1] == "refresh") then
			ultimates = {}
			ultimateHandler:Refresh()
		elseif (args[1] == "cost") then
			if (#args == 2) then
				if (tonumber(args[2]) ~= nil) then
					settings.override_cost = tonumber(args[2])
				elseif (args[2] == "auto") then -- maybe use GetSlotBoundId to grab slotted ability instead?
					settings.override_cost = GetSlotAbilityCost(ACTION_BAR_ULTIMATE_SLOT_INDEX + 1)
				else 
					p("Trying to set override cost to unsupported value (%s)", args[2])
					return
				end
				-- cost will be sent to others on next bar swap
				if (settings.override_cost > 0) then
					p("Enabled ultimate cost is now " .. settings.override_cost)
				else
					p("Disabled ultimate cost override")
				end
			end
		else
			p("Unknown subcommand (%s)", args[1])
		end
		self:SetElementHidden("ultimate", "ulti_window", settings.hidden)
		self:UpdateUltimates()
	end

end


-- ----------------------
-- -- INITIALIZE EVENTS
do ----------------------

	local Utils  = RaidNotifier.Utils

	local function ToggleVanityPets(disable)
		local settings = RaidNotifier.Vars.general
		if settings.vanity_pets then
			if disable then
				settings.last_pet = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET)
				if settings.last_pet > 0 then
					UseCollectible(settings.last_pet)
				end
			elseif (settings.last_pet and settings.last_pet > 0) then
				UseCollectible(settings.last_pet)
				settings.last_pet = 0
			end
		end
	end

	-- These should remain the same throughout updates
	local RaidZoneIds = 
	{
		[RAID_HEL_RA_CITADEL]        = 636,
		[RAID_AETHERIAN_ARCHIVE]     = 638,
		[RAID_SANCTUM_OPHIDIA]       = 639,
		[RAID_DRAGONSTAR_ARENA]      = 635,
		[RAID_MAW_OF_LORKHAJ]        = 725,
		[RAID_MAELSTROM_ARENA]       = 677,
		[RAID_HALLS_OF_FABRICATION]  = 975,
		[RAID_ASYLUM_SANCTORIUM]     = 1000,
	}
	local RaidZones = {}
	for raidId, zoneId in pairs(RaidZoneIds) do
		RaidZones[GetZoneNameById(zoneId)] = raidId
	end
	local function GetRaidZoneName(raidId)
		return GetZoneNameById(RaidZoneIds[raidId])
	end
	function RaidNotifier:GetRaidIdFromCurrentZone()
		return self.raidZoneId or 0
	end
	function RaidNotifier:IsInRaidZone()
		return self:GetRaidIdFromCurrentZone() > 0
	end
	function RaidNotifier:GetRaidDescription(raidId)
		return GetZoneDescriptionById(RaidZoneIds[raidId])
	end

	function RaidNotifier:RegisterForCombatEvent(result, handler)
		EVENT_MANAGER:RegisterForEvent(self.Name .. tostring(result), EVENT_COMBAT_EVENT, handler)
		if type(result) == "number" then
			EVENT_MANAGER:AddFilterForEvent(self.Name .. tostring(result), EVENT_COMBAT_EVENT, REGISTER_FILTER_COMBAT_RESULT, result)
		end
	end
	function RaidNotifier:UnregisterForCombatEvent(result)
		EVENT_MANAGER:UnregisterForEvent(self.Name .. tostring(result), EVENT_COMBAT_EVENT)
	end

	local listening = false
	function RaidNotifier:RegisterEvents(raidId)
		if listening then return end

		self.raidId = raidId or self:GetRaidIdFromCurrentZone()
		self.raidDifficulty = GetCurrentZoneDungeonDifficulty()
		if (self.raidId > 0) then
			dbg("Register for %s (%s)", GetRaidZoneName(self.raidId), GetString("SI_DUNGEONDIFFICULTY", self.raidDifficulty))
			-- The main juicy events we want, registered seperately for better performance
			for _, result in ipairs(ActionResults) do
				self:RegisterForCombatEvent(result, self.OnCombatEvent)
			end
			EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_EFFECT_CHANGED, self.OnEffectChanged)
			EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_BOSSES_CHANGED, self.OnBossesChanged)

			-- Toggle assistants off when combat starts
			local function OnCombatStateChanged(_, inCombat)
				local settings = self.Vars.general
				if (inCombat and settings.no_assistants and GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT) > 0) then
					UseCollectible(GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT))
				end
			end
			EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_PLAYER_COMBAT_STATE, OnCombatStateChanged)

			--self:AddFragment()
			listening = true
	
			-- Ultimate exchanging
			self:RegisterForUltimateChanges()

			-- Disable pets if that setting is set
			ToggleVanityPets(true)

			-- In case of initializing while already at a boss
			self.OnBossesChanged()
		end
	end

	function RaidNotifier:UnregisterEvents()
		if not listening then return end

		dbg("Unregister for %s (%s)", GetRaidZoneName(self.raidId), GetString("SI_DUNGEONDIFFICULTY", self.raidDifficulty))
		EVENT_MANAGER:UnregisterForEvent(self.Name, EVENT_COMBAT_EVENT)
		for _, result in ipairs(ActionResults) do
			self:UnregisterForCombatEvent(result)
		end
		EVENT_MANAGER:UnregisterForEvent(self.Name, EVENT_EFFECT_CHANGED)
		EVENT_MANAGER:UnregisterForEvent(self.Name, EVENT_BOSSES_CHANGED)
		EVENT_MANAGER:UnregisterForEvent(self.Name, EVENT_PLAYER_COMBAT_STATE)

		--self:RemoveFragment()
		self:HideAllElements()
		listening = false
		self.raidId = 0
		self.raidDifficulty = 0

		-- Ultimate exchanging
		self:UnregisterForUltimateChanges()

		-- Re-enable pets
		ToggleVanityPets(false)
	end

	function RaidNotifier:Initialize()
		self.Vars = ZO_SavedVars:NewAccountWide(self.SV_Name, self.SV_Version, nil, self:GetDefaults())
		if (not self.Vars.useAccountWide) then -- not using global settings, generate (or load) character specific settings
			self.Vars = ZO_SavedVars:New(self.SV_Name, self.SV_Version, nil, self:GetDefaults())
		end
		--self:TryUpgradeSettings()

		-- tiny functions
		p = function(msg, ...)
			d("[RaidNotifier] "..msg:format(...))
		end
		self.p = p
		dbg = function(msg, ...)
			if self.Vars.debug then
				p(msg, ...)
			end
		end
		self.dbg = dbg
		
		self:CreateSettingsMenu()

		-- UI Elements
		self:InitializeUltimateWindow("UltimateWindow")
		self:InitializeStatusDisplay("StatusDisplay")
		self:InitializeGlyphWindow("GlyphWindow", self.Vars.mawLorkhaj.zhaj_glyphs_invert)

		-- Always add fragment now
		self:AddFragment() 

		-- These aren't needed anymore since we now start & stop Raid Notifier solely based on being in the raid zone
	    --EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_RAID_TRIAL_STARTED,  function(...) self:RegisterEvents() end)
		--EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_RAID_TRIAL_COMPLETE, function(...) self:UnregisterEvents() end)
		self.raidId = 0
		self.raidDifficulty = 0
		-- Monitor zone changes to account for teleporting out of a trial, also for teleporting back in
		local function OnZoneChanged()
			-- Not using GetMapName() because that changes while looking at the map
			self.raidZoneId = RaidZones[GetUnitZone("player")]

			if self:IsInRaidZone() then
				if self.raidId ~= self:GetRaidIdFromCurrentZone() then
					if self.raidId > 0 then
						self:UnregisterEvents()
					end
					self:RegisterEvents()
				end
			elseif self.raidId > 0 then
				self:UnregisterEvents()
			end
		end
		OnZoneChanged()
		--EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_ZONE_CHANGED, OnZoneChanged) -- Doesn't fire after zoning and not always when subzoning
		--EVENT_MANAGER:RegisterForEvent(self.Name, EVENT_CURRENT_SUBZONE_LIST_CHANGED, OnZoneChanged) -- Better than above but still not perfect
		CALLBACK_MANAGER:RegisterCallback("OnWorldMapChanged", OnZoneChanged) -- might as well listen to this since that code is executed anyways

		-- Change vitality bonus announcement to not conflict with our own
		local LCSA = LibStub:GetLibrary("LibCSA")
		LCSA:HookHandler(EVENT_RAID_REVIVE_COUNTER_UPDATE, function(messageParams, currentCount, countDelta)
			if messageParams then
				messageParams:SetCategory(CSA_CATEGORY_SMALL_TEXT)
			end
			return messageParams
		end)

	end

end


-- -----------------------------
-- EVENT: EVENT_BOSSES_CHANGED
do -----------------------------

	local bossCount, bossAlive, bossFull
	function RaidNotifier:GetNumBosses(fresh)
		if (not bossCount or fresh) then 
			bossCount = 0
			bossAlive = 0
			bossFull = 0 
			
			local health, maxHealth
			for i = 1, MAX_BOSSES do
				if DoesUnitExist("boss"..i) then
					bossCount = bossCount + 1
					health, maxHealth = GetUnitPower("boss"..i, POWERTYPE_HEALTH)
					if health > 0 then
						bossAlive = bossAlive + 1
						if health >= maxHealth then
							bossFull = bossFull + 1
						end
					end
				end
			end
		end
		return bossCount, bossAlive, bossFull
	end

	function RaidNotifier.OnBossesChanged()
		local self   = RaidNotifier
		local raidId = RaidNotifier.raidId

		self.Minions = self.Minions or {}
		local bossCount, bossAlive, bossFull = self:GetNumBosses(true)
		-- reset if: 
		--    1) there are no bosses
		--    2) all bosses are dead
		--    3) all bosses are at full health
		if bossCount == 0 or bossAlive == 0 or bossFull == bossCount then
			-- reset all minions for now
			--self.Minions = {}
			-- remove any countdown that is active
			dbg("Bosses changed, stop any active countdown")
			--self:StopCountdown()
		end

		if (raidId == RAID_MAW_OF_LORKHAJ) then
			local buffsDebuffs, settings = self.BuffsDebuffs.maw_lorkhaj, self.Vars.mawLorkhaj

			self:SetElementHidden("mawLorkhaj", "zhaj_glyph_window", true)
			local map = GetMapTileTexture()
			if (bossCount == 1 and map == "Art/maps/reapersmarch/Maw_of_Lorkaj_Base_0.dds") then -- Zhaj'hassa the Forgotten
				buffsDebuffs.zhajBoss_knownGlyphs = {}
				if (settings.zhaj_glyphs) then
					self:SetElementHidden("mawLorkhaj", "zhaj_glyph_window", false)
				end
			elseif (bossCount == 2 and map == "Art/maps/reapersmarch/MawLorkajSuthaySanctuary_Base_0.dds") then -- False Moon Twins, S’Kinrai and Vashai
				
			elseif (bossCount == 1 and map == "Art/maps/reapersmarch/MawLorkajSevenRiddles_Base_0.dds") then
			
			end
		elseif (raidId == RAID_HALLS_OF_FABRICATION) then
			if (bossCount == 3) then --Refabrication Committee
				
			end
		end
	end

end


-- ---------------------------
-- EVENT: EVENT_COMBAT_EVENT
do ---------------------------

	local LUNIT = LibStub:GetLibrary("LibUnits")
	local Util  = RaidNotifier.Util

	function RaidNotifier.OnCombatEvent(_, result, isError, aName, aGraphic, aActionSlotType, sName, sType, tName, tType, hitValue, pType, dType, log, sUnitId, tUnitId, abilityId)

		local raidId = RaidNotifier.raidId
		local self   = RaidNotifier

		-- Unregister if we left the raid instance
		--if self:IsInRaidZone() == false then
		--	self:UnregisterEvents()
		--	return
		--end

		if (raidId == RAID_HEL_RA_CITADEL) then
			local buffsDebuffs, settings = self.BuffsDebuffs.hel_ra, self.Vars.helra

			if (result == ACTION_RESULT_BEGIN) then

				-- Warrior Stone Form
				--   This one needs a small trick: sometimes the Warrior will attempt to stone
				--   two people but only the last person actually gets trapped. But because it 
				--   is the last person that gets trapped and not the first we cannot use the
				--   normal interval code. So we add a delay and check if we got another alert
				--   before actually displaying it.
				if (abilityId == buffsDebuffs.warrior_stoneform) then
					if (settings.warrior_stoneform >= 1) then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						
						local lastIndex = self:GetLastNotify("helra", "warrior_stoneform") + 1
						self:SetLastNotify("helra", "warrior_stoneform", lastIndex)
						zo_callLater(function()
							if (lastIndex == self:GetLastNotify("helra", "warrior_stoneform")) then
								if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
									self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_HELRA_WARRIOR_STONEFORM), "helra", "warrior_stoneform")
								elseif (tName ~= "" and settings.warrior_stoneform == 2) then
									self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_HELRA_WARRIOR_STONEFORM_OTHER), tName), "helra", "warrior_stoneform")
								end
							end
						end, 200)
					end
				end

			elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then
				if abilityId == buffsDebuffs.yokeda_meteor then
					if settings.yokeda_meteor > 0 then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_HELRA_YOKEDA_METEOR), "helra", "yokeda_meteor")
						elseif (tName ~= "" and settings.yokeda_meteor == 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_HELRA_YOKEDA_METEOR_OTHER), tName), "helra", "yokeda_meteor")
						end
					end
				end
			end

		elseif (raidId == RAID_AETHERIAN_ARCHIVE) then
			local buffsDebuffs, settings = self.BuffsDebuffs.archive, self.Vars.archive

			if (result == ACTION_RESULT_BEGIN) then

				-- Lightning Storm Atronach
				if (buffsDebuffs.stormatro_impendingstorm == abilityId) then
					if settings.stormatro_impendingstorm then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ARCHIVE_STORMATRO_IMPENDINGSTORM), "archive", "stormatro_impendingstorm")
					end
				elseif (buffsDebuffs.stormatro_lightningstorm == abilityId) then
					if settings.stormatro_lightningstorm then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ARCHIVE_STORMATRO_LIGHTNINGSTORM), "archive", "stormatro_lightningstorm")
					end

				-- Foundation Stone Atronach
				elseif (buffsDebuffs.stoneatro_boulderstorm == abilityId) then
					if settings.stoneatro_boulderstorm then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ARCHIVE_STONEATRO_BOULDERSTORM), "archive", "stoneatro_boulderstorm", 8)
					end
				elseif (buffsDebuffs.stoneatro_bigquake == abilityId) then
					if settings.stoneatro_bigquake then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ARCHIVE_STONEATRO_BIGQUAKE), "archive", "stoneatro_bigquake", 8)
					end

				-- Celestial Mage
				elseif (buffsDebuffs.mage_conjure_axe[abilityId]) then
					if settings.mage_conjure_axe then
					
					end
				elseif (buffsDebuffs.mage_conjure_reflection[abilityId]) then
					if settings.mage_conjure_reflection then
						--self.tempVars.minions.archive.reflections[tUnitId] = {
						--	uId = tUnitId,
						--	health    = 1000000,
						--	maxHealth = 1000000,
						--	name = "Conjured Reflection",
						--}
					end

				-- Overchargers, Overcharged
				elseif (buffsDebuffs.overcharged == abilityId) then
					tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
					if settings.overcharge >= 1 then
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ARCHIVE_OVERCHARGE), "archive", "overcharge")
						elseif (tName ~= "" and settings.overcharge == 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_ARCHIVE_OVERCHARGE_OTHER), tName), "archive", "overcharge")
						end
					end

				-- Overchargers, Call Lightning
				elseif (buffsDebuffs.call_lightning == abilityId) then
					tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
					if settings.call_lightning >= 1 then
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ARCHIVE_CALL_LIGHTNING), "archive", "call_lightning")
						elseif (tName ~= "" and settings.call_lightning == 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_ARCHIVE_CALL_LIGHTNING_OTHER), tName), "archive", "call_lightning")
						end
					end
				end
			
			elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then

				if (tType == COMBAT_UNIT_TYPE_PLAYER) then 

				end

--[[		elseif (result == ACTION_RESULT_DAMAGE or
				result == ACTION_RESULT_DOT_TICK or
				result == ACTION_RESULT_CRITICAL_DAMAGE or
				result == ACTION_RESULT_DOT_TICK_CRITICAL or
				--result == ACTION_RESULT_BLOCKED_DAMAGE or
				--result == ACTION_RESULT_DAMAGE_SHIELDED or
				result == ACTION_RESULT_HOT_TICK or
				result == ACTION_RESULT_HEAL or
				result == ACTION_RESULT_CRITICAL_HEAL or
				result == ACTION_RESULT_HOT_TICK_CRITICAL) then

				if (settings.mage_conjure_reflection and self.tempVars.minions.archive.reflections[tUnitId]) then
					local target = self.tempVars.minions.archive.reflections[tUnitId]
					if (result == ACTION_RESULT_HEAL or result == ACTION_RESULT_HOT_TICK or result == ACTION_RESULT_CRITICAL_HEAL or result == ACTION_RESULT_HOT_TICK_CRITICAL) then
						hitValue = -hitValue
					end
					target.health = target.health - hitValue
					if target.health > target.maxHealth then 
						target.health = target.maxHealth
					elseif target.health < 0 then
						target.health = 0
					end
					--df("[Test Combat] Damaged #%d (%s) for %d, new health is %d", target.uId, target.name, hitValue, target.health)
				end
]]--
			end


		elseif (raidId == RAID_SANCTUM_OPHIDIA) then
			local buffsDebuffs, settings = self.BuffsDebuffs.sanctum_ophidia, self.Vars.sanctumOphidia

			--We're lucky that alot of things can be detected slightly before they hit the player
			if (result == ACTION_RESULT_BEGIN) then

				-- Serpent, Poison Phase
				if (buffsDebuffs.serpent_poison_teleport[abilityId]) then
					local phase = buffsDebuffs.serpent_poison_teleport[abilityId]
					if settings.serpent_poison == 2 or phase == 5 then --"Full" or final poison phase, use detailed text
						self:AddAnnouncement(GetString("RAIDNOTIFIER_ALERTS_SANCTUM_SERPENT_POISON", phase), "sanctumOphidia", "serpent_poison")
					elseif settings.serpent_poison == 1 then --"Normal", use plain text
						self:AddAnnouncement(GetString("RAIDNOTIFIER_ALERTS_SANCTUM_SERPENT_POISON", 0), "sanctumOphidia", "serpent_poison")
					end

				-- Serpent (Hardmode), World-Shaper
				elseif (abilityId == buffsDebuffs.serpent_world_shaper) then
					 --per start of eclipse tear, just add countdown and use interval to limit it to the first
					if (settings.serpent_world_shaper == true) then
						--dbg("World Shaper detected")
						self:StartCountdown(buffsDebuffs.serpent_world_shaper_delay, GetString(RAIDNOTIFIER_ALERTS_SANCTUM_SERPENT_WORLD_SHAPER), "sanctumOphidia", "serpent_world_shaper", 10)
					end

				-- Trolls, Spreading Poison
				elseif (buffsDebuffs.spreading_poison[abilityId]) then
					if settings.troll_poison >= 1 then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_TROLL_POISON), "sanctumOphidia", "troll_poison")
						elseif (tName ~= "" and settings.troll_poison == 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_TROLL_POISON_OTHER), tName), "sanctumOphidia", "troll_poison")
						end
					end

				-- Trolls, Boulder Toss
				elseif (buffsDebuffs.boulder_toss == abilityId) then
					if settings.troll_boulder >= 1 then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_TROLL_BOULDER), "sanctumOphidia", "troll_boulder")
						elseif (tName ~= "" and settings.troll_boulder == 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_TROLL_BOULDER_OTHER), tName), "sanctumOphidia", "troll_boulder")
						end
					end

				-- Overchargers, Overcharged
				elseif (buffsDebuffs.overcharged == abilityId) then
					if settings.overcharge >= 1 then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_OVERCHARGE), "sanctumOphidia", "overcharge")
						elseif (tName ~= "" and settings.overcharge == 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_OVERCHARGE_OTHER), tName), "sanctumOphidia", "overcharge")
						end
					end

				-- Overchargers, Call Lightning
				elseif (buffsDebuffs.call_lightning == abilityId) then
					if settings.call_lightning >= 1 then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_CALL_LIGHTNING), "sanctumOphidia", "call_lightning")
						elseif (tName ~= "" and settings.call_lightning == 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_CALL_LIGHTNING_OTHER), tName), "sanctumOphidia", "call_lightning")
						end
					end

				end

			elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then
			
				-- TODO: Reintroduce simple alert when standing in a spear
			
				-- Mantikora Spear Throw Alert
				--    This one is a bit weird, the effect is added as soon as the red circle starts appearing (which is
				--    good). But this also means it may show multiple alerts, one for each of the people that are in the 
				--    target area. And since we'll always want the player to take priority we slightly delay the alert for
				--    other players and let the interval check handle the rest.
				--    The really nice thing is that we no longer have to support the "Near" option since you'll always be
				--    alerted if you'd end up inside the spear (excluding movement after it is thrown).
				--    UPDATE: Seems it simply always adds this ability to the three furthest people even if they are far
				--    away from each other.
				--if (abilityId == buffsDebuffs.mantikora_spear) then
				--	if settings.mantikora_spear >= 1 then
				--		tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
				--		df("Manti SpearThrow - %d/%d/%s", tType, tUnitId, tName)
				--		if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
				--			self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_MANTIKORA_SPEAR), 3000, SOUNDS.CHAMPION_POINTS_COMMITTED,
				--												5, "sanctumOphidia", "mantikora_spear")
				--		elseif (tName ~= "" and settings.mantikora_spear == 2) then
				--			zo_callLater(function()
				--				self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_MANTIKORA_SPEAR_OTHER), tName), 3000, SOUNDS.CHAMPION_POINTS_COMMITTED,
				--													5, "sanctumOphidia", "mantikora_spear")
				--			end, 100)
				--		else
				--			--dbg("Manticora Spear on unknown player #"..tUnitId)
				--		end
				--	end
				--end
				
				if (tType == COMBAT_UNIT_TYPE_PLAYER) then 

					-- Sanctum Serpent Magicka Detonation Alert
					if (abilityId == buffsDebuffs.serpent_magicka_deto) then
						if (settings.magicka_deto == true) then
							-- get current magicka percentage (only notify if the current magicka is over 15%)
							local current, maximum, _ = GetUnitPower("player", POWERTYPE_MAGICKA)
							local magickaPercentage   = zo_roundToNearest(current/maximum,0.01) * 100
							if magickaPercentage > 15 then
								self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_MAGICKA_DETONATION)), "sanctumOphidia", "magicka_deto", 5)
							end
						end
					end
					
					-- Mantikora Quake Alert
					if (abilityId == buffsDebuffs.mantikora_quake) then
						if (settings.mantikora_quake == true) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SANCTUM_MANTIKORA_QUAKE)), "sanctumOphidia", "mantikora_quake", 5)
						end
					end

				end

			end

		elseif (raidId == RAID_DRAGONSTAR_ARENA) then
			local buffsDebuffs, settings = self.BuffsDebuffs.dragonstar, self.Vars.dragonstar

			if (result == ACTION_RESULT_BEGIN) then
				-- TODO: Enable some of these for others too?
			
				-- General: Taking Aim
				if (abilityId == buffsDebuffs.general_taking_aim) then
					if (settings.general_taking_aim) then
						--tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_DRAGONSTAR_GENERAL_TAKING_AIM), "dragonstar", "general_taking_aim")
						end
					end

				-- General: Crystal Blast
				elseif (abilityId == buffsDebuffs.general_crystal_blast) then
					if (settings.general_crystal_blast) then
						--tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_DRAGONSTAR_GENERAL_CRYSTAL_BLAST), "dragonstar", "general_crystal_blast")
						end
					end

				-- Arena 2: Crushing Shock
				elseif (abilityId == buffsDebuffs.arena2_crushing_shock) then
					if (settings.arena2_crushing_shock) then
						--tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_DRAGONSTAR_ARENA2_CRUSHING_SHOCK), "dragonstar", "arena2_crushing_shock")
						end
					end

				-- Arena 6: Drain Resource
				elseif (abilityId == buffsDebuffs.arena6_drain_resource) then
					if (settings.arena6_drain_resource >= 1) then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_DRAGONSTAR_ARENA6_DRAIN_RESOURCE), "dragonstar", "arena6_drain_resource")
						elseif (tName ~= "" and settings.arena6_drain_resource >= 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_DRAGONSTAR_ARENA6_DRAIN_RESOURCE_OTHER), tName), "dragonstar", "arena6_drain_resource")
						end
					end

				-- Arena 8: Ice Charge
				elseif (abilityId == buffsDebuffs.arena8_ice_charge) then
					if (settings.arena8_ice_charge >= 1) then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_DRAGONSTAR_ARENA8_ICE_CHARGE), "dragonstar", "arena8_ice_charge")
						elseif (tName ~= "" and settings.arena8_ice_charge >= 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_DRAGONSTAR_ARENA8_ICE_CHARGE_OTHER), tName), "dragonstar", "arena8_ice_charge")
						end
					end
				-- Arena 8: Fire Charge
				elseif (abilityId == buffsDebuffs.arena8_fire_charge) then
					if (settings.arena8_fire_charge >= 1) then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_DRAGONSTAR_ARENA8_FIRE_CHARGE), "dragonstar", "arena8_fire_charge")
						elseif (tName ~= "" and settings.arena8_fire_charge >= 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_DRAGONSTAR_ARENA8_FIRE_CHARGE_OTHER), tName), "dragonstar", "arena8_fire_charge")
						end
					end

				end

			elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then

				-- Arena 7: Unstable Core (Eclipse)
				if (abilityId == buffsDebuffs.arena7_unstable_core) then
					if (settings.arena7_unstable_core) then
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_DRAGONSTAR_ARENA7_UNSTABLE_CORE), "dragonstar", "arena7_unstable_core")
						end
					end

				end

			end


		elseif (raidId == RAID_MAW_OF_LORKHAJ) then
			local buffsDebuffs, settings = self.BuffsDebuffs.maw_lorkhaj, self.Vars.mawLorkhaj

			local function FindGlyph(glyphId, glyphs, knownGlyphs, allowNew)
				if not knownGlyphs[glyphId] then
					if not allowNew then return 0 end

					local lowestDistance = 99999
					local lowestIndex = 0
					local lowestUnit = ""
					for index, data in ipairs(glyphs) do
						for p=1, GetGroupSize() do
							if IsUnitOnline("group"..p) then
								local pX, pY = GetMapPlayerPosition("group"..p)
								if (knownGlyphs[index] == nil) then --only check unknown glyphs
									-- we dont care about scale/factor or how much it is in actual meters
									local distance = Util.GetRawDistance(pX,pY, data.x,data.y) * 1000 
									if (distance < lowestDistance) then
										lowestDistance=distance
										lowestIndex=index
										lowestUnit = GetUnitName("group"..p)
									end
								end
							end
						end
					end
					if lowestDistance < 8 and lowestIndex > 0 then
						dbg("Glyph #%d -> %d, first used by %s", lowestIndex, glyphId, lowestUnit)
						knownGlyphs[lowestIndex] = glyphId
						knownGlyphs[glyphId] = lowestIndex
						return lowestIndex
					else
						return 0
					end
				else
					return knownGlyphs[glyphId]
				end
			end

			--Zhaj'hassa the Forgotten 
			-- Glyphs & Curse (UI elements only, notification code is further down below)
			if settings.zhaj_glyphs then
				if (abilityId == buffsDebuffs.zhajBoss_glyphability) then
					local findNew = (result == ACTION_RESULT_EFFECT_FADED) --only scan for new glyph when effect/glyph is used by the player, NOT when it respawns
					local glyphIndex = FindGlyph(tUnitId, buffsDebuffs.zhajBoss_glyphs, buffsDebuffs.zhajBoss_knownGlyphs, findNew) 
					if (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then
						self:StopGlyphTimer(glyphIndex)
					elseif (result == ACTION_RESULT_EFFECT_FADED) then
						self:StartGlyphTimer(glyphIndex, buffsDebuffs.zhajBoss_glyphcooldown)
					end
				elseif (tType == COMBAT_UNIT_TYPE_PLAYER and abilityId == buffsDebuffs.zhajBoss_curseability) then
					local glyphIndex = 7
					if (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then 
						self:StartGlyphTimer(glyphIndex, buffsDebuffs.zhajBoss_curseduration)
					elseif (result == ACTION_RESULT_EFFECT_FADED) then
						self:StopGlyphTimer(glyphIndex)
					end
				end
			end

			if (result == ACTION_RESULT_BEGIN) then
				--Sun-Eater Eclipse Field
				if (abilityId == buffsDebuffs.suneater_eclipse) then
					if settings.suneater_eclipse >= 1 then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_SUNEATER_ECLIPSE), "mawLorkhaj", "suneater_eclipse")
						elseif (tName ~= "" and settings.suneater_eclipse >= 2) then -- removed the distance check for now
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_SUNEATER_ECLIPSE_OTHER), tName), "mawLorkhaj", "suneater_eclipse")
						end
					end
				elseif (abilityId == buffsDebuffs.shattering_strike) then
					if (settings.shattering_strike >= 1) then
						tName = LUNIT:GetNameForUnitId(tUnitId)
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_SHATTERINGSTRIKE), "mawLorkhaj", "shattering_strike")
						elseif (tName ~= "" and settings.shattering_strike >= 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_SHATTERINGSTRIKE_OTHER), tName), "mawLorkhaj", "shattering_strike")
						end
					end
				elseif (buffsDebuffs.rakkhat_threshingwings[abilityId]) then
					if settings.rakkhat_threshingwings then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_RAKKHAT_THRESHINGWINGS), "mawLorkhaj", "rakkhat_threshingwings")
					end
				elseif (buffsDebuffs.rakkhat_darknessfalls == abilityId) then
					if settings.rakkhat_darknessfalls then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_RAKKHAT_DARKNESSFALLS), "mawLorkhaj", "rakkhat_darknessfalls")
					end
				elseif (buffsDebuffs.rakkhat_darkbarrage[abilityId]) then
					if settings.rakkhat_darkbarrage then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_RAKKHAT_DARKBARRAGE), "mawLorkhaj", "rakkhat_darkbarrage", 12)
					end
				end

			elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then

				if (tType == COMBAT_UNIT_TYPE_PLAYER) then 

					--Grip of Lorkhaj (1st boss debuff)
					if (buffsDebuffs.zhaj_gripoflorkhaj[abilityId]) then
						if settings.zhaj_gripoflorkhaj then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_ZHAJ_GRIPOFLORKHAJ), "mawLorkhaj", "zhaj_gripoflorkhaj", 4)
						end
					end

					-- False Moon Twins, S’Kinrai and Vashai 
					if (buffsDebuffs.twinBoss_lunaraspect[abilityId]) then
						if settings.twinBoss_aspects >= 2 then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_LUNAR_ASPECT), "mawLorkhaj", "twinBoss_aspects", 4)
						end
						self:UpdateTwinAspect("lunar")
					elseif (buffsDebuffs.twinBoss_shadowaspect[abilityId]) then
						if settings.twinBoss_aspects >= 2 then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_SHADOW_ASPECT), "mawLorkhaj", "twinBoss_aspects", 4)
						end
						self:UpdateTwinAspect("shadow")
					elseif (buffsDebuffs.twinBoss_lunarconversion[abilityId]) then
						--conversion just started
						if settings.twinBoss_aspects >= 1 then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_LUNAR_CONVERSION), "mawLorkhaj", "twinBoss_aspects", 4)
						end
						self:UpdateTwinAspect("tolunar")
					elseif (buffsDebuffs.twinBoss_shadowconversion[abilityId]) then
						--conversion just started
						if settings.twinBoss_aspects >= 1 then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_SHADOW_CONVERSION), "mawLorkhaj", "twinBoss_aspects", 4)
						end
						self:UpdateTwinAspect("toshadow")
					end

					--Dro'm Athra Savage / Dro'm Athra Hulk: Armor Shatter
					if (buffsDebuffs.shattered[abilityId]) then
						if settings.shattered then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_SHATTERED), "mawLorkhaj", "shattered", 4)
						end
					end

					--Marked for Death (panthers)
					if (buffsDebuffs.markedfordeath[abilityId]) then
						if settings.markedfordeath then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_MARKEDFORDEATH), "mawLorkhaj", "markedfordeath", 4)
						end
					end

				end

				--Rakkhat, Fang of Lorkhaj
				if (abilityId == buffsDebuffs.rakkhat_unstablevoid) then
					if settings.rakkhat_unstablevoid >= 1 then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_RAKKHAT_UNSTABLE_VOID), "mawLorkhaj", "rakkhat_unstablevoid")
						elseif (tName ~= "" and (settings.rakkhat_unstablevoid == 2)) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_RAKKHAT_UNSTABLE_VOID_OTHER), tName), "mawLorkhaj", "rakkhat_unstablevoid")
						end
					end
				--elseif (buffsDebuffs.rakkhat_lunarbastion[abilityId]) then
				--	if settings.rakkhat_lunarbastion1 >= 1 then
				--		tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
				--		if (tType == COMBAT_UNIT_TYPE_PLAYER)  then
				--			if (settings.rakkhat_lunarbastion1 == 1 or settings.rakkhat_lunarbastion1 == 3) then --if "Self" or "All"
				--				self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_RAKKHAT_LUNARBASTION1), "mawLorkhaj", "rakkhat_lunarbastion1")
				--			end
				--		elseif (tName ~= "") then 
				--			if (settings.rakkhat_lunarbastion1 == 2 or settings.rakkhat_lunarbastion1 == 3) then --if "Other" or "All"
				--				self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_RAKKHAT_LUNARBASTION1_OTHER), tName), "mawLorkhaj", "rakkhat_lunarbastion1")
				--			end
				--		end
				--	end
				end

			elseif (result == ACTION_RESULT_EFFECT_FADED) then

				if (tType == COMBAT_UNIT_TYPE_PLAYER) then
					-- End of conversion now properly falls under ACTION_RESULT_EFFECT_FADED
					if (buffsDebuffs.twinBoss_lunarconversion[abilityId]) then
						--conversion ended
						if settings.twinBoss_aspects >= 3 then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_LUNAR_ASPECT), "mawLorkhaj", "twinBoss_aspects", 4)
						end
						self:UpdateTwinAspect("lunar")
					elseif (buffsDebuffs.twinBoss_shadowconversion[abilityId]) then
						--conversion ended
						if settings.twinBoss_aspects >= 3 then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_SHADOW_ASPECT), "mawLorkhaj", "twinBoss_aspects", 4)
						end
						self:UpdateTwinAspect("shadow")
					elseif (abilityId == buffsDebuffs.twinBoss_shadowaspectremove) then
						self:UpdateTwinAspect("none")
					elseif (abilityId == buffsDebuffs.twinBoss_lunaraspectremove) then
						self:UpdateTwinAspect("none")
					end
				end

				--if (buffsDebuffs.rakkhat_lunarbastion[abilityId]) then
				--	if settings.rakkhat_lunarbastion2 >= 1 then
				--		tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
				--		if (tType == COMBAT_UNIT_TYPE_PLAYER) then
				--			if (settings.rakkhat_lunarbastion2 == 1 or settings.rakkhat_lunarbastion2 == 3) then --if "Self" or "All"
				--				self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_RAKKHAT_LUNARBASTION2), "mawLorkhaj", "rakkhat_lunarbastion2")
				--			end
				--		elseif (tName ~= "") then 
				--			if (settings.rakkhat_lunarbastion2 == 2 or settings.rakkhat_lunarbastion2 == 3) then --if "Other" or "All"
				--				self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_MAWLORKHAJ_RAKKHAT_LUNARBASTION2_OTHER), tName), "mawLorkhaj", "rakkhat_lunarbastion2")
				--			end
				--		end
				--	end
				--end
			end

		elseif (raidId == RAID_MAELSTROM_ARENA) then
			local buffsDebuffs, settings = self.BuffsDebuffs.maelstrom, self.Vars.maelstrom

			if (result == ACTION_RESULT_BEGIN) then
			elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then

				if (tType == COMBAT_UNIT_TYPE_PLAYER) then

					if (buffsDebuffs.stage7_poison[abilityId]) then 
						if settings.stage7_poison then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAELSTROM_STAGE7_POISON), "maelstrom", "stage7_poison", 15)
						end

					elseif (buffsDebuffs.stage9_synergy == abilityId) then
						if settings.stage9_synergy then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_MAELSTROM_STAGE9_SYNERGY), "maelstrom", "stage9_synergy", 15)
						end

					end

				end
			end

		elseif (raidId == RAID_HALLS_OF_FABRICATION) then
			local buffsDebuffs, settings = self.BuffsDebuffs.halls_fab, self.Vars.hallsFab

			if (result == ACTION_RESULT_BEGIN) then
				if (abilityId == buffsDebuffs.taking_aim) then
					if (settings.taking_aim >= 1) then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
							if (self:IsDevMode() and settings.taking_aim == 1 and settings.taking_aim_dynamic == true) then
								dbg("Taking Aim incoming from Sphere #%d", sUnitId)
								buffsDebuffs.taking_aim_index = self:StartCountdown(settings.taking_aim_duration, GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_TAKING_AIM), "hallsFab", "taking_aim")
								self.Minions.incomingSource = sUnitId
							else
								self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_TAKING_AIM), "hallsFab", "taking_aim")
							end
						elseif (tName ~= "" and settings.taking_aim == 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_TAKING_AIM_OTHER), tName), "hallsFab", "taking_aim")
						end
					end
				elseif (buffsDebuffs.conduit_strike[abilityId] == true) then
					if (settings.conduit_strike == true) then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_CONDUIT_STRIKE), "hallsFab", "conduit_strike")
					end
				elseif (abilityId == buffsDebuffs.pinnacleBoss_conduit_spawn) then
					if (settings.pinnacleBoss_conduit_spawn == true) then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_CONDUIT_SPAWN), "hallsFab", "pinnacleBoss_conduit_spawn")
					end
				elseif (abilityId == buffsDebuffs.pinnacleBoss_conduit_drain) then
					if settings.pinnacleBoss_conduit_drain >= 1 then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_CONDUIT_DRAIN), "hallsFab", "pinnacleBoss_conduit_drain")
						elseif (tName ~= "" and settings.pinnacleBoss_conduit_drain == 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_CONDUIT_DRAIN_OTHER), tName), "hallsFab", "pinnacleBoss_conduit_drain")
						end
					end
				elseif (abilityId == buffsDebuffs.committee_fabricant_spawn) then --start of wave
					if (settings.committee_fabricant_spawn == true) then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_FABRICANT_SPAWN), "hallsFab", "committee_fabricant_spawn", 4) -- rewrite it to use CountDown method like auras
					end
				end

			elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then
				if (abilityId == buffsDebuffs.draining_ballista) then
					if (settings.draining_ballista >= 1) then
						tName = LUNIT:GetNameForUnitId(tUnitId) --isn't supplied by event for group members, only for the player
						if (tType == COMBAT_UNIT_TYPE_PLAYER) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_DRAINING_BALLISTA), "hallsFab", "draining_ballista", 4) -- do we need this 4sec delay?
						elseif (tName ~= "" and settings.draining_ballista == 2) then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_DRAINING_BALLISTA_OTHER), tName), "hallsFab", "draining_ballista", 4)
						end
					end
				elseif (abilityId == buffsDebuffs.power_leech) then
					if (tType == COMBAT_UNIT_TYPE_PLAYER) then 
						if (settings.power_leech == true) then
							self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_POWER_LEECH), "hallsFab", "power_leech")
						end
					end
				elseif (abilityId == buffsDebuffs.committee_overheat_aura or abilityId == buffsDebuffs.committee_overload_aura) then -- not checking for "committee_overcharge_aura" since it isn't involved in the swapping
					-- right we dont care that this occurs multiple times in a row
					if (settings.committee_overpower_auras == true) then
						buffsDebuffs.committee_countdown_index = self:StartCountdown(settings.committee_overpower_auras_duration, GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_OVERPOWER_AURAS), "hallsFab", "committee_overpower_auras")
						if (self:IsDevMode() and settings.committee_overpower_auras_dynamic == true) then
							buffsDebuffs.committee_overpower_auras_total = (buffsDebuffs.committee_overpower_auras_total or 0) + 1
							buffsDebuffs.committee_overheat_target = nil
							buffsDebuffs.committee_overload_target = nil
						end
					end
				--elseif abilityId == buffsDebuffs.hunters_spawn_sphere then
				--	dbg("Spawn Sphere #%d (%d)", tUnitId, result)
				--	self.Minions[tUnitId] = abilityId -- to keep track of what spawned this minion
				end

			elseif (result == ACTION_RESULT_EFFECT_GAINED) then
				if (abilityId == buffsDebuffs.committee_reclaim_achieve) then
					if (settings.committee_reclaim_achieve == true) then
						self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_HALLSFAB_RECLAIM_ACHIEVE), "hallsFab", "committee_reclaim_achieve", 10)
					end
				elseif (abilityId == buffsDebuffs.committee_overheat or abilityId == buffsDebuffs.committee_overload) then
					if self:IsDevMode() then
						if (settings.committee_overpower_auras_dynamic == true) then
							if (Util.SafeInt(buffsDebuffs.committee_countdown_index) > 0) then --only run while countdown is still happening
								local key = (abilityId == buffsDebuffs.committee_overload) and "committee_overload_target" or "committee_overheat_target"
								local lastTarget = buffsDebuffs[key]
								buffsDebuffs[key] = tUnitId
								if (lastTarget ~= nil and lastTarget ~= buffsDebuffs[key]) then -- tanks have swapped?
									dbg("%s changed from %s to %s", key, LUNIT:GetNameForUnitId(lastTarget), LUNIT:GetNameForUnitId(tUnitId))
									local stopCountdown = false
									if (tType == COMBAT_UNIT_TYPE_PLAYER) then
										-- we are tanking and have just gotten aggro from the other boss, stop the timer??
										dbg("Stop countdown for us cuz we did our job as tank")
										stopCountdown = true
									else
										-- continue the timer until the other boss is switched too
										buffsDebuffs.committee_overpower_auras_total = buffsDebuffs.committee_overpower_auras_total - 1
										if (buffsDebuffs.committee_overpower_auras_total <= 0) then
											dbg("Both bosses have been switched")
											stopCountdown = true
										end
									end

									if (stopCountdown) then
										dbg("Stopping countdown")
										self:StopCountdown(buffsDebuffs.committee_countdown_index)
										buffsDebuffs.committee_countdown_index = 0 -- don't set it to nil
									end
								end
							end
						end
					end
				end

			elseif (result == ACTION_RESULT_EFFECT_FADED) then
				if (abilityId == buffsDebuffs.committee_overheat_aura or abilityId == buffsDebuffs.committee_overload_aura) then 
					if self:IsDevMode() then
						if (settings.committee_overpower_auras_dynamic == true) then
							self:StopCountdown(buffsDebuffs.committee_countdown_index)
							buffsDebuffs.committee_countdown_index = 0 -- don't set it to nil
							buffsDebuffs.committee_overload_target = nil
							buffsDebuffs.committee_overheat_target = nil
							buffsDebuffs.committee_overpower_auras_total = 0
						end
					end
				end

			elseif (result == ACTION_RESULT_INTERRUPT) then
				--if self.Minions[tUnitId] == buffsDebuffs.hunters_spawn_sphere then
					if tUnitId == self.Minions.incomingSource then
						dbg("Sphere #%d was interrupted", tUnitId)
						self.Minions.incomingSource = nil
						--self:StopCountdown(buffsDebuffs.taking_aim_index)
						--buffsDebuffs.taking_aim_index = 0 -- don't set it to nil
					end
				--end
			elseif (result == ACTION_RESULT_DIED) then
				--if self.Minions[tUnitId] == buffsDebuffs.hunters_spawn_sphere then
					if tUnitId == self.Minions.incomingSource then
						dbg("Sphere #%d died", tUnitId)
						self.Minions.incomingSource = nil
						--self:StopCountdown(buffsDebuffs.taking_aim_index)
						--buffsDebuffs.taking_aim_index = 0 -- don't set it to nil
					end
					--self.Minions[tUnitId] = nil 
				--end
			end
		end

	end


	-------------------
	---- Debugging ----
	-------------------
	local debugList    = {}
	for _, result in ipairs(ActionResults) do
		debugList[result] = {}
	end
	local debugMsg = "[%d] %s (%d)%s%s"

	local trackedUnits = {}
	local function OnCombatDebugEvent(_, result, isError, aName, aGraphic, aActionSlotType, sName, sType, tName, tType, hitValue, pType, dType, log, sUnitId, tUnitId, abilityId)

		local self   = RaidNotifier
		
		--if self.Vars.dbg.units then
		--	local function CheckUnit(id, name, type)
		--		if id > 0 and abilityId ~= 90463 and not trackedUnits[id] then
		--			if LUNIT:GetNameForUnitId(id) == "" then -- not a known unit like group members or bosses
		--				trackedUnits[id] = true
		--				df("Found new unit #%d (%d, %s)", id, abilityId, GetAbilityName(abilityId))
		--			end
		--		end
		--	end
		--	--CheckUnit(sUnitId, sName, sType)
		--	CheckUnit(tUnitId, tName, tType)
		--end

		if (self.Vars.dbg.tracker and debugList[result] ~= nil) then
			local function FormatUnit(prefix, uType, uName, uId)
				if uId == 0 then
					return ""
				else
					uName = uName ~= "" and uName or LUNIT:GetNameForUnitId(uId)
					if uName ~= "" then
						return zo_strformat("<<1>><<t:2>>", prefix, uName)
					else
						return zo_strformat("<<1>><<2>>/<<3>>", prefix, uType, uId)
					end
				end
			end

			if (not debugList[result][abilityId]) or (not self.Vars.dbg.spamControl) then
				if (tType == COMBAT_UNIT_TYPE_PLAYER and (sType == COMBAT_UNIT_TYPE_OTHER or sType == COMBAT_UNIT_TYPE_NONE) or (not self.Vars.dbg.myEnemyOnly)) then
			
					local source = FormatUnit(", [S] ", sType, sName, sUnitId)
					local target = FormatUnit(", [T] ", tType, tName, tUnitId)
					local ability = (aName ~= "" and aName ~= nil) and aName or GetAbilityName(abilityId)

					debugList[result][abilityId] = self.Vars.dbg.spamControl
					d(debugMsg:format(result, ability, abilityId, source, target))
				
				end
			end
		end
	end
	
	function RaidNotifier:ToggleDebugTracker(enabled)
		self:UnregisterForCombatEvent("debug")
		if enabled then 
			self:RegisterForCombatEvent("debug", OnCombatDebugEvent)
		end
	end
	
	-- Fast debug toggle
	SLASH_COMMANDS["/rndebug"] = function(str) 
		local args = {zo_strsplit(" ", str)}

		local self     = RaidNotifier
		local settings = self.Vars.dbg

		if (args[1] == "track") then
			settings.tracker = Util.GetArgValue(args[2], settings.tracker)
			p("%s Debug Tracker", settings.tracker and "Enabled" or "Disabled")
			self:ToggleDebugTracker(settings.tracker or settings.units)
		elseif (args[1] == "units") then
			settings.units = Util.GetArgValue(args[2], settings.units)
			p("%s Debug Units", settings.units and "Enabled" or "Disabled")
			self:ToggleDebugTracker(settings.units or settings.tracker)
		elseif (args[1] == "spam") then
			settings.spamControl = Util.GetArgValue(args[2], settings.spamControl)
			p("%s Spam Control", settings.spamControl and "Enabled" or "Disabled")
		elseif (args[1] == "enemy") then
			settings.myEnemyOnly = Util.GetArgValue(args[2], settings.myEnemyOnly)
			p("%s My Enemy Only", settings.myEnemyOnly and "Enabled" or "Disabled")
		elseif (args[1] == "clear") then
			local result = tonumber(args[2])
			if result ~= nil then 
				p("Clearing debug list [%d]", result)
				debugList[result] = {}
			else
				p("Clearing all debug lists")
				for _, result in ipairs(debugResults) do
					debugList[result] = {}
				end
			end
		elseif (Util.GetArgValue(args[1]) ~= nil) then
			settings.enabled = Util.GetArgValue(args[1], settings.enabled)
			p("%s Debugging", settings.enabled and "Enabled" or "Disabled")
		end
	end

end


-- -----------------------------
-- EVENT: EVENT_EFFECT_CHANGED
do -----------------------------

	local Util  = RaidNotifier.Util

	function RaidNotifier.OnEffectChanged(eventCode, changeType, eSlot, eName, uTag, beginTime, endTime, stackCount, iconName, buffType, eType, aType, statusEffectType, uName, uId, abilityId, uType) 

		local raidId = RaidNotifier.raidId
		local self   = RaidNotifier

		-- Unregister if we left the raid instance
		--if self:IsInRaidZone() == false then
		--	self:UnregisterEvents()
		--	return
		--end

		-- try debugging poison spread in Sanctum (SHELVED INDEFINITELY)
		--if (raidId == RAID_SANCTUM_OPHIDIA) then
		--	local buffsDebuffs, settings = self.BuffsDebuffs.sanctum_ophidia, self.Vars.sanctumOphidia
        --
		--	if uTag == "player" then
		--		local poisonType = buffsDebuffs.spreading_poison[abilityId]
		--		if poisonType and changeType ~= EFFECT_RESULT_FADED then
		--			dbg("Spreading Poison Type%d (#%d) time=%d", poisonType, abilityId, endTime - beginTime)
		--		end
		--	end
		--end
		
		-- HoF is the first raid to make it here! WHOOHOOW!! (all cuz we needz dem stackcount)
		if (raidId == RAID_HALLS_OF_FABRICATION) then
			local buffsDebuffs, settings = self.BuffsDebuffs.halls_fab, self.Vars.hallsFab
			
			--if (uType == COMBAT_UNIT_TYPE_PLAYER) then -- doesn't seem to be the case even when it really is the player
			if (uTag == "player") then
				if abilityId == buffsDebuffs.pinnacleBoss_scalded_debuff then
					if settings.pinnacleBoss_scalded == true then
						if (changeType == EFFECT_RESULT_FADED) then
							--dbg("Scalded debuff faded")
							self:UpdateScaldedStacks(0)
						else
							--dbg("Scalded Debuff: #%d stacks", stackCount)
							self:UpdateScaldedStacks(stackCount, beginTime, endTime)
						end
					end
				elseif abilityId == buffsDebuffs.venom_injection then
					if settings.venom_injection then
						self:UpdateSphereVenom(changeType ~= EFFECT_RESULT_FADED, beginTime, endTime)
					end
				end
			end
		end

		-- Buff Food
		-- TODO: Replace, Remove or Revamp???
		if (self.Vars.general.buffFood_reminder and uType == COMBAT_UNIT_TYPE_PLAYER) then
			local buffsDebuffs = self.BuffsDebuffs.buffFood
			local buffFoodFound = false
			local reminderInterval = self.Vars.general.buffFood_reminder_interval

			local numAuras = GetNumBuffs("player")
			if (numAuras > 0) then
				for x = 1, numAuras do
					local name, _, finish, _, _, _, _, _, _, _, abilityId, _ = GetUnitBuffInfo('player', x)
					if buffsDebuffs[abilityId] then
						buffFoodFound = true

						local bufffood_remaining = finish - (GetFrameTimeMilliseconds() / 1000)
						local formatedTime       = ZO_FormatTime(bufffood_remaining, TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_SECONDS)

						-- new set interval
						if bufffood_remaining <= 600 then
							self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_GENERAL_BUFFFOOD_MINUTES), name, formatedTime), "general", "buffFood_reminder", reminderInterval)
						end
					end
				end
			end
			-- no bufffood found, alert every interval
			if buffFoodFound == false then
				self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_GENERAL_NO_BUFFFOOD), "general", "buffFood_reminder", reminderInterval)
			end
		end

	end

end


-- ----------------------------
-- EVENT: EVENT_ADD_ON_LOADED
-- ----------------------------
local function OnAddonLoaded(_, addonName)
    if addonName ~= RaidNotifier.Name then return end
    EVENT_MANAGER:UnregisterForEvent(RaidNotifier.Name, EVENT_ADD_ON_LOADED)
	RaidNotifier:Initialize()
end
EVENT_MANAGER:RegisterForEvent(RaidNotifier.Name, EVENT_ADD_ON_LOADED, OnAddonLoaded)
