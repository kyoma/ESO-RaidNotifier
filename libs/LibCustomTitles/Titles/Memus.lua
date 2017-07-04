local MY_MODULE_NAME = "Memus"
local MY_MODULE_VERSION = 1

local LCC = LibStub('LibCustomTitlesRN')
if not LCC then return end

local MY_MODULE = LCC:RegisterModule(MY_MODULE_NAME, MY_MODULE_VERSION)
if not MY_MODULE then return end


MY_MODULE:RegisterTitle("@memus",        nil, true, {en = "Paid Healer"}, {color={"#22E500", "#BF0000"}})
MY_MODULE:RegisterTitle("@memus",        nil, 92, {en = "The Really Nice Person"})
MY_MODULE:RegisterTitle("@Panadulek",       nil,  true, {en = "The One Who Can Sing"}, {color={"#00FF00", "#FF0000"}})
MY_MODULE:RegisterTitle("@DrugControl",       nil,  true, {en = "Tabard Designer"}, {color="#20F893"})
MY_MODULE:RegisterTitle("@IWM",       nil,  true, {en = "Count Down Master"}, {color="#FF00BD"})
MY_MODULE:RegisterTitle("@Hjelmi",       nil,  true, {en = "Interior Designer"})
MY_MODULE:RegisterTitle("@Asmael",       nil,  true, {en = "#1 Role Player"}, {color={"#DB57EA", "#B5BF00"}})
MY_MODULE:RegisterTitle("@peniku8",       nil,  true, {en = "PlagueCycle Drummer"})
MY_MODULE:RegisterTitle("@Tapalori",       nil,  true, {en = "The Bear"})
MY_MODULE:RegisterTitle("@DrAbodoviC",       nil,  true, {en = "The AFK Master"})
MY_MODULE:RegisterTitle("@VanaEvr",       nil,  true, {en = "Alcast's Sister"}, {color="#FFFFFF"})
MY_MODULE:RegisterTitle("@Tacadrie",       nil,  true, {en = "The Woodpecker"})
MY_MODULE:RegisterTitle("@kilnerdyne",       nil,  true, {en = "LND Master"})
MY_MODULE:RegisterTitle("@Paulington",       nil,  92,  {en = "Community Ambassador", de = "Community-Botschaffe"}, {color="#9000f4"})
MY_MODULE:RegisterTitle("@ONeaaO",        nil, true, { en = "Argonian Overlord"})
MY_MODULE:RegisterTitle("@Deltia84", nil, true, { en = "Engine Guardian Master" })
