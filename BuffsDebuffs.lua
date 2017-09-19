
RaidNotifier = RaidNotifier or {}
RaidNotifier.BuffsDebuffs = {}

local ultimates = {
	46609, -- Barrier Rank IV
	86485, -- Elemental Storm Rank IV
	29844, -- Negate Magic Rank IV
	24046, -- Nova Rank IV
	46529, -- War Horn Rank IV
}
RaidNotifier.BuffsDebuffs.ultimates = ultimates

-- ---------------------------------------------------
-- Sanctum Ophidia -----------------------------------
-- ---------------------------------------------------
local sanctum = {}
--[[
[20:23:55] 2200, 78781 (Taking Aim), 0/0, 0/0/, 0/47711/Bob^Mx
[21:48:11] 2200, 53554 (Celestial Nightmare), 0/0, 0/0/, 0/51142/Bob^Mx     ----- BLACK HOLE MANTI??
--]]

-- Mantikora Spear
sanctum.mantikora_spear = 56324
sanctum.mantikora_quake = 54125

-- Ozara
sanctum.ozara_trapping_bolts = 57839

-- Serpent Poison Phase
sanctum.serpent_poison_teleport = {} -- abilities where the Serpent teleports to do the poison phase (specific ids for the various things after the poison ends)
sanctum.serpent_poison_teleport[53681] = 1 -- followed by lamias
sanctum.serpent_poison_teleport[54690] = 2 -- followed by manti from left pool
sanctum.serpent_poison_teleport[53775] = 3 -- followed by manti from right pool
sanctum.serpent_poison_teleport[53796] = 4 -- followed by shield phase
sanctum.serpent_poison_teleport[53812] = 5 -- final

-- Serpent Magicka Detonation
sanctum.serpent_magicka_deto           = 59036
sanctum.serpent_world_shaper           = 56857
sanctum.serpent_world_shaper_delay     = 5000

-- Trolls Spreading Poison
sanctum.spreading_poison = {} --determine which ones we actually need
sanctum.spreading_poison[52036] = 1  -- \\                                         (when someone spreads it with you?)
sanctum.spreading_poison[58663] = 1  --  >>  Cast 1.9s, Enemy, 28m Range
sanctum.spreading_poison[82591] = 1  -- //
sanctum.spreading_poison[54419] = 2  -- \\                                         (the actual poison)
sanctum.spreading_poison[58669] = 2  --  >> Instant Cast, Enemy, 28m Range, 2.5s 
sanctum.spreading_poison[82597] = 2  -- //
sanctum.spreading_poison[54420] = 3  -- Instant Cast, Area, 3.5m Radius
sanctum.spreading_poison[80794] = 4  -- Cast 1.9s, Cone??, 0m Range??, 28m Radius

sanctum.boulder_toss = 52012

-- Overchargers
sanctum.overcharged    = 58218
sanctum.call_lightning = 79390

-- add ids back to global
RaidNotifier.BuffsDebuffs.sanctum_ophidia = sanctum

-- ---------------------------------------------------
-- Hel Ra  -------------------------------------------
-- ---------------------------------------------------
local hel_ra = {}
--[[
[20:25:54] 2200, 48024 (Cleave), 0/0/, 0/11661/Bob^Mx
[20:26:03] 2200, 48024 (Cleave), 0/0/, 0/11661/Bob^Mx

[20:25:07] 2200, 48267 (Shield Mark), 0/71235/The Warrior^M, 1/59663/Bob^Fx
--]]

hel_ra.jump = {}
hel_ra.jump[56354] = true
hel_ra.jump[10583] = true
hel_ra.jump[33686] = true
hel_ra.jump[56243] = true
hel_ra.jump[33686] = true
hel_ra.jump[33686] = true
hel_ra.jump[33686] = true

hel_ra.yokeda_meteor = 52213
hel_ra.yokeda_impulse = 52207
hel_ra.yokeda_shout = 50585

hel_ra.warrior_stoneform    = 56576
hel_ra.warrior_shieldthrow  = 48267

hel_ra.warrior_channeled_swipes = 47819

hel_ra.destructive_outbreak = 56667

-- add ids back to global
RaidNotifier.BuffsDebuffs.hel_ra = hel_ra



