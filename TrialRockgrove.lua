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
        -- Sul-Xan Soulweaver's Astral Shield (cast)
        elseif (abilityId == buffsDebuffs.sulxan_soulweaver_astral_shield_cast) then
            if (settings.sulxan_soulweaver_astral_shield) then
                self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ROCKGROVE_ASTRAL_SHIELD_CAST), "rockgrove", "sulxan_soulweaver_astral_shield")
            end
        -- Sul-Xan Soulweaver's Soul Extraction
        elseif (buffsDebuffs.sulxan_soulweaver_soul_extraction[abilityId]) then
            if (settings.sulxan_soulweaver_soul_extraction and tType == COMBAT_UNIT_TYPE_PLAYER) then
                self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ROCKGROVE_SOUL_EXTRACTION), "rockgrove", "sulxan_soulweaver_soul_extraction")
            end
        -- Havocrel Barbarian's Hasted Assault
        elseif (buffsDebuffs.havocrel_barbarian_hasted_assault[abilityId]) then
            if (settings.havocrel_barbarian_hasted_assault) then
                self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ROCKGROVE_HASTED_ASSAULT), "rockgrove", "havocrel_barbarian_hasted_assault")
            end
        end
    elseif (result == ACTION_RESULT_EFFECT_GAINED_DURATION) then
        -- Sul-Xan Soulweaver's Soul Extraction (Debug purpose only!)
        if (buffsDebuffs.sulxan_soulweaver_soul_extraction[abilityId]) then
            if (settings.sulxan_soulweaver_soul_extraction and tType == COMBAT_UNIT_TYPE_PLAYER) then
                self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ROCKGROVE_SOUL_EXTRACTION) .. " (GainDur)", "rockgrove", "sulxan_soulweaver_soul_extraction")
            end
        end
    elseif (result == ACTION_RESULT_EFFECT_FADED) then
        -- Sul-Xan Soulweaver's Soul Remnant attack (his Astral Shield is broken)
        if (abilityId == buffsDebuffs.sulxan_soulweaver_astral_shield_self) then
            if (settings.sulxan_soulweaver_astral_shield) then
                self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ROCKGROVE_SOUL_REMNANT_HEAVY), "rockgrove", "sulxan_soulweaver_astral_shield")
            end
        -- Other's Soul Remnant attack (Astral Shield gained from Soulweaver is broken)
        elseif (abilityId == buffsDebuffs.sulxan_soulweaver_astral_shield_others) then
            if (settings.sulxan_soulweaver_astral_shield) then
                self:AddAnnouncement(GetString(RAIDNOTIFIER_ALERTS_ROCKGROVE_SOUL_REMNANT), "rockgrove", "sulxan_soulweaver_astral_shield")
            end
        end
    end
end
