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
        -- Bloodknight's Blood Fountain
        if (abilityId == buffsDebuffs.bloodknight_blood_fountain) then
            if (settings.bloodknight_blood_fountain == true) then
                self:StartCountdown(hitValue, GetString(RAIDNOTIFIER_ALERTS_KYNESAEGIS_BLOOD_FOUNTAIN), "kynesAegis", "bloodknight_blood_fountain", false)
            end
        end
    elseif (result == ACTION_RESULT_EFFECT_GAINED) then
        -- Bitter Knight's Sanguine Prison
        if (abilityId == buffsDebuffs.bitter_knight_sanguine_prison) then
            if (settings.bitter_knight_sanguine_prison == true) then
                if (tType ~= COMBAT_UNIT_TYPE_PLAYER and tName ~= "") then
                    self:AddAnnouncement(zo_strformat(GetString(RAIDNOTIFIER_ALERTS_KYNESAEGIS_SANGUINE_PRISON_OTHER), tName), "kynesAegis", "bitter_knight_sanguine_prison")
                end
            end
        end
    end
end