-- ---------------------------------------------------
-- Aetherian Archive  --------------------------------
-- ---------------------------------------------------
local archive = {}

-- Lightning Storm Atronach
archive.stormatro_impendingstorm = 49583 --the large aoe
archive.stormatro_lightningstorm = 47898 --the lightning from the sky

-- Foundation Stone Atronach
archive.stoneatro_boulderstorm = 48240   --induvidual boulders are 49311
archive.stoneatro_bigquake     = 49098

-- Celestial Mage
archive.mage_conjure_axe = {}
archive.mage_conjure_axe[49506] = true
archive.mage_conjure_axe[49508] = true
archive.mage_conjure_axe[49669] = true --might not be needed

archive.mage_conjure_reflection = {} --some of these might be irrelevant
archive.mage_conjure_reflection[49399] = true
archive.mage_conjure_reflection[49400] = true
archive.mage_conjure_reflection[49401] = true
archive.mage_conjure_reflection[49408] = true
archive.mage_conjure_reflection[49409] = true
archive.mage_conjure_reflection[49410] = true
archive.mage_conjure_reflection[49676] = true
archive.mage_conjure_reflection[49678] = true
archive.mage_conjure_reflection[49679] = true
archive.mage_conjure_reflection[49680] = true
archive.mage_conjure_reflection[49681] = true
archive.mage_conjure_reflection[49682] = true
archive.mage_conjure_reflection[49683] = true
archive.mage_conjure_reflection[49685] = true
archive.mage_conjure_reflection[49686] = true
archive.mage_conjure_reflection[49687] = true
archive.mage_conjure_reflection[49688] = true
archive.mage_conjure_reflection[49689] = true
archive.mage_conjure_reflection[56432] = true --seems out of place but has the same (unusual) name

-- Overchargers (same abilities as in Sanctum it seems)
archive.overcharged    = 58218
archive.call_lightning = 79390

-- add ids back to global
RaidNotifier.BuffsDebuffs.archive = archive


-- ---------------------------------------------------
-- Dragonstar Arena  ---------------------------------
-- ---------------------------------------------------
local dragonstar = {}
--[[
[20:51:33] 2200, 53328 (Warming Aura), 0/0, 0/0/, 0/58425/   DSA Stage 2 fire dying???


TODO:
	Arena 2: Warming Aura (see above)
	Arena 6: Lethal Arrow (from Boss)
--]]
dragonstar.general_taking_aim      = 74978
dragonstar.general_crystal_blast   = 54792
dragonstar.arena2_crushing_shock   = 53286 --used by both boss and icemages
dragonstar.arena6_drain_resource   = 54608
dragonstar.arena7_unstable_core    = 52920 --also used by hiath in stage 10
dragonstar.arena8_ice_charge       = 54841
dragonstar.arena8_fire_charge      = 54838

RaidNotifier.BuffsDebuffs.dragonstar = dragonstar



-- ---------------------------------------------------
-- Maelstrom Arena  ----------------------------------
-- ---------------------------------------------------
local maelstrom = {}

maelstrom.stage7_poison = {}
maelstrom.stage7_poison[68871] = true
maelstrom.stage7_poison[68909] = true
maelstrom.stage7_poison[68910] = true
maelstrom.stage7_poison[69855] = true
maelstrom.stage7_poison[69854] = true -- poison explode
maelstrom.stage7_poison[73866] = true -- poison explode

maelstrom.stage9_synergy = 67359

-- add ids back to global
RaidNotifier.BuffsDebuffs.maelstrom = maelstrom



-- ---------------------------------------------------
-- Maw of Lorkhaj  -----------------------------------
-- ---------------------------------------------------
local maw_lorkhaj = {}
--[[
[21:03:50] 2200, 74603 (Spawn In), 0/0/, 0/60332/
[21:04:40] 2200, 57620 (Dark Aegis), 0/0/, 0/60332/

[21:10:35] 2200, 74315 (Transform), 0/0/, 0/57350/
[21:10:35] 2200, 74311 (Transform), 0/0/, 0/43406/

[21:15:18] 2200, 73908 (Lunar Smash), 0/0/, 0/35081/
[21:15:20] 2200, 74331 (Lunar Smash Casting), 0/0/, 0/5037/

[21:15:27] 2200, 73676 (Crushing Void), 0/0/, 0/28336/
[21:15:29] 2200, 73679 (Crushing Void), 0/0/, 0/28336/

[21:15:36] 2200, 74035 (Darkness Falls), 0/0/, 0/5037/

[22:00:08] 2200, 75434 (Whirlwind), 0/0, 0/0/, 0/16874/Bob^Mx
--]]

