local L = {}

L.Description                            = "Zeigt Benachrichtigungen während Prüfungen. Nur bei Veteranenprüfungen!"

--------------------------------
----     General Stuff      ----
--------------------------------
L.Settings_General_Header                           = "Allgemein"
-- Settings 
L.Settings_General_Bufffood_Reminder                = "Bufffood Erinnerung"
L.Settings_General_Bufffood_Reminder_TT             = "Erinnert dich wenn du eine Prüfung ohne Bufffood startest \nODER\n dein Bufffood zu Ende geht (siehe Intervall)"
L.Settings_General_Bufffood_Reminder_Interval       = "Intervall für Bufffood Erinnerung"
L.Settings_General_Bufffood_Reminder_Interval_TT    = "Hier kannst du den Intervall einstellen, mit welchem RaidNotifier dich an dein Bufffoood erinnert.\n\nAlle X Sekunden. \n\nBeginnt, wenn weniger als 10 Minuten übrig sind."
L.Settings_General_Vanity_Pets                      = "Deaktiviert Begleiter während Prüfungen"
L.Settings_General_Vanity_Pets_TT                   = "Deaktiviert deinen friedlichen Begleiter. Sobald die Prüfung zu Ende ist wird er automatisch wieder aktiviert"
L.Settings_General_No_Assistants                    = "Deaktiviert Assistenten sobald der Kampf startet"
L.Settings_General_No_Assistants_TT                 = "Funktioniert nur während Prüfungen. Verhindert NICHT, dass sie manuell beschworen werden können"
L.Settings_General_Center_Screen_Announce           = "Zentrale Bildschirmankündigungen"
L.Settings_General_Center_Screen_Announce_TT        = "Nutzt das Ankündigungsystem für Benachrichtigungen des Spiels. Alternative gibt es eine eigene Version von RaidNotifier."
-- Choices
L.Settings_General_Choices_Off                      = "Aus"
L.Settings_General_Choices_Full                     = "Voll"
L.Settings_General_Choices_Normal                   = "Normal"
L.Settings_General_Choices_Minimal                  = "Minimal"
L.Settings_General_Choices_Self                     = "Selbst"
L.Settings_General_Choices_Near                     = "Nähe"
L.Settings_General_Choices_All                      = "Alle"
L.Settings_General_Choices_Always                   = "Immer"
L.Settings_General_Choices_Other                    = "Andere"
-- Alerts
L.Alerts_General_No_Bufffood                        = "Du hast kein Bufffood genommen!"
L.Alerts_General_Bufffood_Minutes                   = "Dein '<<1>>' Bufffood endet in |cbd0000<<2>>|r Minuten!"


--------------------------------
----     Hel Ra Citadel     ----
--------------------------------
L.Settings_HelRa_Header                             = "Zitadelle von Hel'Ra"
-- Settings
L.Settings_HelRa_Warrior_StoneForm                  = "Krieger: Steinform"
L.Settings_HelRa_Warrior_StoneForm_TT               = "Warnt dich wenn du oder andere vom Krieger zu Stein verwandelt werden"
L.Settings_HelRa_Warrior_ShieldThrow                = "Krieger: Schildwurf"
L.Settings_HelRa_Warrior_ShieldThrow_TT             = "Warnt dich wenn der Krieger kurz davor ist seinen Schild zu werden"
--Alerts
L.Alerts_HelRa_Warrior_StoneForm                    = "Du wirst |c595959Versteinert|r KEINE Synergien benutzen!"
L.Alerts_HelRa_Warrior_StoneForm_Other              = "Vorsicht! |c595959Versteinern|r von |cFF0000<<!aC:1>>|r"
L.Alerts_HelRa_Warrior_ShieldThrow                  = "Vorsicht! |cFF0000Schildwurf|r. "


