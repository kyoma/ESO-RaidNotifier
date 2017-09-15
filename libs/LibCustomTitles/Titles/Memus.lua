local MY_MODULE_NAME = "Memus"
local MY_MODULE_VERSION = 3

local LCC = LibStub('LibCustomTitlesRN')
if not LCC then return end

local MY_MODULE = LCC:RegisterModule(MY_MODULE_NAME, MY_MODULE_VERSION)
if not MY_MODULE then return end


MY_MODULE:RegisterTitle("@memus", nil, 92, {en = "Paid Healer"}, {color={"#22E500", "#BF0000"}})
MY_MODULE:RegisterTitle("@memus", nil, 93, {en = "Vitality Bonus Increaser"}, {color={"#052FCC", "#12CCDE"}})
MY_MODULE:RegisterTitle("@Panadulek", nil, 92, {en = "Pyrotechnic Dragon Lord"}, {color={"#F5C514", "#D20F08"}})
MY_MODULE:RegisterTitle("@Panadulek", nil, 1838, {en = "Tick-Tock Terrorizer"}, {color={"#F5C514", "#D20F08"}})
MY_MODULE:RegisterTitle("@Lancast'X", nil, 92, {en = "Toxic Player"}, {color="#00a9e7"})
MY_MODULE:RegisterTitle("@Zathurin", nil, 702, {en = "Tempest Warlock"}, {color={"#009AE5", "#6C12CD"}})
--MY_MODULE:RegisterTitle("@Zedh", nil, 92, {en = "", de = "Kampfi's Liebling"}, {color={"#65F1C9","#D6C800"}})
MY_MODULE:RegisterTitle("@IWM", nil, 92, {en = "The One And Only"}, {color="#A615C1"})
MY_MODULE:RegisterTitle("@Hjelmi", nil, 1728, {en = "Supreme Healer"}, {color={"#F29CD3", "#91D3F8"}})
MY_MODULE:RegisterTitle("@peniku8", nil, 92, {en = "Plague Cycle"}, {color="#6c00ff"})
MY_MODULE:RegisterTitle("@Tapalori", nil, 92, {en = "The Bear"})
MY_MODULE:RegisterTitle("@VanaEvr", nil, 92, {en = "Vana's Fishing Emporium"}, {color={"#FF8AC7", "#FFF366"}})
MY_MODULE:RegisterTitle("@kilnerdyne", nil, 92, {en = "Late Night Master"}, {color={"#2277BB", "#005599"}})
--MY_MODULE:RegisterTitle("@Paulington", nil, 92, {en = "Community Ambassador", de = "Community-Botschaffe"}, {color="#9000f4"})
MY_MODULE:RegisterTitle("@Deltia84", nil, 1391, { en = "Engine Guardian Master" }, {color={"#36A7D6", "#12CCDE"}})
