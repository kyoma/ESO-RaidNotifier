RaidNotifier = RaidNotifier or {}
RaidNotifier.RG = {}

local RaidNotifier = RaidNotifier

local function p() end
local function dbg() end

local data = {}

function RaidNotifier.RG.Initialize()
    p = RaidNotifier.p
    dbg = RaidNotifier.dbg

    data = {}
end

function RaidNotifier.RG.OnCombatEvent(_, result, isError, aName, aGraphic, aActionSlotType, sName, sType, tName, tType, hitValue, pType, dType, log, sUnitId, tUnitId, abilityId)
    local raidId = RaidNotifier.raidId
    local self   = RaidNotifier
    local buffsDebuffs, settings = self.BuffsDebuffs[raidId], self.Vars.rockgrove

    if (tName == nil or tName == "") then
        tName = self.UnitIdToString(tUnitId)
    end

    if (result == ACTION_RESULT_BEGIN) then
        -- Sul-Xan Reaver's Sundering Strike
        if (abilityId == buffsDebuffs.sulxan_reaver_sundering_strike) then
            if (settings.sulxan_reaver_sundering_strike >= 1 and tType == COMBAT_UNIT_TYPE_PLAYER) then
                self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ROCKGROVE_SUNDERING_STRIKE), "rockgrove", "sulxan_reaver_sundering_strike")
            elseif (settings.sulxan_reaver_sundering_strike == 2 and tName ~= "") then
                self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_ROCKGROVE_SUNDERING_STRIKE_OTHER), tName), "rockgrove", "sulxan_reaver_sundering_strike")
            end
        end
    end
end