--Zhaj'hassa the Forgotten
--  Grip of Lorkhaj
maw_lorkhaj.zhaj_gripoflorkhaj = {}
maw_lorkhaj.zhaj_gripoflorkhaj[57513] = true
maw_lorkhaj.zhaj_gripoflorkhaj[57515] = true
maw_lorkhaj.zhaj_gripoflorkhaj[57517] = true
maw_lorkhaj.zhaj_gripoflorkhaj[57469] = true
maw_lorkhaj.zhaj_gripoflorkhaj[57470] = true
maw_lorkhaj.zhaj_gripoflorkhaj[57471] = true
--   Curse
maw_lorkhaj.zhajBoss_curseability  = 57517
maw_lorkhaj.zhajBoss_curseduration = 25
--   Glyphs
maw_lorkhaj.zhajBoss_glyphability  = 57525
maw_lorkhaj.zhajBoss_glyphcooldown = 25
maw_lorkhaj.zhajBoss_knownGlyphs = {}
maw_lorkhaj.zhajBoss_glyphs = {
	{x=0.55496829748154, y=0.29175475239754},
	{x=0.56342494487762, y=0.25405216217041},
	{x=0.60077518224716, y=0.24876673519611},
	{x=0.62297391891479, y=0.26250880956650},
	{x=0.64059197902679, y=0.29774489998817},
	{x=0.62508809566498, y=0.32699084281921},
}

--False Moon Twins, S’Kinrai and Vashai 
--   Holy Aspect
maw_lorkhaj.twinBoss_lunaraspect = {}
maw_lorkhaj.twinBoss_lunaraspect[59472] = true
maw_lorkhaj.twinBoss_lunaraspect[59474] = true
maw_lorkhaj.twinBoss_lunaraspect[59534] = true
maw_lorkhaj.twinBoss_lunaraspect[59535] = true
maw_lorkhaj.twinBoss_lunaraspect[59536] = true
maw_lorkhaj.twinBoss_lunaraspect[59537] = true
maw_lorkhaj.twinBoss_lunaraspect[59538] = true
--  Shadow Aspect
maw_lorkhaj.twinBoss_shadowaspect = {}
maw_lorkhaj.twinBoss_shadowaspect[59523] = true
maw_lorkhaj.twinBoss_shadowaspect[59524] = true
maw_lorkhaj.twinBoss_shadowaspect[59527] = true
maw_lorkhaj.twinBoss_shadowaspect[59528] = true
maw_lorkhaj.twinBoss_shadowaspect[59529] = true
maw_lorkhaj.twinBoss_shadowaspect[59629] = true
maw_lorkhaj.twinBoss_shadowaspect[59465] = true
--  Conversion
maw_lorkhaj.twinBoss_lunarconversion = {}
maw_lorkhaj.twinBoss_lunarconversion[75460] = true
maw_lorkhaj.twinBoss_lunarconversion[75456] = true
maw_lorkhaj.twinBoss_shadowconversion = {}
maw_lorkhaj.twinBoss_shadowconversion[59698] = true
maw_lorkhaj.twinBoss_shadowconversion[59699] = true
--  Removal
maw_lorkhaj.twinBoss_shadowaspectremove = 59639 --shadow
maw_lorkhaj.twinBoss_lunaraspectremove  = 59640 --lunar

