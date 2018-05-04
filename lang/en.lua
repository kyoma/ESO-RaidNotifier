local L = {}

L.Description                            = "Displays on-screen notifications on different events during trials."

--------------------------------
----     General Stuff      ----
--------------------------------
L.Settings_General_Header                           = "General"
-- Settings 
L.Settings_General_Bufffood_Reminder                = "Buff Food Reminder"
L.Settings_General_Bufffood_Reminder_TT             = "Alerts you when you have no buff food during trials or when it is about to expire (see below)"
L.Settings_General_Bufffood_Reminder_Interval       = "Reminder Interval"
L.Settings_General_Bufffood_Reminder_Interval_TT    = "Interval for the buff food reminder, in seconds, starting at 10 minutes remaining."
L.Settings_General_Vanity_Pets                      = "Turn off vanity pets during trials"
L.Settings_General_Vanity_Pets_TT                   = "Will turn off your vanity pets when you start a trial. Once you finish or exit a trial your pet will be enabled again."
L.Settings_General_No_Assistants                    = "Turn off assistants when combat starts"
L.Settings_General_No_Assistants_TT                 = "Only applies during trials and does NOT prevent them from being summoned."
L.Settings_General_Center_Screen_Announce           = "Announcement Type"
L.Settings_General_Center_Screen_Announce_TT        = "The type of announcement to use."
L.Settings_General_UseDisplayName                   = "Use Dislay Name"
L.Settings_General_UseDisplayName_TT                = "Use a player's display name in the notifications instead of his character name."
L.Settings_General_Unlock_Status_Icon               = "Unlock Status Icon"
L.Settings_General_Unlock_Status_Icon_TT            = "When enabled it will show status icon on the screen that can be moved."
L.Settings_General_Default_Sound                    = "Default Sound"
L.Settings_General_Default_Sound_TT                 = "The default sound to use for a notification."
-- Choices
L.Settings_General_Choices_Off                      = "Off"
L.Settings_General_Choices_Full                     = "Full"
L.Settings_General_Choices_Normal                   = "Normal"
L.Settings_General_Choices_Minimal                  = "Minimal"
L.Settings_General_Choices_Self                     = "Self"
L.Settings_General_Choices_Near                     = "Near"
L.Settings_General_Choices_All                      = "All"
L.Settings_General_Choices_Always                   = "Always"
L.Settings_General_Choices_Other                    = "Other"
L.Settings_General_Choices_Inverted                 = "Inverted"
L.Settings_General_Choices_Small                    = "Small"
L.Settings_General_Choices_Large                    = "Large"
L.Settings_General_Choices_Major                    = "Major"
L.Settings_General_Choices_Custom                   = "Custom"
-- Alerts
L.Alerts_General_No_Bufffood                        = "You have no bufffood!"
L.Alerts_General_Bufffood_Minutes                   = "Your '<<1>>' bufffood runs out in |cbd0000<<2>>|r minutes!"
-- Bindings
L.Binding_ToggleUltimateExchange                    = "Toggle Ultimate"


--------------------------------
----    Ultimate Exchange   ----
--------------------------------
L.Settings_Ultimate_Header                           = "Ultimate Exchange (beta)"
L.Settings_Ultimate_Description                      = "This feature allows you to send your ultimate to your teammates so they can see how close you are to casting it. It uses your cost based on whatever cost reduction you might have from sets or passives."
-- Settings 
L.Settings_Ultimate_Enabled                          = "Enabled"
L.Settings_Ultimate_Enabled_TT                       = "Enable the sharing and receiving of ultimate values. It is always disabled outside of trials."
L.Settings_Ultimate_Hidden                           = "Hidden"
L.Settings_Ultimate_Hidden_TT                        = "Hides the ultimate window but does not disable the feature itself."
L.Settings_Ultimate_UseColor                         = "Use Color"
L.Settings_Ultimate_UseColor_TT                      = "Gives the ultimate of someone a color based on the thresholds at 80 and 100 percent."
L.Settings_Ultimate_UseDisplayName                   = "Display User Name"
L.Settings_Ultimate_UseDisplayName_TT                = "Display the user name in the ultimate window instead of character name."
L.Settings_Ultimate_ShowHealers                      = "Show Healer"
L.Settings_Ultimate_ShowHealers_TT                   = "Show ultimate for group members with the Healer role."
L.Settings_Ultimate_ShowTanks                        = "Show Tank"
L.Settings_Ultimate_ShowTanks_TT                     = "Show ultimate for group members with the Tank role."
L.Settings_Ultimate_ShowDps                          = "Show Damage"
L.Settings_Ultimate_ShowDps_TT                       = "Show ultimate for group members with the Damage role."
L.Settings_Ultimate_TargetUlti                       = "Ultimate Ability"
L.Settings_Ultimate_TargetUlti_TT                    = "What ultimate ability to use for the percentage value seen by others."
L.Settings_Ultimate_OverrideCost                     = "Override Cost"
L.Settings_Ultimate_OverrideCost_TT                  = "Use this value when sending your ultimate cost to others. Setting it to 0 will disable the override."


