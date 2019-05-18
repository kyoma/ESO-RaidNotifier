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
		if (buffsDebuffs.sweeping_breath[abilityId]) then
			pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_SWEEPING_BREATH), 3000)
			PlaySound(self.Vars.general.default_sound)
		elseif (buffsDebuffs.focus_fire) then
			data.fire_breath = 5
			pool:Add(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_FOCUS_FIRE), tName), 3000)
			PlaySound(self.Vars.general.default_sound)
		end
	elseif (result == ACTION_RESULT_EFFECT_GAINED) then
		if (buffsDebuffs.molten_meteor == true) then
			pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_MOLTEN_METEOR), 3000)
			PlaySound(self.Vars.general.default_sound)			
		end
	elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then
	elseif (result == ACTION_RESULT_EFFECT_FADED) then
		if (buffsDebuffs.fire_breath) then
			if (tType == COMBAT_UNIT_TYPE_PLAYER) then
				pool:Add(GetString(RAIDNOTIFIER_ALERTS_SUNSPIRE_FIRE_BREATH), 1000)
			end
			data.fire_breath = data.fire_breath - 1			
		end
	end
end