--------------------------------
----   Aetherian Archives   ----
--------------------------------
L.Settings_Archive_Header                           = "Ätherisches Archiv"
-- Settings
L.Settings_Archive_StormAtro_ImpendingStorm         = "Sturmatronach: Anhaltender Sturm"
L.Settings_Archive_StormAtro_ImpendingStorm_TT      = "Warnt dich, wenn der Sturmatronach seine große Sturm-AOE wirkt."
L.Settings_Archive_StormAtro_LightningStorm         = "Sturmatronach: Blitzsturm"
L.Settings_Archive_StormAtro_LightningStorm_TT      = "Warnt dich, wenn der Sturmatronach seinen Blitzsturm ruft vor dem du dich schützen musst."
L.Settings_Archive_StoneAtro_BoulderStorm           = "Steinatronach: Steinsturm"
L.Settings_Archive_StoneAtro_BoulderStorm_TT        = "Warnt dich, wenn der Steinatronach mehrere Steine auf deine Gruppe schleudert."
L.Settings_Archive_StoneAtro_BigQuake               = "Steinatronach: Großes Erdbeben"
L.Settings_Archive_StoneAtro_BigQuake_TT            = "Warnt dich, wenn der Steinatronach die Erde erschüttert."
L.Settings_Archive_Overcharge                       = "Gegner: Überladen"
L.Settings_Archive_Overcharge_TT                    = "Warnt dich, wenn ein Überlader dich als Ziehl für seine Überladung wählt."
L.Settings_Archive_Call_Lightning                   = "Gegner: Sturmrufen"
L.Settings_Archive_Call_Lightning_TT                = "Warnt dich, wenn der Überlader einen Sturm auf dich ruft, bleib in Bewegung."
-- Alerts 
L.Alerts_Archive_StormAtro_ImpendingStorm           = "Vorsicht! |cFF0000Anhaltender Sturm|r!"
L.Alerts_Archive_StormAtro_LightningStorm           = "Vorsicht! |cfef92eBlitzsturm|r! Gehe ins Lich!"
L.Alerts_Archive_StoneAtro_BoulderStorm             = "Vorsicht! |cFF0000Steinsturm|r! Blocken!"
L.Alerts_Archive_StoneAtro_BigQuake                 = "Vorsicht! |cFF0000Großes Beben|r!"
L.Alerts_Archive_Overcharge                         = "Vorsicht! |c46edffÜberladung|r auf dir."
L.Alerts_Archive_Overcharge_Other                   = "Vorsicht! |c46edffÜberladung|r auf |cFF0000<<!aC:1>>|r."
L.Alerts_Archive_Call_Lightning                     = "Vorsicht! |c46edffSturmrufen|r auf dir. Renn!"
L.Alerts_Archive_Call_Lightning_Other               = "Vorsicht! |c46edffSturmrufen|r auf |cFF0000<<!aC:1>>|r."