--------------------------------
----        Profiles        ----
--------------------------------
L.Settings_Profile_Header                            = "Profiles"
L.Settings_Profile_Description                       = "Setting profiles can be managed here including the option to enable an account wide profile that will apply the same settings to ALL character\"s on this account. Due to the permanency of these options, management must first be enabled using the checkbox at the bottom of the panel."
L.Settings_Profile_UseGlobal                         = "Use Account Wide Profile"
L.Settings_Profile_UseGlobal_Warning                 = "Switching between local and global profiles will reload the interface."
L.Settings_Profile_Copy                              = "Select A Profile To Copy"
L.Settings_Profile_Copy_TT                           = "Select a profile to copy its settings to the currently active profile. The active profile will be for either the logged in character or the account wide profile if enabled. The existing profile settings will be permanently overwritten.\n\nThis cannot be undone!"
L.Settings_Profile_CopyButton                        = "Copy Profile"
L.Settings_Profile_CopyButton_Warning                = "Copying a profile will reload the interface."
L.Settings_Profile_CopyCannotCopy                    = "Unable to copy selected profile. Please try again or select another profile."
L.Settings_Profile_Delete                            = "Select A Profile To Delete"
L.Settings_Profile_Delete_TT                         = "Select a profile to delete its settings from the database. If that character is logged in later, and you are not using the account wide profile, new default settings will be created.\n\nDeleting a profile is permanent!"
L.Settings_Profile_DeleteButton                      = "Delete Profile"
L.Settings_Profile_Guard                             = "Enable Profile Management"


--------------------------------
----       Countdowns       ----
--------------------------------
L.Settings_Countdown_Header                          = "Countdowns"
L.Settings_Countdown_Description                     = "Change the looks and behaviour of our countdowns."
L.Settings_Countdown_TimerScale                      = "Timer Scale"
L.Settings_Countdown_TimerScale_TT                   = "The scale of the timer display"
L.Settings_Countdown_TextScale                       = "Text Scale"
L.Settings_Countdown_TextScale_TT                    = "The scale of the text display"
L.Settings_Countdown_UseColors                       = "Use Colors"
L.Settings_Countdown_UseColors_TT                    = "When enabled it will use yellow/orange/red colors for the countdown as it reaches zero"


--------------------------------
----          Trials        ----
--------------------------------
L.Settings_Trials_Header                            = "Trials"
L.Settings_Trials_Description                       = "Here you can configure the notifications for each trial. They all have a configurable sound and many of them support not only you but also your teammates."


--------------------------------
----     Hel Ra Citadel     ----
--------------------------------
L.Settings_HelRa_Header                             = "Hel Ra Citadel"
-- Settings
L.Settings_HelRa_Yokeda_Meteor                      = "Yokeda: Meteor"
L.Settings_HelRa_Yokeda_Meteor_TT                   = "Alerts you when the yokeda is about to attack with meteor."
L.Settings_HelRa_Warrior_StoneForm                  = "Warrior: Stone Form"
L.Settings_HelRa_Warrior_StoneForm_TT               = "Alerts you when you and/or others are about to be turned into stone by the Warrior."
L.Settings_HelRa_Warrior_ShieldThrow                = "Warrior: Shield Throw"
L.Settings_HelRa_Warrior_ShieldThrow_TT             = "Alerts you when the warrior is about to throw his shield."
--Alerts
L.Alerts_HelRa_Yokeda_Meteor                        = "Incoming |cFF0000Meteor|r on you. Block!"
L.Alerts_HelRa_Yokeda_Meteor_Other                  = "Incoming |cFF0000Meteor|r on |c595959<<!aC:1>>|r"
L.Alerts_HelRa_Warrior_StoneForm                    = "Incoming |c595959Stone Form|r on you. Don't use synergies!"
L.Alerts_HelRa_Warrior_StoneForm_Other              = "Incoming |c595959Stone Form|r on |cFF0000<<!aC:1>>|r"
L.Alerts_HelRa_Warrior_ShieldThrow                  = "Incoming |cFF0000Shield Throw|r. "


