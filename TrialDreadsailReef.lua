RaidNotifier = RaidNotifier or {}
RaidNotifier.DSR = {}

local RaidNotifier = RaidNotifier

local function p() end
local function dbg() end

local data = {}

function RaidNotifier.DSR.Initialize()
    p = RaidNotifier.p
    dbg = RaidNotifier.dbg

    data = {}
end

function RaidNotifier.DSR.OnCombatEvent(_, result, isError, aName, aGraphic, aActionSlotType, sName, sType, tName, tType, hitValue, pType, dType, log, sUnitId, tUnitId, abilityId)
    local raidId = RaidNotifier.raidId
    local self   = RaidNotifier
    local buffsDebuffs, settings = self.BuffsDebuffs[raidId], self.Vars.dreadsailReef

    if (tName == nil or tName == "") then
        tName = self.UnitIdToString(tUnitId)
    end

    if (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then
        -- Lylanar's Imminent Blister debuff
        if (abilityId == buffsDebuffs.lylanar_imminent_blister and settings.imminent_debuffs) then
            if (tType == COMBAT_UNIT_TYPE_PLAYER) then
                self:StartCountdown(hitValue, GetString(RAIDNOTIFIER_ALERTS_DREADSAILREEF_IMMINENT_BLISTER), "dreadsailReef", "imminent_debuffs", true)
            elseif (tName ~= "") then
                self:StartCountdown(hitValue, zo_strformat(GetString(RAIDNOTIFIER_ALERTS_DREADSAILREEF_IMMINENT_BLISTER_OTHER), tName), "dreadsailReef", "imminent_debuffs", true)
            end
        -- Turlassil's Imminent Chill debuff
        elseif (abilityId == buffsDebuffs.turlassil_imminent_chill and settings.imminent_debuffs) then
            if (tType == COMBAT_UNIT_TYPE_PLAYER) then
                self:StartCountdown(hitValue, GetString(RAIDNOTIFIER_ALERTS_DREADSAILREEF_IMMINENT_CHILL), "dreadsailReef", "imminent_debuffs", true)
            elseif (tName ~= "") then
                self:StartCountdown(hitValue, zo_strformat(GetString(RAIDNOTIFIER_ALERTS_DREADSAILREEF_IMMINENT_CHILL_OTHER), tName), "dreadsailReef", "imminent_debuffs", true)
            end
        end
    end
end