--------------------------------
----    Sanctum Ophidia     ----
--------------------------------
L.Settings_Sanctum_Header                           = "Sanctum Ophidia"
-- Settings
L.Settings_Sanctum_Magicka_Detonation               = "Schlange: Magicka Detonation"
L.Settings_Sanctum_Magicka_Detonation_TT            = "Warnt dich, wenn du die Magicka Detonation auf dir hast."
L.Settings_Sanctum_Serpent_Poison                   = "Schlange: Giftphase"
L.Settings_Sanctum_Serpent_Poison_TT                = "Warnt dich vor der Giftphase während des Kampfes mit der Schlange."
L.Settings_Sanctum_Mantikora_Spear                  = "Mantikora: Speer"
L.Settings_Sanctum_Mantikora_Spear_TT               = "Warnt dich, wenn der Mantikora dich mit seinem Speer wählt."
L.Settings_Sanctum_Mantikora_Quake                  = "Mantikora: Erdbeben"
L.Settings_Sanctum_Mantikora_Quake_TT               = "Warnt dich, wenn du 3x Beben oder Runen auf dir hast."
L.Settings_Sanctum_Troll_Boulder                    = "Gegner: Troll Steinwurf"
L.Settings_Sanctum_Troll_Boulder_TT                 = "Warnt dich, wenn ein Troll einen Felsbrocken nach dir wirft."
L.Settings_Sanctum_Troll_Poison                     = "Gegner: Trollgift"
L.Settings_Sanctum_Troll_Poison_TT                  = "Warnt dich, wenn ein Troll kurz davor ist dich mit Gift zu infizieren."
L.Settings_Sanctum_Overcharge                       = "Gegner: Überladen"
L.Settings_Sanctum_Overcharge_TT                    = "Warnt dich, wenn ein Überlader dich als Ziehl für seine Überladung wählt."
L.Settings_Sanctum_Call_Lightning                   = "Gegner: Sturmrufen"
L.Settings_Sanctum_Call_Lightning_TT                = "Warnt dich, wenn der Überlader einen Sturm auf dich ruft, bleib in Bewegung."
-- Alerts
L.Alerts_Sanctum_Serpent_Poison0                    = "Vorsicht! |c39942eGiftphase|r! Zusammenbleiben!"
L.Alerts_Sanctum_Serpent_Poison1                    = "Vorsicht! |c39942eGiftphase|r! Gefolgt von |ccc0000Lamias|r."
L.Alerts_Sanctum_Serpent_Poison2                    = "Vorsicht! |c39942eGiftphase|r! Gefolgt von |c009933Mantikora|r." --links
L.Alerts_Sanctum_Serpent_Poison3                    = "Vorsicht! |c39942eGiftphase|r! Gefolgt von |c009933Mantikora|r." --rechts
L.Alerts_Sanctum_Serpent_Poison4                    = "Vorsicht! |c39942eGiftphase|r! Gefolgt von |cff33ccSchilden|r."
L.Alerts_Sanctum_Serpent_Poison5                    = "Finale |c39942eGiftphase|r!"
L.Alerts_Sanctum_Magicka_Detonation                 = "|c234afaMagicka Detonation|r! Verbrenne all deine Magicka!"
L.Alerts_Sanctum_Mantikora_Spear                    = "Mantikora |ccde846Speer|r auf dir! Raus da!"
L.Alerts_Sanctum_Mantikora_Spear_Other              = "Mantikora |ccde846Speer|r auf <<!aC:1>>! Raus da!"
L.Alerts_Sanctum_Mantikora_Quake                    = "Mantikora |ccde846Beben|r unter dir! Schnell weg da!"
L.Alerts_Sanctum_Troll_Poison                       = "Vorsicht! |c66ff33Trollgift|r. nicht verbreiten!"
L.Alerts_Sanctum_Troll_Poison_Other                 = "Vorsicht! |c66ff33Trollgift|r auf |cFF0000<<!aC:1>>|r."
L.Alerts_Sanctum_Troll_Boulder                      = "Vorsicht! |c595959Steinwurf|r. Vermeiden!"
L.Alerts_Sanctum_Troll_Boulder_Other                = "Vorsicht! |c595959Steinwurf|r auf |cFF0000<<!aC:1>>|r."
L.Alerts_Sanctum_Overcharge                         = "Vorsicht! |c46edffÜberladung auf dir."
L.Alerts_Sanctum_Overcharge_Other                   = "Vorsicht! |c46edffÜberladung auf |cFF0000<<!aC:1>>|r."
L.Alerts_Sanctum_Call_Lightning                     = "Vorsicht! |c46edffSturmrufen|r auf dir. Bleib in Bewegung!"
L.Alerts_Sanctum_Call_Lightning_Other               = "Vorsicht! |c46edffSturmrufen|r auf |cFF0000<<!aC:1>>|r."