--------------------------------
----   Aetherian Archives   ----
--------------------------------
L.Settings_Archive_Header                           = "Aetherian Archives"
-- Settings
L.Settings_Archive_StormAtro_ImpendingStorm         = "Storm Atro: Impending Storm"
L.Settings_Archive_StormAtro_ImpendingStorm_TT      = "Alerts you when the Storm Atronach is about to do his large lightning AoE."
L.Settings_Archive_StormAtro_LightningStorm         = "Storm Atro: Lightning Storm"
L.Settings_Archive_StormAtro_LightningStorm_TT      = "Alerts you when the Storm Atronach is calling lightning from the sky that you need to shelter from."
L.Settings_Archive_StoneAtro_BoulderStorm           = "Stone Atro: Boulder Storm"
L.Settings_Archive_StoneAtro_BoulderStorm_TT        = "Alerts you when the Stone Atronach starts tossing multiple rocks at people."
L.Settings_Archive_StoneAtro_BigQuake               = "Stone Atro: Big Quake"
L.Settings_Archive_StoneAtro_BigQuake_TT            = "Alerts you when the Stone Atronach starts stomping on the ground."
L.Settings_Archive_Overcharge                       = "Mobs: Overcharge"
L.Settings_Archive_Overcharge_TT                    = "Alerts you when an Overcharger targets you with his Overcharge ability."
L.Settings_Archive_Call_Lightning                   = "Mobs: Call Lightning"
L.Settings_Archive_Call_Lightning_TT                = "Alerts you when an Overcharger targets you with his Call Lightning ability."
-- Alerts 
L.Alerts_Archive_StormAtro_ImpendingStorm           = "Incoming |cFF0000Impending Storm|r!"
L.Alerts_Archive_StormAtro_LightningStorm           = "Incoming |cfef92eLightning Storm|r! Go into the light!"
L.Alerts_Archive_StoneAtro_BoulderStorm             = "Incoming |cFF0000Boulder Storm|r! Block to avoid knockback!"
L.Alerts_Archive_StoneAtro_BigQuake                 = "Incoming |cFF0000Big Quake|r!"
L.Alerts_Archive_Overcharge                         = "Incoming |c46edffOvercharge|r on you."
L.Alerts_Archive_Overcharge_Other                   = "Incoming |c46edffOvercharge|r on |cFF0000<<!aC:1>>|r."
L.Alerts_Archive_Call_Lightning                     = "Incoming |c46edffCall Lightning|r on you. Keep moving!"
L.Alerts_Archive_Call_Lightning_Other               = "Incoming |c46edffCall Lightning|r on |cFF0000<<!aC:1>>|r."


--------------------------------
----    Sanctum Ophidia     ----
--------------------------------
L.Settings_Sanctum_Header                           = "Sanctum Ophidia"
-- Settings
L.Settings_Sanctum_Magicka_Detonation               = "Serpent: Magicka Detonation"
L.Settings_Sanctum_Magicka_Detonation_TT            = "Alerts when you got the debuff of the magicka detonation during the serpent fight."
L.Settings_Sanctum_Serpent_Poison                   = "Serpent: Poison Phase"
L.Settings_Sanctum_Serpent_Poison_TT                = "Alerts for the poison phase during the Serpent fight."
L.Settings_Sanctum_Serpent_World_Shaper             = "Serpent: World Shaper (Hard Mode)"
L.Settings_Sanctum_Serpent_World_Shaper_TT          = "Alerts you when the Serpent starts his World Shaper attack, counting down until it is unleashed."
L.Settings_Sanctum_Mantikora_Spear                  = "Mantikora: Spear"
L.Settings_Sanctum_Mantikora_Spear_TT               = "Alerts you when you will get the Mantikora Spear."
L.Settings_Sanctum_Mantikora_Quake                  = "Mantikora: Quake"
L.Settings_Sanctum_Mantikora_Quake_TT               = "Alerts when you get the three set of quakes or runes on the Mantikora."
L.Settings_Sanctum_Troll_Boulder                    = "Mobs: Troll Boulder Toss"
L.Settings_Sanctum_Troll_Boulder_TT                 = "Alerts you when a troll prepares to throw a boulder at you."
L.Settings_Sanctum_Troll_Poison                     = "Mobs: Troll Poison"
L.Settings_Sanctum_Troll_Poison_TT                  = "Alerts you when a troll prepares to throw the spreading poison at you."
L.Settings_Sanctum_Overcharge                       = "Mobs: Overcharge"
L.Settings_Sanctum_Overcharge_TT                    = "Alerts you when an Overcharger targets you with his Overcharge ability."
L.Settings_Sanctum_Call_Lightning                   = "Mobs: Call Lightning"
L.Settings_Sanctum_Call_Lightning_TT                = "Alerts you when an Overcharger targets you with his Call Lightning ability."
-- Alerts
L.Alerts_Sanctum_Serpent_Poison0                    = "Incoming |c39942ePoison Phase|r! Stack together!"
L.Alerts_Sanctum_Serpent_Poison1                    = "Incoming |c39942ePoison Phase|r! Followed by |ccc0000Lamias|r."
L.Alerts_Sanctum_Serpent_Poison2                    = "Incoming |c39942ePoison Phase|r! Followed by |c009933Mantikora|r." --left
L.Alerts_Sanctum_Serpent_Poison3                    = "Incoming |c39942ePoison Phase|r! Followed by |c009933Mantikora|r." --right
L.Alerts_Sanctum_Serpent_Poison4                    = "Incoming |c39942ePoison Phase|r! Followed by |cff33ccShields|r."
L.Alerts_Sanctum_Serpent_Poison5                    = "Final |c39942ePoison Phase|r!"
L.Alerts_Sanctum_Serpent_World_Shaper               = "|c00c832World Shaper|r in"
L.Alerts_Sanctum_Magicka_Detonation                 = "|c234afaMagicka Detonation|r! Burn all your Magicka!"
L.Alerts_Sanctum_Mantikora_Spear                    = "Mantikora |ccde846Spear|r on you! Move out!"
L.Alerts_Sanctum_Mantikora_Spear_Other              = "Mantikora |ccde846Spear|r on <<!aC:1>>! Move out!"
L.Alerts_Sanctum_Mantikora_Quake                    = "Mantikora |ccde846Quake|r under you! Move away!"
L.Alerts_Sanctum_Troll_Poison                       = "Incoming |c66ff33Troll Poison|r. Don't spread it!"
L.Alerts_Sanctum_Troll_Poison_Other                 = "Incoming |c66ff33Troll Poison|r on |cFF0000<<!aC:1>>|r."
L.Alerts_Sanctum_Troll_Boulder                      = "Incoming |c595959Boulder Toss|r. Avoid it!"
L.Alerts_Sanctum_Troll_Boulder_Other                = "Incoming |c595959Boulder Toss|r on |cFF0000<<!aC:1>>|r."
L.Alerts_Sanctum_Overcharge                         = "Incoming |c46edffOvercharge|r on you."
L.Alerts_Sanctum_Overcharge_Other                   = "Incoming |c46edffOvercharge|r on |cFF0000<<!aC:1>>|r."
L.Alerts_Sanctum_Call_Lightning                     = "Incoming |c46edffCall Lightning|r on you. Keep moving!"
L.Alerts_Sanctum_Call_Lightning_Other               = "Incoming |c46edffCall Lightning|r on |cFF0000<<!aC:1>>|r."


