local MY_MODULE_NAME = "Memus"
local MY_MODULE_VERSION = 4

local LCC = LibStub('LibCustomTitlesRN')
if not LCC then return end

local MY_MODULE = LCC:RegisterModule(MY_MODULE_NAME, MY_MODULE_VERSION)
if not MY_MODULE then return end


MY_MODULE:RegisterTitle("@memus", nil, 92, {en = "Paid Healer"}, {color={"#22E500", "#BF0000"}})
MY_MODULE:RegisterTitle("@memus", nil, 1391, {en = "Paid Healer"}, {color={"#22E500", "#BF0000"}})
MY_MODULE:RegisterTitle("@Panadulek", nil, 92, {en = "Pyrotechnic Dragon Lord"}, {color={"#F5C514", "#D20F08"}})
MY_MODULE:RegisterTitle("@Panadulek", nil, 1838, {en = "Tick-Tock Terrorizer"}, {color={"#F5C514", "#D20F08"}})
MY_MODULE:RegisterTitle("@Lancast'X", nil, 92, {en = "Toxic Player"}, {color="#00a9e7"})
MY_MODULE:RegisterTitle("@Lancast'X", nil, 1391, {en = "Sponsored by IronPlaf"}, {color="#00a9e7"})
MY_MODULE:RegisterTitle("@Zathurin", nil, 702, {en = "Tempest Warlock"}, {color={"#009AE5", "#6C12CD"}})
--MY_MODULE:RegisterTitle("@Zedh", nil, 92, {en = "", de = "Kampfi's Liebling"}, {color={"#65F1C9","#D6C800"}})
MY_MODULE:RegisterTitle("@ZoM_Head", nil, 51, {en = "Top Pirate"})
MY_MODULE:RegisterTitle("@peniku8", nil, 92, {en = "Plague Cycle"}, {color="#6c00ff"})
MY_MODULE:RegisterTitle("@Tapalori", nil, 92, {en = "The Bear"})
MY_MODULE:RegisterTitle("@kilnerdyne", nil, 92, {en = "Late Night Master"}, {color={"#2277BB", "#005599"}})