--------------------------------
----    Maelstrom Arena     ----
--------------------------------
L.Settings_Maelstrom_Header                         = "Mahlstrom Arena"
-- Settings
L.Settings_Maelstrom_Stage7_Poison                  = "Runde 7: Gift"
L.Settings_Maelstrom_Stage7_Poison_TT               = "Warnt dich, wenn du vergiftet wurdest in Runde 7 (Vault of Umbrage)."
L.Settings_Maelstrom_Stage9_Synergy                 = "Runde 9: Spektrale Explosion (Synergie)"
L.Settings_Maelstrom_Stage9_Synergy_TT              = "Warnt dich, wenn du die Synergie in Runde 9 verfügbar hast (Theater of Despair) nachdem du 3 (goldene) Geister gesammelt hast."
-- Alerts
L.Alerts_Maelstrom_Stage7_Poison                    = "|c39942eVergiftet|r! Reinigen in einem der Teiche!"
L.Alerts_Maelstrom_Stage9_Synergy                   = "|c23afe7Spectrale Explosion|r Bereit! Synergie nutzen!"


--------------------------------
----     Maw of Lorkhaj     ----
--------------------------------
L.Settings_MawLorkhaj_Header                        = "Schlund von Lorkhaj"
-- Settings
L.Settings_MawLorkhaj_Zhaj_GripOfLorkhaj            = "Zhaj'hassa: Griff von Lorkhaj"
L.Settings_MawLorkhaj_Zhaj_GripOfLorkhaj_TT         = "Erhalte eine Warnung wenn der Griff von Lorkhaj-Debuff dich betrifft."
L.Settings_MawLorkhaj_Zhaj_Glyphs                   = "Zhaj'hassa: Reinigungsplattformen (beta)"
L.Settings_MawLorkhaj_Zhaj_Glyphs_TT                = "Zeigt ein Fenster mit allen Plattformen und deren Position und wann sie respawnen."
L.Settings_MawLorkhaj_Twin_Aspects                  = "Falsche Mondzwillinge: Aspekte"
L.Settings_MawLorkhaj_Twin_Aspects_TT               = "Warnt dich wenn du entweder den Lunar oder Schattenaspekt der falschen Zwillinge bekommst.\n\n    Voll warnt dich wenn du einen Aspekt bekommst, wenn die Konvertierung startet und wenn die Konvertierung komplett ist.\n    Normal warnt dich wenn du einen Aspekt bekommst und wenn die Konvertierung vollendet ist.\n    Minimal warnt dich nur wenn du konvertierst."
L.Settings_MawLorkhaj_Rakkhat_Unstable_Void         = "Rakkhat: Instabile Leere"
L.Settings_MawLorkhaj_Rakkhat_Unstable_Void_TT      = "Warnt dich, wenn du unter Einfluss der Instabilen Leere von Rakkhat stehst."
L.Settings_MawLorkhaj_Rakkhat_ThreshingWings        = "Rakkhat: Schmetternde Flügel"
L.Settings_MawLorkhaj_Rakkhat_ThreshingWings_TT     = "Warnt dich vor Rakkhats zerschmetternden Flügeln, welche dich zurückwerfen."
L.Settings_MawLorkhaj_Rakkhat_DarknessFalls         = "Rakkhat: Hereinbrechende Dunkelheit"
L.Settings_MawLorkhaj_Rakkhat_DarknessFalls_TT      = "Warnt dich vor Rakkhats hereinbrechender Dunkelheit, bei welcher die Decke hinabstürzt."
L.Settings_MawLorkhaj_Rakkhat_DarkBarrage           = "Rakkhat: Dunkles Sperrfeuer"
L.Settings_MawLorkhaj_Rakkhat_DarkBarrage_TT        = "Warnt dich, wenn Rakkhat sein dunkles Sperrfeuer gegen den Tank verwendet."
L.Settings_MawLorkhaj_Rakkhat_LunarBastion1         = "Rakkhat: Mondbastion aktiv"
L.Settings_MawLorkhaj_Rakkhat_LunarBastion1_TT      = "Zeigt wenn du den Mondsegen der leuchtenden Plattform erhälst."
L.Settings_MawLorkhaj_Rakkhat_LunarBastion2         = "Rakkhat: Mondbastion inaktiv"
L.Settings_MawLorkhaj_Rakkhat_LunarBastion2_TT      = "Zeigt wenn du den Mondsegen der leuchtenden Plattform verlierst."
L.Settings_MawLorkhaj_Shattered                     = "Gegner: Rüstung zerschmettert"
L.Settings_MawLorkhaj_Shattered_TT                  = "Erhalte eine Warnung wenn deine Rüstung zerschmettert wurde."
L.Settings_MawLorkhaj_MarkedForDeath                = "Gegner: Zum Tode markiert (Panther)"
L.Settings_MawLorkhaj_MarkedForDeath_TT             = "Erhalte eine Warnung, wenn du für die Panther zum Tode markiert wurdest."
L.Settings_MawLorkhaj_Suneater_Eclipse              = "Gegner: Sonnenfresser Eklipsenfeld (Negate)"
L.Settings_MawLorkhaj_Suneater_Eclipse_TT           = "Erhalte eine Warnung, wenn das Eklipsenfeld auf dir erscheint."
-- Alerts
L.Alerts_MawLorkhaj_Zhaj_GripOfLorkhaj              = "Vorsicht! |c000055Griff von Lorkhaj!|r Sofort reinigen!"
L.Alerts_MawLorkhaj_Lunar_Aspect                    = "Erhalten: |cFEFF7FMond|r Aspekt!"
L.Alerts_MawLorkhaj_Shadow_Aspect                   = "Erhalten: |c000055Schatten|r Aspekt!"
L.Alerts_MawLorkhaj_Lunar_Conversion                = "Konvertiere zu |cFEFF7FMond|r Aspekt!"
L.Alerts_MawLorkhaj_Shadow_Conversion               = "Konvertiere zu |c000055Schatten|r Aspekt!"
L.Alerts_MawLorkhaj_Rakkhat_Unstable_Void           = "Warnung! |c000055Instabile Leere|r unter dir"
L.Alerts_MawLorkhaj_Rakkhat_Unstable_Void_Other     = "Warnung! |c000055Instabile Leere|r unter |cFF0000<<!aC:1>>|r"
L.Alerts_MawLorkhaj_Rakkhat_ThreshingWings          = "Vorsicht! |cFF0000Schmetternde Flügel|r! Block!"
L.Alerts_MawLorkhaj_Rakkhat_DarknessFalls           = "Vorsicht! |cFF0000Hereinbrechende Dunkelheit|r!"
L.Alerts_MawLorkhaj_Rakkhat_DarkBarrage             = "Vorsicht! |cFF0000Dunkles Sperrfeuer|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion1           = "Du erhälst den |cFEFF7FMondsegen|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion1_Other     = "|cFF0000<<!aC:1>>|r erhält |cFEFF7FMondsegen|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion2           = "Du verlierst |cFEFF7FMondsegen|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion2_Other     = "|cFF0000<<!aC:1>>|r verliert |cFEFF7FMondsegen|r"
L.Alerts_MawLorkhaj_Suneater_Eclipse                = "Vorsicht! |cFF0000Eklipsenfeld|r auf dir."
L.Alerts_MawLorkhaj_Suneater_Eclipse_Other          = "Vorsicht! |cFF0000Eklipsenfeld|r auf |cFF0000<<!aC:1>>|r!"
L.Alerts_MawLorkhaj_Shattered                       = "Deine |c595959Rüstung|r wurde |cff0000zerschmettert|r."
L.Alerts_MawLorkhaj_MarkedForDeath                  = "Vorsicht! |c000055Panther|r sind hinter DIR her!"