--------------------------------
----    Maelstrom Arena     ----
--------------------------------
L.Settings_Maelstrom_Header                         = "Maelstrom Arena"
-- Settings
L.Settings_Maelstrom_Stage7_Poison                  = "Stage 7: Poison"
L.Settings_Maelstrom_Stage7_Poison_TT               = "Alerts you when you got poisoned in Stage 7 (Vault of Umbrage)."
L.Settings_Maelstrom_Stage9_Synergy                 = "Stage 9: Spectral Explosion (Synergy)"
L.Settings_Maelstrom_Stage9_Synergy_TT              = "Alerts you when you got the Synergy in Stage 9 (Theater of Despair) after you picked up 3 (golden) Ghosts."
-- Alerts
L.Alerts_Maelstrom_Stage7_Poison                    = "|c39942ePoisoned|r! Use one of the two areas to purge!"
L.Alerts_Maelstrom_Stage9_Synergy                   = "|c23afe7Spectral Explosion|r ready! Use the synergy!"


--------------------------------
----     Maw of Lorkhaj     ----
--------------------------------
L.Settings_MawLorkhaj_Header                        = "Maw of Lorkhaj"
-- Settings
L.Settings_MawLorkhaj_Zhaj_GripOfLorkhaj            = "Zhaj'hassa: Grip of Lorkhaj"
L.Settings_MawLorkhaj_Zhaj_GripOfLorkhaj_TT         = "Get a warning when the Grip of Lorkhaj debuff starts affecting you."
L.Settings_MawLorkhaj_Zhaj_Glyphs                   = "Zhaj'hassa: Cleansing Platforms (beta)"
L.Settings_MawLorkhaj_Zhaj_Glyphs_TT                = "Displays a window with all of the cleansing platforms with their status and time until they respawn."
L.Settings_MawLorkhaj_Zhaj_Glyphs_Invert            = "       - Inverted View"
L.Settings_MawLorkhaj_Zhaj_Glyphs_Invert_TT         = "Invert cleansing platforms."
L.Settings_MawLorkhaj_Twin_Aspects                  = "False Moon Twins: Aspects"
L.Settings_MawLorkhaj_Twin_Aspects_TT               = "Alerts when you get the Lunar or Shadow aspect at the False Moon Twins.\n\n    Full alerts you when you get an aspect, when you are starting to convert to an aspect and when the conversion is complete.\n    Normal alerts you when you get an aspect and when you are converting.\n    Minimal only alerts you when you are converting."
L.Settings_MawLorkhaj_Twin_Aspects_Status           = "       - Show Status"
L.Settings_MawLorkhaj_Twin_Aspects_Status_TT        = "Shows your current aspect in the status display during the boss fight."
L.Settings_MawLorkhaj_Rakkhat_Unstable_Void         = "Rakkhat: Unstable Void"
L.Settings_MawLorkhaj_Rakkhat_Unstable_Void_TT      = "Alerts when you have the unstable void effect at Rakkhat."
L.Settings_MawLorkhaj_Rakkhat_Unstable_Void_Countdown = "       - Countdown"
L.Settings_MawLorkhaj_Rakkhat_Unstable_Void_Countdown_TT = "When enabled it will show countdown instead of simple notification for unstable void."
L.Settings_MawLorkhaj_Rakkhat_ThreshingWings        = "Rakkhat: Threshing Wings"
L.Settings_MawLorkhaj_Rakkhat_ThreshingWings_TT     = "Alerts when Rakkhat uses his Threshing Wings ability that knocks you back."
L.Settings_MawLorkhaj_Rakkhat_DarknessFalls         = "Rakkhat: Darkness Falls"
L.Settings_MawLorkhaj_Rakkhat_DarknessFalls_TT      = "Alerts when Rakkhat uses his Darkness Falls ability where the ceiling comes crashing down."
L.Settings_MawLorkhaj_Rakkhat_DarkBarrage           = "Rakkhat: Dark Barrage"
L.Settings_MawLorkhaj_Rakkhat_DarkBarrage_TT        = "Alerts when Rakkhat uses his Dark Barrage channel ability on the tank."
L.Settings_MawLorkhaj_Rakkhat_LunarBastion1         = "Rakkhat: Lunar Bastion Gained"
L.Settings_MawLorkhaj_Rakkhat_LunarBastion1_TT      = "Shows when a player gains the blessing from the glowing platform."
L.Settings_MawLorkhaj_Rakkhat_LunarBastion2         = "Rakkhat: Lunar Bastion Lost"
L.Settings_MawLorkhaj_Rakkhat_LunarBastion2_TT      = "Shows when a player loses the blessing from the glowing platform."
L.Settings_MawLorkhaj_ShatteringStrike              = "Mobs: Shattering Strike"
L.Settings_MawLorkhaj_ShatteringStrike_TT           = "Get a warning when Dro-m'Athra Savage is about to cast shattering strike attack."
L.Settings_MawLorkhaj_Shattered                     = "Mobs: Armor Shattered"
L.Settings_MawLorkhaj_Shattered_TT                  = "Get a warning when your armor is shattered."
L.Settings_MawLorkhaj_MarkedForDeath                = "Mobs: Marked for death (Panthers)"
L.Settings_MawLorkhaj_MarkedForDeath_TT             = "Get a warning if you are marked for death by the panthers of a Dro-m'Athra Dreadstalker"
L.Settings_MawLorkhaj_Suneater_Eclipse              = "Mobs: Sun-Eater Eclipse Field (negate)"
L.Settings_MawLorkhaj_Suneater_Eclipse_TT           = "Get a warning if the Eclipse Field targets you."
-- Alerts
L.Alerts_MawLorkhaj_Zhaj_GripOfLorkhaj              = "Warning! |c000055Grip of Lorkhaj!|r Cleanse now!"
L.Alerts_MawLorkhaj_Lunar_Aspect                    = "Received |cFEFF7FLunar|r Aspect!"
L.Alerts_MawLorkhaj_Shadow_Aspect                   = "Received |c000055Shadow|r Aspect!"
L.Alerts_MawLorkhaj_Lunar_Conversion                = "Converting to |cFEFF7FLunar|r Aspect!"
L.Alerts_MawLorkhaj_Shadow_Conversion               = "Converting to |c000055Shadow|r Aspect!"
L.Alerts_MawLorkhaj_Rakkhat_Unstable_Void           = "Warning! |c000055Unstable Void|r below you"
L.Alerts_MawLorkhaj_Rakkhat_Unstable_Void_Other     = "Warning! |c000055Unstable Void|r below |cFF0000<<!aC:1>>|r"
L.Alerts_MawLorkhaj_Rakkhat_ThreshingWings          = "Incoming |cFF0000Threshing Wings|r! Block!"
L.Alerts_MawLorkhaj_Rakkhat_DarknessFalls           = "Incoming |cFF0000Darkness Falls|r!"
L.Alerts_MawLorkhaj_Rakkhat_DarkBarrage             = "Incoming |cFF0000Dark Barrage|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion1           = "You gained |cFEFF7FLunar Bastion|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion1_Other     = "|cFF0000<<!aC:1>>|r gained |cFEFF7FLunar Bastion|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion2           = "You lost |cFEFF7FLunar Bastion|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion2_Other     = "|cFF0000<<!aC:1>>|r lost |cFEFF7FLunar Bastion|r"
L.Alerts_MawLorkhaj_Suneater_Eclipse                = "Incoming |cFF0000Eclipse Field|r on you."
L.Alerts_MawLorkhaj_Suneater_Eclipse_Other          = "Incoming |cFF0000Eclipse Field|r on |cFF0000<<!aC:1>>|r!"
L.Alerts_MawLorkhaj_ShatteringStrike                = "Incoming |c000055Shattering Strike|r on you."
L.Alerts_MawLorkhaj_ShatteringStrike_Other          = "Incoming |c000055Shattering Strike|r on |cFF0000<<!aC:1>>|r!"
L.Alerts_MawLorkhaj_Shattered                       = "Your |c595959Armor|r has been |cff0000Shattered|r."
L.Alerts_MawLorkhaj_MarkedForDeath                  = "Warning! |c000055Panthers|r are chasing you!"