--Rakkhat
--  Unstable Void
maw_lorkhaj.rakkhat_unstablevoid = 74488
--  Threshing Wings
maw_lorkhaj.rakkhat_threshingwings = {}
maw_lorkhaj.rakkhat_threshingwings[73741] = true
maw_lorkhaj.rakkhat_threshingwings[74080] = true
maw_lorkhaj.rakkhat_threshingwings[74081] = true
maw_lorkhaj.rakkhat_threshingwings[74083] = true
maw_lorkhaj.rakkhat_threshingwings[74084] = true
maw_lorkhaj.rakkhat_threshingwings[74085] = true
maw_lorkhaj.rakkhat_threshingwings[74086] = true
--  Darkness Falls
maw_lorkhaj.rakkhat_darknessfalls = 74035
-- Dark Barrage
maw_lorkhaj.rakkhat_darkbarrage = {}
maw_lorkhaj.rakkhat_darkbarrage[74384] = true
maw_lorkhaj.rakkhat_darkbarrage[74385] = true
maw_lorkhaj.rakkhat_darkbarrage[74388] = true
maw_lorkhaj.rakkhat_darkbarrage[74390] = true
maw_lorkhaj.rakkhat_darkbarrage[74391] = true
maw_lorkhaj.rakkhat_darkbarrage[74392] = true
maw_lorkhaj.rakkhat_darkbarrage[75965] = true
maw_lorkhaj.rakkhat_darkbarrage[75966] = true
maw_lorkhaj.rakkhat_darkbarrage[75967] = true
maw_lorkhaj.rakkhat_darkbarrage[75968] = true
maw_lorkhaj.rakkhat_darkbarrage[78015] = true
-- Lunar Bastion
maw_lorkhaj.rakkhat_lunarbastion = {}
maw_lorkhaj.rakkhat_lunarbastion[74377] = true
maw_lorkhaj.rakkhat_lunarbastion[74273] = true
maw_lorkhaj.rakkhat_lunarbastion[74347] = true
maw_lorkhaj.rakkhat_lunarbastion[74384] = true
maw_lorkhaj.rakkhat_lunarbastion[74352] = true
maw_lorkhaj.rakkhat_lunarbastion[74357] = true
maw_lorkhaj.rakkhat_lunarbastion[74362] = true
maw_lorkhaj.rakkhat_lunarbastion[74367] = true

--Mobs
-- Eclipse Field (Sun-Eater)
maw_lorkhaj.suneater_eclipse = 73700

--  Armor Shattered
maw_lorkhaj.shattered = {}
maw_lorkhaj.shattered[73250] = true
maw_lorkhaj.shattered[75071] = true

--  Marked for Death (Panthers)
maw_lorkhaj.markedfordeath = {}
maw_lorkhaj.markedfordeath[55104] = true
maw_lorkhaj.markedfordeath[55105] = true
maw_lorkhaj.markedfordeath[59892] = true
maw_lorkhaj.markedfordeath[55174] = true
maw_lorkhaj.markedfordeath[73223] = true
maw_lorkhaj.markedfordeath[55099] = true
maw_lorkhaj.markedfordeath[55181] = true
maw_lorkhaj.markedfordeath[55182] = true
maw_lorkhaj.markedfordeath[58459] = true
--  Colossal Mark (Big Panthers)
maw_lorkhaj.markedfordeath[75672] = true
maw_lorkhaj.markedfordeath[75674] = true

maw_lorkhaj.rakkhat_shattered = {}
maw_lorkhaj.rakkhat_shattered[74671] = true
maw_lorkhaj.rakkhat_shattered[74672] = true
maw_lorkhaj.rakkhat_shattered[76030] = true
maw_lorkhaj.rakkhat_shattered[76031] = true

-- add ids back to global
RaidNotifier.BuffsDebuffs.maw_lorkhaj = maw_lorkhaj



-- ---------------------------------------------------
-- Halls of Fabrication ------------------------------
-- ---------------------------------------------------
local halls_fab = {}

-- Hunter Pair
halls_fab.venom_injection              = 95230
halls_fab.hunters_spawn_sphere         = 90414
-- Pinnacle Factotum (2nd boss)
halls_fab.pinnacleBoss_fluxburst       = 90755 -- the streak-like attack
halls_fab.pinnacleBoss_conduit_spawn   = 91781 -- sadly not targeted on somebody
halls_fab.pinnacleBoss_conduit_drain   = 91792 
halls_fab.pinnacleBoss_scalded_debuff  = 90916

