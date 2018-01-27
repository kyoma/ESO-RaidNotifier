local MY_MODULE_NAME = "Woeler"
local MY_MODULE_VERSION = 5

local LCC = LibStub('LibCustomTitlesRN')
if not LCC then return end

local MY_MODULE = LCC:RegisterModule(MY_MODULE_NAME, MY_MODULE_VERSION)
if not MY_MODULE then return end


MY_MODULE:RegisterTitle("@Fuzubu",        nil, 1391, {en = "Cat-Healer", de = "Katzenheiler"})
MY_MODULE:RegisterTitle("@Rogue78",       nil,   92, {en = "Plopkoek"})
MY_MODULE:RegisterTitle("@Tino93",        nil, 1391, {en = "Procerer", de = "Der Procerer"})
MY_MODULE:RegisterTitle("@Tino93",        nil, 1810, {en = "Procerer", de = "Der Procerer"})
MY_MODULE:RegisterTitle("@DschiPeunt",    nil, 1391, {en = "Burning Burrito", de = "Brennender Burrito"})
MY_MODULE:RegisterTitle("@Baumlaus",      nil,   92, {en = "Master of Roleplay", de = "Meister des Rollenspiels"})
MY_MODULE:RegisterTitle("@Vuurhart",      nil,   94, {en = "Vanguard"})
MY_MODULE:RegisterTitle("@Vuurhart",      nil,   93, {en = "Vyrelord"})
MY_MODULE:RegisterTitle("@Woeler",        nil, 1391, {en = "The Almighty Lorkhaj", de = "Der allmächtige Lorkhaj"})
MY_MODULE:RegisterTitle("@Woeler",        nil, 1810, {en = "The Almighty Lorkhaj", de = "Der allmächtige Lorkhaj"})
MY_MODULE:RegisterTitle("@Kruspinator",   nil, 1391, {en = "John Cena"})
MY_MODULE:RegisterTitle("@Kruspinator",   nil, 1810, {en = "John Cena"})
MY_MODULE:RegisterTitle("@Kruspinator",   nil,   92, {en = "John Cena"})
MY_MODULE:RegisterTitle("@GeneralPardon", nil,  702, {en = "Fang of Lorkhaj"})
MY_MODULE:RegisterTitle("@GeneralPardon", nil, 1391, {en = "Fang of Lorkhaj"})
MY_MODULE:RegisterTitle("@DeCarn",        nil, 1391, {en = "Hand of Light"}, {color={"#00FF00", "#FFFF00"}})
MY_MODULE:RegisterTitle("@Agrodin",       nil,   92, {en = "Arkay's Prophet", de = "Arkays Prophet"})
MY_MODULE:RegisterTitle("@Siemenlinko",   nil, 92,   {en = "Lord of The Engine Guardian"}, {color="#CCFF33"})
MY_MODULE:RegisterTitle("@Siemenlinko",   nil, 1810, {en = "Asmael's Daddy"}, {color="#FF0000"})