--------------------------------
----    Dragonstar Arena    ----
--------------------------------
L.Settings_Dragonstar_Header                        = "Drachenstern-Arena"
-- Settings
L.Settings_Dragonstar_General_Taking_Aim            = "Allgemein: Anlegen"
L.Settings_Dragonstar_General_Taking_Aim_TT         = "Warnt dich, wenn du das Ziel von Anlegen bist."
L.Settings_Dragonstar_General_Crystal_Blast         = "Allgemein: Kristallexplosion"
L.Settings_Dragonstar_General_Crystal_Blast_TT      = "Warnt dich, wenn du das Ziel von Kristallexplosion bist."
L.Settings_Dragonstar_Arena2_Crushing_Shock         = "Arena 2: Zermalmender Schlag"
L.Settings_Dragonstar_Arena2_Crushing_Shock_TT      = "Warnt dich, wenn du das Ziel von Zermalmender Schlag in der Eis-Arena bist."
L.Settings_Dragonstar_Arena6_Drain_Resource         = "Arena 6: Ressourcenentzug"
L.Settings_Dragonstar_Arena6_Drain_Resource_TT      = "Warnt dich, wenn du das Ziel des ressourcenentziehenden Giftpfeils in der Bosmer-Arena bist."
L.Settings_Dragonstar_Arena7_Unstable_Core          = "Arena 7: Instabiler Kern (Eklipse)"
L.Settings_Dragonstar_Arena7_Unstable_Core_TT       = "Warnt dich, wenn du das Ziel des Instabilen Kerns (Eklipse) des Bosses in der Opfer-Arena bist."
L.Settings_Dragonstar_Arena8_Ice_Charge             = "Arena 8: Eisangriff"
L.Settings_Dragonstar_Arena8_Ice_Charge_TT          = "Warnt dich, wenn der Eiszenturio sein Eis auf dich abfeuert."
L.Settings_Dragonstar_Arena8_Fire_Charge            = "Arena 8: Feuerangriff"
L.Settings_Dragonstar_Arena8_Fire_Charge_TT         = "Warnt dich, wenn der Feuerzenturio sein Feuer auf dich wirft."
-- Alerts
L.Alerts_Dragonstar_General_Taking_Aim              = "|cFF6600Anlegen|r auf dir!"
L.Alerts_Dragonstar_General_Crystal_Blast           = "|c990099Kristallexplosion|r auf dir!"
L.Alerts_Dragonstar_Arena2_Crushing_Shock           = "Vorsicht! |c3366EEZermalmender Schlag|r! Block!"
L.Alerts_Dragonstar_Arena6_Drain_Resource           = "Vorsicht! |c00CC00Ressourcenentzug|r! Ausweichen!"
L.Alerts_Dragonstar_Arena6_Drain_Resource_Other     = "Vorsicht! |c00CC00Ressourcenentzug|r auf |cFF0000<<!aC:1>>|r."
L.Alerts_Dragonstar_Arena7_Unstable_Core            = "Du hast |cDDDD33Instabiler Kern (Eklipse)|r! Ausbrechen!"
L.Alerts_Dragonstar_Arena8_Ice_Charge               = "Vorsicht! |c6699FFEisangriff|r auf dir! Unterbrechen oder Ausweichen!"
L.Alerts_Dragonstar_Arena8_Ice_Charge_Other         = "|c6699FFEisangriff|r auf |cFF0000<<!aC:1>>|r. Unterbrechen!"
L.Alerts_Dragonstar_Arena8_Fire_Charge              = "Vorsicht! |cFF3113Feuerangriff|r auf dir! Unterbrechen oder Ausweichen!"
L.Alerts_Dragonstar_Arena8_Fire_Charge_Other        = "|c6699FFeuerangriff|r auf |cFF0000<<!aC:1>>|r. Ausweichen!"


--------------------------------
----       Debugging        ----
--------------------------------
L.Settings_Debug_Header                  = "Debug"
L.Settings_Debug                         = "Turn debug on"
L.Settings_Debug_TT                      = "Turns on debugging output in chatwindow"
L.Settings_DebugNotify                   = "Debug Notify"
L.Settings_DebugNotify_TT                = "Additional debugging for the actual notifications."


--INTERNAL--
for k, v in pairs(L) do
    local string = "RAIDNOTIFIER_" .. string.upper(k)
    ZO_CreateStringId(string, v)
end