-- Refabrication Committee (4th bosses)
--  Reducer
halls_fab.committee_overheat             = 94747
halls_fab.committee_overheat_aura        = 94736
--  Reactor
halls_fab.committee_overload             = 94759
halls_fab.committee_overload_aura        = 94757
--  Reclaimer
halls_fab.committee_overcharge_aura      = 90715
--  Ruined Factotum spawns
halls_fab.committee_fabricant_spawn      = 90499
halls_fab.committee_fabricant_spawn_old  = 92835 
halls_fab.committee_reclaim_achieve      = 94458 -- achievement "Planned Obsolescence" has failed if this shows up
halls_fab.committee_catastrophic_discharge = {}
halls_fab.committee_catastrophic_discharge[90581] = true
halls_fab.committee_catastrophic_discharge[90632] = true -- the actual channel as it is exploding next to someone (do we want the rest as well?)
halls_fab.committee_catastrophic_discharge[91358] = true
halls_fab.committee_catastrophic_discharge[91359] = true
halls_fab.committee_catastrophic_discharge[94764] = true
halls_fab.committee_catastrophic_discharge[94765] = true
halls_fab.committee_catastrophic_discharge[94767] = true
halls_fab.committee_catastrophic_discharge[94939] = true
halls_fab.committee_catastrophic_discharge[94941] = true
halls_fab.committee_catastrophic_discharge[94942] = true
halls_fab.committee_catastrophic_discharge[94944] = true
halls_fab.committee_catastrophic_discharge[94949] = true
halls_fab.committee_catastrophic_discharge[94950] = true

-- Assembly General
halls_fab.assembly_titanic_smash = 90428 -- only thing that needs to be blocked?

-- Other
halls_fab.conduit_strike = {}
halls_fab.conduit_strike[88036]   = true
halls_fab.conduit_strike[94613]   = true  -- from Committee trio
halls_fab.power_leech             = 88041 -- the actual stun you need to break free from
halls_fab.taking_aim              = 91736
halls_fab.draining_ballista       = 91077

RaidNotifier.BuffsDebuffs.halls_fab = halls_fab



-- ---------------------------------------------------
-- BuffFood ------------------------------------------
-- ---------------------------------------------------
local buffFood = {}
buffFood[17407] = true -- max life
buffFood[17565] = true -- max magicka
buffFood[17567] = true -- max stamina
buffFood[17569] = true -- max life and magicka
buffFood[17577] = true -- max life and stamina
buffFood[47049] = true -- max life
buffFood[47051] = true -- max stamina
buffFood[61257] = true -- max life and magicka
buffFood[61259] = true -- max life
buffFood[61261] = true -- max stamina
buffFood[61294] = true -- max life and stamina
buffFood[66551] = true -- max life
buffFood[66124] = true -- max life
buffFood[66125] = true -- max life
buffFood[66127] = true -- max magicka
buffFood[66128] = true -- max magicka
buffFood[66129] = true -- max stamina
buffFood[66130] = true -- max stamina
buffFood[66131] = true -- lifereg
buffFood[66132] = true -- lifereg
buffFood[66136] = true -- magickareg
buffFood[66137] = true -- magickareg
buffFood[66140] = true -- staminareg
buffFood[66141] = true -- staminareg
buffFood[66576] = true -- max stamina
buffFood[68411] = true -- max all
buffFood[68412] = true -- max stamina
buffFood[68413] = true -- max magicka
buffFood[72816] = true -- max life and magicka
buffFood[72824] = true -- max life and reg
buffFood[72956] = true -- max life and stamina
buffFood[72957] = true -- max life
buffFood[72959] = true -- max life and magicka
buffFood[72960] = true -- max life
buffFood[72961] = true -- max stamina and magicka
buffFood[72962] = true -- max life
buffFood[61255] = true
buffFood[66568] = true
buffFood[72819] = true
buffFood[17573] = true
buffFood[47050] = true
buffFood[61260] = true
buffFood[17581] = true
buffFood[61218] = true
buffFood[17614] = true
buffFood[61350] = true
buffFood[84678] = true
buffFood[84681] = true
buffFood[84709] = true
buffFood[84725] = true
buffFood[85484] = true
buffFood[84700] = true
buffFood[84704] = true
buffFood[84720] = true
buffFood[84731] = true
buffFood[84735] = true
buffFood[89955] = true
buffFood[89957] = true
buffFood[89971] = true


-- add ids back to global
RaidNotifier.BuffsDebuffs.buffFood = buffFood
