RaidNotifier = RaidNotifier or {}
RaidNotifier.KA = {}

local RaidNotifier = RaidNotifier

local function p() end
local function dbg() end

local data = {}

function RaidNotifier.KA.Initialize()
    p = RaidNotifier.p
    dbg = RaidNotifier.dbg

    data = {}
end

function RaidNotifier.KA.OnCombatEvent(_, result, isError, aName, aGraphic, aActionSlotType, sName, sType, tName, tType, hitValue, pType, dType, log, sUnitId, tUnitId, abilityId)
    local raidId = RaidNotifier.raidId
    local self   = RaidNotifier
    local buffsDebuffs, settings = self.BuffsDebuffs[raidId], self.Vars.kynesAegis

    if (tName == nil or tName == "") then
        tName = self.UnitIdToString(tUnitId)
    end

    if (result == ACTION_RESULT_BEGIN) then
        -- Half-Giant Tidebreaker's Crashing Wall
        if (abilityId == buffsDebuffs.tidebreaker_crashing_wall) then
            if (settings.tidebreaker_crashing_wall == true) then
                self:StartCountdown(hitValue, GetString(RAIDNOTIFIER_ALERTS_KYNESAEGIS_CRASHING_WALL), "kynesAegis", "tidebreaker_crashing_wall", false)
            end
        end
    end
end
