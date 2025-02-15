RaidNotifier = RaidNotifier or {}
RaidNotifier.SE = {}

local RaidNotifier = RaidNotifier

local function p() end
local function dbg() end

local data = {}

function RaidNotifier.SE.Initialize()
    p = RaidNotifier.p
    dbg = RaidNotifier.dbg

    data = {}
end

function RaidNotifier.SE.OnCombatEvent(_, result, _, _, _, _, _, _, tName, tType, hitValue, _, _, _, _, tUnitId, abilityId)
    local raidId = RaidNotifier.raidId
    local self   = RaidNotifier
    local buffsDebuffs, settings = self.BuffsDebuffs[raidId], self.Vars.sanityEdge

    if (tName == nil or tName == "") then
        tName = self.UnitIdToString(tUnitId)
    end
end