--------------------------------
----    Dragonstar Arena    ----
--------------------------------
L.Settings_Dragonstar_Header                        = "Dragonstar Arena"
-- Settings
L.Settings_Dragonstar_General_Taking_Aim            = "General: Taking Aim"
L.Settings_Dragonstar_General_Taking_Aim_TT         = "Alerts you when you are being targeted by the Taking Aim ability."
L.Settings_Dragonstar_General_Crystal_Blast         = "General: Crystal Blast"
L.Settings_Dragonstar_General_Crystal_Blast_TT      = "Alerts you when you are being targeted by the Crystal Blast ability."
L.Settings_Dragonstar_Arena2_Crushing_Shock         = "Arena 2: Crushing Shock"
L.Settings_Dragonstar_Arena2_Crushing_Shock_TT      = "Alerts you when you are being targeted by the Crushing Shock ability in the Ice arena."
L.Settings_Dragonstar_Arena6_Drain_Resource         = "Arena 6: Drain Resource"
L.Settings_Dragonstar_Arena6_Drain_Resource_TT      = "Alerts you when you are being targeted by the Drain Resource poison arrow in the Bosmer arena."
L.Settings_Dragonstar_Arena7_Unstable_Core          = "Arena 7: Unstable Core (Eclipse)"
L.Settings_Dragonstar_Arena7_Unstable_Core_TT       = "Alerts you when an Unstable Core (Eclipse) has been placed on you by the Templar boss in the Sacrifice arena."
L.Settings_Dragonstar_Arena8_Ice_Charge             = "Arena 8: Ice Charge"
L.Settings_Dragonstar_Arena8_Ice_Charge_TT          = "Alerts you when an Ice Centurion is about to launch his ice attack."
L.Settings_Dragonstar_Arena8_Fire_Charge            = "Arena 8: Fire Charge"
L.Settings_Dragonstar_Arena8_Fire_Charge_TT         = "Alerts you when an Fire Centurion is about to launch his fire attack."
-- Alerts
L.Alerts_Dragonstar_General_Taking_Aim              = "|cFF6600Taking Aim|r targeted at you!"
L.Alerts_Dragonstar_General_Crystal_Blast           = "|c990099Crystal Blast|r targeted at you!"
L.Alerts_Dragonstar_Arena2_Crushing_Shock           = "Incoming |c3366EECrushing Shock|r! Block!"
L.Alerts_Dragonstar_Arena6_Drain_Resource           = "Incoming |c00CC00Drain Resource|r! Dodge!"
L.Alerts_Dragonstar_Arena6_Drain_Resource_Other     = "Incoming |c00CC00Drain Resource|r on |cFF0000<<!aC:1>>|r."
L.Alerts_Dragonstar_Arena7_Unstable_Core            = "You have |cDDDD33Unstable Core|r! Break free!"
L.Alerts_Dragonstar_Arena8_Ice_Charge               = "Incoming |c6699FFIce Charge|r on you! Interrupt or dodge!"
L.Alerts_Dragonstar_Arena8_Ice_Charge_Other         = "|c6699FFIce Charge|r is being cast on |cFF0000<<!aC:1>>|r. Interrupt!"
L.Alerts_Dragonstar_Arena8_Fire_Charge              = "Incoming |cFF3113Fire Charge|r on you! Interrupt or dodge!"
L.Alerts_Dragonstar_Arena8_Fire_Charge_Other        = "|c6699FFire Charge|r is being cast on |cFF0000<<!aC:1>>|r. Interrupt!"



