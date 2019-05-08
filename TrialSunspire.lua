RaidNotifier = RaidNotifier or {}
RaidNotifier.SS = {}

local RaidNotifier = RaidNotifier

local function p() end
local function dbg() end

function RaidNotifier.SS.Initialize()
	p = RaidNotifier.p
	dbg = RaidNotifier.dbg
end

function RaidNotifier.SS.OnCombatEvent(_, result, isError, aName, aGraphic, aActionSlotType, sName, sType, tName, tType, hitValue, pType, dType, log, sUnitId, tUnitId, abilityId)
	local raidId = RaidNotifier.raidId
	local self   = RaidNotifier
	local buffsDebuffs, settings = self.BuffsDebuffs[raidId], self.Vars.sunspire
	
	if (tName == nil or tName == "") then
		tName = self.UnitIdToString(tUnitId)
	end
	
	local time = string.format("%s:%03d ", GetTimeString(), GetGameTimeMilliseconds() % 1000)
	d(string.format("%s [%d] %s(%d) %s => %s", time, result, GetAbilityName(abilityId), abilityId, tostring(hitValue), tName))

	if (result == ACTION_RESULT_BEGIN) then
	elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then
	end
end