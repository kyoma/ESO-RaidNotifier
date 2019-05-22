RaidNotifier = RaidNotifier or {}
RaidNotifier.SS = {}

local RaidNotifier = RaidNotifier

local function p() end
local function dbg() end

local data = {}

function RaidNotifier.SS.Initialize()
	p = RaidNotifier.p
	dbg = RaidNotifier.dbg
end

function RaidNotifier.SS.OnCombatEvent(_, result, isError, aName, aGraphic, aActionSlotType, sName, sType, tName, tType, hitValue, pType, dType, log, sUnitId, tUnitId, abilityId)
	local raidId = RaidNotifier.raidId
	local self   = RaidNotifier
	local buffsDebuffs, settings = self.BuffsDebuffs[raidId], self.Vars.sunspire
	local pool = self.NotificationsPool.GetInstance()
	
	if (tName == nil or tName == "") then
		tName = self.UnitIdToString(tUnitId)
	end
	
	local time = string.format("%s:%03d ", GetTimeString(), GetGameTimeMilliseconds() % 1000)
	d(string.format("%s [%d] %s(%d) %s => %s", time, result, GetAbilityName(abilityId), abilityId, tostring(hitValue), tName))

	if (result == ACTION_RESULT_BEGIN) then
		if (buffsDebuffs.door_protection_ice == abilityId) then
			data.frozen_tomb = 0
		elseif (buffsDebuffs.frozen_tomb == abilityId) then
			data.frozen_tomb = data.frozen_tomb or 0
			pool:Add(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_FROZEN_TOMB), data.frozen_tomb % 3 + 1), 3000)
			PlaySound(self.Vars.general.default_sound)
			data.frozen_tomb = data.frozen_tomb + 1
		elseif (buffsDebuffs.molten_meteor == abilityId) then
			if (tType == COMBAT_UNIT_TYPE_PLAYER) then
				pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_MOLTEN_METEOR), 3000)
				PlaySound(self.Vars.general.default_sound)
			end			
		elseif (buffsDebuffs.sweeping_breath[abilityId]) then
			pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_SWEEPING_BREATH), 3000)
			PlaySound(self.Vars.general.default_sound)
		elseif (buffsDebuffs.focus_fire == abilityId) then
--			data.focus_fire = 5
			if (tType == COMBAT_UNIT_TYPE_PLAYER) then
				pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_FOCUS_FIRE), 3000, true)
			elseif (tName ~= "") then
				pool:Add(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_FOCUS_FIRE_OTHER), tName), 3000, true)
			end
			PlaySound(self.Vars.general.default_sound)
--		elseif (buffsDebuffs.atronach_zap == abilityId) then
--			pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_ATRONACH_ZAP), buffsDebuffs.atronach_zap + hitValue, true)
--			PlaySound(self.Vars.general.default_sound)
		elseif (buffsDebuffs.breath[abilityId]) then
			if (tType == COMBAT_UNIT_TYPE_PLAYER) then
				pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_BREATH), 3000)
			elseif (tName ~= "") then
				pool:Add(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_BREATH_OTHER), tName), 3000)
			end
			PlaySound(self.Vars.general.default_sound)
		end
	elseif (result == ACTION_RESULT_EFFECT_GAINED) then
--		if (buffsDebuffs.frost_atronach == abilityId) then
--			pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_FROST_ATRONACH), 3000)
--			PlaySound(self.Vars.general.default_sound)
--		end
	elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then
		if (buffsDebuffs.chilling_comet == abilityId) then
			if (tType == COMBAT_UNIT_TYPE_PLAYER) then
				pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_CHILLING_COMET), 3000)
				PlaySound(self.Vars.general.default_sound)
			end
		elseif (buffsDebuffs.cataclism == abilityId) then
			pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_CATACLISM), hitvalue, true)
			PlaySound(self.Vars.general.default_sound)
		end
	elseif (result == ACTION_RESULT_EFFECT_FADED) then
--[[		if (buffsDebuffs.fire_breath) then
			if (tType == COMBAT_UNIT_TYPE_PLAYER) then
				pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_FOCUS_FIRE_TICK, data.focus_fire), 1000)
			end
			data.focus_fire = data.focus_fire - 1
		end
--]]
	end
end