--------------------------------
---- Halls Of Fabrication   ----
--------------------------------
L.Settings_HallsFab_Header                          = "Halls Of Fabrication"
-- Settings
L.Settings_HallsFab_Taking_Aim                      = "General: Taking Aim"
L.Settings_HallsFab_Taking_Aim_TT                   = "Alerts you when you are being targeted by the Taking Aim ability."
L.Settings_HallsFab_Taking_Aim_Dynamic              = "       - Countdown"
L.Settings_HallsFab_Taking_Aim_Dynamic_TT           = "When enabled it will show countdown instead of simple notification before Taking Aim attack."
L.Settings_HallsFab_Taking_Aim_Duration             = "       - Countdown Duration"
L.Settings_HallsFab_Taking_Aim_Duration_TT          = "The duration of the countdown in milliseconds."
L.Settings_HallsFab_Draining_Ballista               = "General: Draining Ballista"
L.Settings_HallsFab_Draining_Ballista_TT            = "Alerts you when Sphere need to be bashed."
L.Settings_HallsFab_Conduit_Strike                  = "General: Conduit Strike"
L.Settings_HallsFab_Conduit_Strike_TT               = "Alerts you when Conduit Strike is coming."
L.Settings_HallsFab_Power_Leech                     = "General: Draining Shock"
L.Settings_HallsFab_Power_Leech_TT                  = "Alerts you when you are stunned by Conduit Strike and need to break free."
L.Settings_HallsFab_Venom_Injection                 = "Hunters: Venom Injection"
L.Settings_HallsFab_Venom_Injection_TT              = "Shows a status display for when you are afflicted by Venom Injection during the Hunter bosses."
L.Settings_HallsFab_Conduit_Spawn                   = "Pinnacle: Conduit Spawning"
L.Settings_HallsFab_Conduit_Spawn_TT                = "Alerts you when a conduit is about to spawn at Factotum Pinnacle boss."
L.Settings_HallsFab_Conduit_Drain                   = "Pinnacle: Conduit Draining"
L.Settings_HallsFab_Conduit_Drain_TT                = "Alerts you when a conduit is draining you at Factotum Pinnacle boss."
L.Settings_HallsFab_Scalded_Debuff                  = "Pinnacle: Scalded Debuff"
L.Settings_HallsFab_Scalded_Debuff_TT               = "Displays a small status icon showing the time until it disappears and how big its healing debuff is."
L.Settings_HallsFab_Overcharge_Aura                 = "Committee: Overcharging Aura"
L.Settings_HallsFab_Overcharge_Aura_TT              = "Alerts you when reclaimer start overcharging aura."
L.Settings_HallsFab_Overpower_Auras                 = "Committee: Overpowering Auras"
L.Settings_HallsFab_Overpower_Auras_TT              = "Alerts you when the tanks need to swap the committee bosses" 
L.Settings_HallsFab_Overpower_Auras_Duration        = "       - Countdown Duration"
L.Settings_HallsFab_Overpower_Auras_Duration_TT     = "The duration of the countdown in milliseconds."
L.Settings_HallsFab_Overpower_Auras_Dynamic         = "       - Dynamic Countdown"
L.Settings_HallsFab_Overpower_Auras_Dynamic_TT      = "When enabled it will attempt to stop the countdown once the tanks have swapped bosses."
L.Settings_HallsFab_Fabricant_Spawn                 = "Committee: Ruined Fabricant Spawn"
L.Settings_HallsFab_Fabricant_Spawn_TT              = "Alerts you when Ruined Fabricant is spawning."
L.Settings_HallsFab_Catastrophic_Discharge          = "Committee: Catastrophic Discharge"
L.Settings_HallsFab_Catastrophic_Discharge_TT       = "Alerts you when a Ruined Fabricant starts to charge at you."
L.Settings_HallsFab_Reclaim_Achieve                 = "Committee: Reclaim the Ruined Achieve Failed"
L.Settings_HallsFab_Reclaim_Achieve_TT              = "Alerts you when the bomber reaches Reclaimer."
-- Alerts
L.Alerts_HallsFab_Taking_Aim                        = "|cFF6600Taking Aim|r targeted at you!"
L.Alerts_HallsFab_Taking_Aim_Other                  = "|cFF6600Taking Aim|r targeted at |cFF0000<<!aC:1>>|r!"
L.Alerts_HallsFab_Taking_Aim_Simple                 = "|cFF6600Taking Aim|r"
L.Alerts_HallsFab_Conduit_Spawn                     = "A Conduit is about to spawn"
L.Alerts_HallsFab_Conduit_Drain                     = "A Conduit is draining you!"
L.Alerts_HallsFab_Conduit_Drain_Other               = "A Conduit is draining |cFF0000<<!aC:1>>|r!"
L.Alerts_HallsFab_Conduit_Strike                    = "Incoming |cFF0000Conduit Strike|r. Block!"
L.Alerts_HallsFab_Draining_Ballista                 = "|cFFC000Draining Ballista|r targeted at you! Block or interrupt!"
L.Alerts_HallsFab_Draining_Ballista_Other           = "|cFFC000Draining Ballista|r targeted at |cFF0000<<!aC:1>>|r! Interrupt!"
L.Alerts_HallsFab_Power_Leech                       = "|c6600FFPower Leech|r! Break Free!"
L.Alerts_HallsFab_Overcharge_Aura                   = "|c3366EEOvercharging Aura|r at Reclaimer."
L.Alerts_HallsFab_Overpower_Auras                   = "|cFF0000Aura Countdown!|r"
L.Alerts_HallsFab_Catastrophic_Discharge            = "|cFF0000Catastrophic Discharge|r at you! Block!"
L.Alerts_HallsFab_Fabricant_Spawn                   = "|cFFC000Ruined Fabricant Spawn|r"
L.Alerts_HallsFab_Reclaim_Achieve                   = "|cDCD822[Planned Obsolescence]|r Achievement |cFF0000Failed|r"



--------------------------------
----   Asylum Sanctorium    ----
--------------------------------
L.Settings_Asylum_Header                         = "Asylum Sanctorium"
-- Settings
L.Settings_Asylum_Defiling_Blast                 = "Saint Llothis: Defiling Dye Blast"
L.Settings_Asylum_Defiling_Blast_TT              = "Alerts you when Saint Llothis targets you or others with his cone attack."
L.Settings_Asylum_Soul_Stained_Corruption        = "Saint Llothis: Soul Stained Corruption"
L.Settings_Asylum_Soul_Stained_Corruption_TT     = "Alerts you when Saint Llothis targets players with his attack that should be bashed."
L.Settings_Asylum_Teleport_Strike                = "Saint Felms: Teleport Strike"
L.Settings_Asylum_Teleport_Strike_TT             = "Alerts you when Saint Felms is going to teleport at you."
L.Settings_Asylum_Exhaustive_Charges             = "Saint Olms: Exhaustive Charges"
L.Settings_Asylum_Exhaustive_Charges_TT          = "Alerts you when Saint Olms is about to launch his attack that drops three large lightning circles."
L.Settings_Asylum_Storm_The_Heavens              = "Saint Olms: Storm the Heavens"
L.Settings_Asylum_Storm_The_Heavens_TT           = "Alerts you when Saint Olms is about to go into the air and spawns a large amount of smaller lightning circles."
L.Settings_Asylum_Gusts_Of_Steam                 = "Saint Olms: Gusts Of Steam"
L.Settings_Asylum_Gusts_Of_Steam_TT              = "Alerts you when Saint Olms is about to jump back and forth, signaling the next phase of the fight."
L.Settings_Asylum_Gusts_Of_Steam_Slider          = "       - Percentage before jump"
L.Settings_Asylum_Gusts_Of_Steam_Slider_TT       = "Show notification couple percent of boss health faster before he jump."
L.Settings_Asylum_Protector_Spawn                = "Saint Olms: Protector Spawn"
L.Settings_Asylum_Protector_Spawn_TT             = "Alerts you when sphere is about to spawn."
L.Settings_Asylum_Trial_By_Fire                  = "Saint Olms: Trial By Fire"
L.Settings_Asylum_Trial_By_Fire_TT               = "Alerts you when Saint Olms is about to cast fire on execute phase."
-- Alerts
L.Alerts_Asylum_Defiling_Blast                   = "Warning! |c00cc00Defiling Blast|r on you"
L.Alerts_Asylum_Defiling_Blast_Other             = "Warning! |c00cc00Defiling Blast|r on |cFF0000<<!aC:1>>|r"
L.Alerts_Asylum_Soul_Stained_Corruption          = "Incoming |c3366EESoul Stained Corruption|r. Interrupt!"
L.Alerts_Asylum_Teleport_Strike                  = "|cFF3366Teleport Strike|r on you"
L.Alerts_Asylum_Teleport_Strike_Other            = "|cFF3366Teleport Strike|r on |cFF0000<<!aC:1>>|r"
L.Alerts_Asylum_Exhaustive_Charges               = "Incoming |cFF0000Exhaustive Charges|r"
L.Alerts_Asylum_Storm_The_Heavens                = "Incoming |cFF0000Storm The Heavens|r! Kite!"
L.Alerts_Asylum_Gusts_Of_Steam                   = "Incoming |cFF9900Gusts Of Steam|r! Hide!"
L.Alerts_Asylum_Pre_Gusts_Of_Steam               = "<<1>> to |cFF0000jump|r! Prepare to Hide!"
L.Alerts_Asylum_Trial_By_Fire                    = "Incoming |cFF5500Fire|r!"
L.Alerts_Asylum_Protector_Spawn                  = "|c0000FFProtector|r spawning!"
L.Alerts_Asylum_Protector_Active                 = "|c0000FFProtector|r active!"



--------------------------------
----       Debugging        ----
--------------------------------
L.Settings_Debug_Header                  = "Debug"
L.Settings_Debug                         = "Turn debug on"
L.Settings_Debug_TT                      = "Turns on debugging output in chatwindow"
L.Settings_Debug_DevMode                 = "Dev Mode"
L.Settings_Debug_DevMode_TT              = "When this is turned on it enables certain alerts that might not be fully functioning, have mismatching timing or aren't fully tested yet. In general they should not produce UI errors but some sort of 'error catcher' addon is still recommended."
L.Settings_Debug_DevMode_Warning         = "Requires DevMode"

L.Settings_Debug_Tracker_Header          = "Debug Tracker"
L.Settings_Debug_Tracker_Description     = "This is a debug feature meant to track down and output potential mechanics during the course of a trial by printing out info on combat events and effects. Due to the potentially large amount of output there are a few options to help avoid cluttering your chat window."
L.Settings_Debug_Tracker_Enabled         = "Enabled"
L.Settings_Debug_Tracker_SpamControl     = "Spam Control"
L.Settings_Debug_Tracker_SpamControl_TT  = "With this each ability/effect is only printed once per action type. List of known abilities this session can be cleared with \"/rndebug clear\"."
L.Settings_Debug_Tracker_MyEnemyOnly     = "My Enemy Only"
L.Settings_Debug_Tracker_MyEnemyOnly_TT  = "When enabled this will limit ALL output to abilities/effects that are targeted at the player and are NOT coming from the player or the group. Useful for when you are looking for a specific thing and you do not want spam control enabled."



--TODO: get rid of this ugly, bulky localization method
for k, v in pairs(L) do
    local string = "RAIDNOTIFIER_" .. string.upper(k)
    ZO_CreateStringId(string, v)
end

function RaidNotifier:GetLocale()
	return L
end
function RaidNotifier:MissingLocale()
	d("Obviously not missing any english strings....")
end

--if (GetCVar('language.2') == 'de') then 
--	local MissingL = {}
--	for k, v in pairs(RaidNotifier:GetLocale()) do
--		if (not L[k]) then
--			table.insert(MissingL, k)
--			L[k] = v
--		end
--	end
--	function RaidNotifier:GetLocale() 
--		return L
--	end
--	-- for debugging 
--	function RaidNotifier:MissingLocale()
--		df("Missing strings for '%s'", GetCVar('language.2'))
--		d(MissingL)
--	end
--end
