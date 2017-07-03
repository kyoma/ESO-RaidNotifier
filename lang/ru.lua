local L = {}

L.Description                           		= "Выводит на экран предупреждения о разаличных событиях в Испытаниях. Только на ветеранской сложности!"

--------------------------------
----     General Stuff      ----
--------------------------------
L.Settings_General_Header                       = "Общие"
-- Settings 
L.Settings_General_Bufffood_Reminder            = "Напоминание о еде"
L.Settings_General_Bufffood_Reminder_TT         = "Напоминает вам, когда вы начинаете испытание без баффа еды \nИЛИ\n ваш бафф еды истекает во время прохождения Испытания (см. интервал)"
L.Settings_General_Bufffood_Reminder_Interval	= "Интервал напоминания о еде"
L.Settings_General_Bufffood_Reminder_Interval_TT= "Здесь вы можете задать интервал частоты, с которой RaidNotifier будет сообщать вам о вашем баффе еды.\n\nКаждые X секунд. \n\nНачиная с момента, когда до истечения текущего баффа еды остаётся 10 минут или менее."
L.Settings_General_Vanity_Pets					= "Отключить пэтов во время Испытания"
L.Settings_General_Vanity_Pets_TT				= "Отключает ваших пэтов при начале Испытания. Как только вы закончите или выйдете из Испытания, пэты включатся снова."
L.Settings_General_No_Assistants				= "Отключить помощников при начале битвы"
L.Settings_General_No_Assistants_TT				= "Работает только в Испытаниях и НЕ запрещает их призыв."
L.Settings_General_Center_Screen_Announce    	= "Предупреждения по центру экрана"
L.Settings_General_Center_Screen_Announce_TT	= "Использует игровую систему предупреждений на экране. Альтернативынй и более простой способ отображения предупреждений Raid Notifier."
-- Choices
L.Settings_General_Choices_Off       			= "Выкл."
L.Settings_General_Choices_Full      			= "Полный"
L.Settings_General_Choices_Normal    			= "Нормальный"
L.Settings_General_Choices_Minimal   			= "Минимальный"
L.Settings_General_Choices_Self      			= "На себе"
L.Settings_General_Choices_Near      			= "По близости"
L.Settings_General_Choices_All       			= "Все"
L.Settings_General_Choices_Always    			= "Всегда"
L.Settings_General_Choices_Other     			= "Другое"
-- Alerts
L.Alerts_General_No_Bufffood        			= "У вас нет БАФФА ЕДЫ!"
L.Alerts_General_Bufffood_Minutes   			= "Ваш бафф еды '<<1>>' истекает через |cbd0000<<2>>|r мин.!"


--------------------------------
----     Hel Ra Citadel     ----
--------------------------------
L.Settings_HelRa_Header                   		= "Цитадель Хель Ра (HRC)"
-- Settings
L.Settings_HelRa_Warrior_StoneForm        		= "Воин: Каменная форма"
L.Settings_HelRa_Warrior_StoneForm_TT     		= "Предупреждает вас, когда вы и/или другие будут обращены Воином в камень."
L.Settings_HelRa_Warrior_ShieldThrow      		= "Воин: Бросок щита"
L.Settings_HelRa_Warrior_ShieldThrow_TT   		= "Предупреждает вас, когда Воин готовится бросить свой щит."
--Alerts
L.Alerts_HelRa_Warrior_StoneForm        		= "|c595959Каменная форма|r начинает действовать на тебя. Не используй синергии!"
L.Alerts_HelRa_Warrior_StoneForm_Other 			= "|c595959Каменная форма|r начинает действовать на |cFF0000<<!aC:1>>|r"
L.Alerts_HelRa_Warrior_ShieldThrow      		= "Начинается |cFF0000Бросок Щита|r. "


--------------------------------
----   Aetherian Archives   ----
--------------------------------
L.Settings_Archive_Header                       = "Этерианский Архив (AA)"
-- Settings
L.Settings_Archive_StormAtro_ImpendingStorm     = "Грозовой Атронах: Impending Storm"
L.Settings_Archive_StormAtro_ImpendingStorm_TT  = "Предупреждает вас, когда Грозовой Атронах готовится применить AoE молниями."
L.Settings_Archive_StormAtro_LightningStorm     = "Грозовой Атронах: Lightning Storm"
L.Settings_Archive_StormAtro_LightningStorm_TT  = "Предупреждает вас, когда Грозовой Атронах призывает молнию с небес и вы должны укрыться от неё."
L.Settings_Archive_StoneAtro_BoulderStorm       = "Каменный Атронах: Boulder Storm"
L.Settings_Archive_StoneAtro_BoulderStorm_TT    = "Предупреждает вас, когда Каменный Атронах начинает швырять множественные камни в игроков."
L.Settings_Archive_StoneAtro_BigQuake           = "Каменный Атронах: Big Quake"
L.Settings_Archive_StoneAtro_BigQuake_TT        = "Предупреждает вас, когда Каменный Атронах начинает бить о землю, вызывая землетрясение, наносящее урон."
L.Settings_Archive_Overcharge            		= "Мобы: Разрядник"
L.Settings_Archive_Overcharge_TT         		= "Предупреждает вас, когда Разрядник выбирает вас своей целью атаки Overcharge."
L.Settings_Archive_Call_Lightning        		= "Мобы: Call Lightning"
L.Settings_Archive_Call_Lightning_TT     		= "Предупреждает вас, когда Разрядник выбирает вас своей целью атаки Call Lightning."
-- Alerts 
L.Alerts_Archive_StormAtro_ImpendingStorm 			= "Начинается |cFF0000Impending Storm|r!"
L.Alerts_Archive_StormAtro_LightningStorm 			= "Начинается |cfef92eLightning Storm|r! Иди на свет!"
L.Alerts_Archive_StoneAtro_BoulderStorm 			= "Начинается |cFF0000Boulder Storm|r! Блокируй, чтобы не сбило с ног!"
L.Alerts_Archive_StoneAtro_BigQuake 				= "Начинается |cFF0000Большое Землетрясение|r!"
L.Alerts_Archive_Overcharge 						= "|c46edffOvercharge|r нацелена на тебя."
L.Alerts_Archive_Overcharge_Other 					= "|c46edffOvercharge|r нацелена на |cFF0000<<!aC:1>>|r."
L.Alerts_Archive_Call_Lightning 					= "|c46edffCall Lightning|r надвигается на тебя. Убирайся!"
L.Alerts_Archive_Call_Lightning_Other 				= "|c46edffCall Lightning|r надвигается на |cFF0000<<!aC:1>>|r."


--------------------------------
----    Sanctum Ophidia     ----
--------------------------------
L.Settings_Sanctum_Header                 		= "Святилище Офидии (SO)"
-- Settings
L.Settings_Sanctum_Magicka_Detonation     		= "Змей: Magicka Detonation"
L.Settings_Sanctum_Magicka_Detonation_TT  		= "Предупреждает, когда вы получаете дебафф магической детонации во время битвы со Змеем."
L.Settings_Sanctum_Serpent_Poison         		= "Змей: Poison Phase"
L.Settings_Sanctum_Serpent_Poison_TT      		= "Предупреждает о начале ядовитой фазы во время битвы со Змеем."
L.Settings_Sanctum_Mantikora_Spear        		= "Мантикора: Spear"
L.Settings_Sanctum_Mantikora_Spear_TT     		= "Предупреждает вас, когда вы получаете копьё Мантикоры."
L.Settings_Sanctum_Mantikora_Quake        		= "Мантикора: Quake"
L.Settings_Sanctum_Mantikora_Quake_TT     		= "Предупреждает, когда вы набираете три землетрясения или руны на Мантикоре."
L.Settings_Sanctum_Troll_Boulder         		= "Мобы: Troll Boulder Toss"
L.Settings_Sanctum_Troll_Boulder_TT      		= "Предупреждает вас, когда тролль готовится бросить булыжник в вас."
L.Settings_Sanctum_Troll_Poison          		= "Мобы: Troll Poison"
L.Settings_Sanctum_Troll_Poison_TT       		= "Предупреждает вас, когда тролль готовится бросить в вас распространяющийся яд."
L.Settings_Sanctum_Overcharge            		= "Мобы: Разрядник"
L.Settings_Sanctum_Overcharge_TT         		= "Предупреждает вас, когда Разрядник выбирает вас своей целью атаки Overcharge."
L.Settings_Sanctum_Call_Lightning        		= "Мобы: Call Lightning"
L.Settings_Sanctum_Call_Lightning_TT     		= "Предупреждает вас, когда Разрядник выбирает вас своей целью атаки Call Lightning."
-- Alerts
L.Alerts_Sanctum_Serpent_Poison0        		= "Наступает |c39942eЯдовитая фаза|r! Соберитесь вместе!"
L.Alerts_Sanctum_Serpent_Poison1        		= "Наступает |c39942eЯдовитая фаза|r! Потом будут |ccc0000Ламии|r."
L.Alerts_Sanctum_Serpent_Poison2        		= "Наступает |c39942eЯдовитая фаза|r! Потом будет |c009933Мантикора (Л)|r." --left
L.Alerts_Sanctum_Serpent_Poison3        		= "Наступает |c39942eЯдовитая фаза|r! Потом будет |c009933Мантикора (П)|r." --right
L.Alerts_Sanctum_Serpent_Poison4        		= "Наступает |c39942eЯдовитая фаза|r! Потом будут |cff33ccЩиты|r."
L.Alerts_Sanctum_Serpent_Poison5        		= "Финальная |c39942eЯдовитая фаза|r!"
L.Alerts_Sanctum_Magicka_Detonation     		= "|c234afaMagicka Detonation|r! Слей всю свою ману!"
L.Alerts_Sanctum_Mantikora_Spear        		= "|ccde846Копьё|r Мантикоры на тебе! Убирайся!"
L.Alerts_Sanctum_Mantikora_Spear_Other 			= "|ccde846Копьё|r Мантикоры на <<!aC:1>>! Убирайся!"
L.Alerts_Sanctum_Mantikora_Quake        		= "|ccde846Землетрясение|r Мантикоры под тобой! Убирайся!"
L.Alerts_Sanctum_Troll_Poison           		= "|c66ff33Яд Тролля|r начинает действовать. Не заражай им других!"
L.Alerts_Sanctum_Troll_Poison_Other    			= "|c66ff33Яд Тролля|r на |cFF0000<<!aC:1>>|r."
L.Alerts_Sanctum_Troll_Boulder          		= "Тролль кидает |c595959Boulder Toss|r. Увернись!"
L.Alerts_Sanctum_Troll_Boulder_Other   			= "Тролль кидает |c595959Boulder Toss|r на |cFF0000<<!aC:1>>|r."
L.Alerts_Sanctum_Overcharge             		= "|c46edffOvercharge|r нацелена на тебя."
L.Alerts_Sanctum_Overcharge_Other     		 	= "|c46edffOvercharge|r нацелена на |cFF0000<<!aC:1>>|r."
L.Alerts_Sanctum_Call_Lightning         		= "|c46edffCall Lightning|r надвигается на тебя. Убирайся!"
L.Alerts_Sanctum_Call_Lightning_Other  			= "|c46edffCall Lightning|r надвигается на |cFF0000<<!aC:1>>|r."


--------------------------------
----    Maelstrom Arena     ----
--------------------------------
L.Settings_Maelstrom_Header              		= "Вихревая Арена (MSA)"
-- Settings
L.Settings_Maelstrom_Stage7_Poison       		= "Уровень 7: Яд"
L.Settings_Maelstrom_Stage7_Poison_TT    		= "Предупреждает вас, когда вы получаете яд на уровне 7 (Vault of Umbrage)."
L.Settings_Maelstrom_Stage9_Synergy      		= "Уровень 9: Spectral Explosion (Синергия)"
L.Settings_Maelstrom_Stage9_Synergy_TT   		= "Предупреждает вас, когда вы получаете Синергию на уровне 9 (Theater of Despair) после того, как соберёте 3 (золотых) Призрака."
-- Alerts
L.Alerts_Maelstrom_Stage7_Poison 					= "|c39942eЗаражён ядом|r! Используй одну из двух областей, чтобы очиститься!"
L.Alerts_Maelstrom_Stage9_Synergy 					= "|c23afe7Spectral Explosion|r готова! Используй синергию!"


--------------------------------
----     Maw of Lorkhaj     ----
--------------------------------
L.Settings_MawLorkhaj_Header                 	= "Пасть Лорхаджа (MoL)"
-- Settings
L.Settings_MawLorkhaj_Zhaj_GripOfLorkhaj     	= "Жай'хасса: Grip of Lorkhaj"
L.Settings_MawLorkhaj_Zhaj_GripOfLorkhaj_TT  	= "Предупреждает, когда дебафф Grip of Lorkhaj начинает действовать на вас."
L.Settings_MawLorkhaj_Zhaj_Glyphs        		= "Жай'хасса: Очищающие платформы (beta)"
L.Settings_MawLorkhaj_Zhaj_Glyphs_TT     		= "Показывает окно со всеми очищабщими платформами, с их статусом и временем перезарядки."
L.Settings_MawLorkhaj_Twin_Aspects           	= "Ложные лунные близнецы: Аспект"
L.Settings_MawLorkhaj_Twin_Aspects_TT        	= "Предупреждает, когда вы получаете лунный или теневой аспекты от Ложных Братьев.\n\n|cFFA500Полный:|r Предупреждает вас, когда вы получаете аспект, когда вы начинаете менять аспект и когда смена завершается.\n|cFFA500Нормальный:|r Предупреждает вас, когда вы получаете аспект и когда вы меняете его.\n|cFFA500Минимальный:|r Предупреждает вас, когда вы меняете аспект."
L.Settings_MawLorkhaj_Rakkhat_Unstable_Void     = "Ракхат: Unstable Void"
L.Settings_MawLorkhaj_Rakkhat_Unstable_Void_TT  = "Предупреждает, когда на вас есть эффект Unstable Void в битве с Ракхатом."
L.Settings_MawLorkhaj_Rakkhat_ThreshingWings    = "Ракхат: Threshing Wings"
L.Settings_MawLorkhaj_Rakkhat_ThreshingWings_TT = "Предупреждает, когда Ракхат использует свою способность Threshing Wings, сбивающую вас с ног."
L.Settings_MawLorkhaj_Rakkhat_DarknessFalls     = "Ракхат: Darkness Falls"
L.Settings_MawLorkhaj_Rakkhat_DarknessFalls_TT  = "Предупреждает, когда Ракхат использует свою способность Darkness Falls, при которой рушится потолок."
L.Settings_MawLorkhaj_Rakkhat_DarkBarrage     	= "Ракхат: Dark Barrage"
L.Settings_MawLorkhaj_Rakkhat_DarkBarrage_TT  	= "Предупреждает, когда Ракхат использует свою туннельную способность Dark Barrage на танка."
L.Settings_MawLorkhaj_Rakkhat_LunarBastion1     = "Ракхат: Получение Lunar Bastion"
L.Settings_MawLorkhaj_Rakkhat_LunarBastion1_TT  = "Показывает, когда игрок ПОЛУЧАЕТ благословение со светящейся платформы."
L.Settings_MawLorkhaj_Rakkhat_LunarBastion2     = "Ракхат: Потеря Lunar Bastion"
L.Settings_MawLorkhaj_Rakkhat_LunarBastion2_TT  = "Показывает, когда игрок ТЕРЯЕТ благословение со светящейся платформы."
L.Settings_MawLorkhaj_Shattered   		 		= "Мобы: Armor Shattered"
L.Settings_MawLorkhaj_Shattered_TT		 		= "Предупреждает, когда ваша броня разбита."
L.Settings_MawLorkhaj_MarkedForDeath      		= "Мобы: Marked for death (Пантеры)"
L.Settings_MawLorkhaj_MarkedForDeath_TT  		= "Предупреждает, если вы помечены для смерти пантерами Dro-m'Athra Dreadstalker"
L.Settings_MawLorkhaj_Suneater_Eclipse    		= "Мобы: Sun-Eater Eclipse Field (нигейт)"
L.Settings_MawLorkhaj_Suneater_Eclipse_TT 		= "Предупреждает, если вы попадаете под действие нигейта Eclipse Field."
-- Alerts
L.Alerts_MawLorkhaj_Zhaj_GripOfLorkhaj 			= "Внимание! |c000055Grip of Lorkhaj!|r Очистись!"
L.Alerts_MawLorkhaj_Lunar_Aspect 				= "Ты под |cFEFF7FЛунным|r Аспектом!"
L.Alerts_MawLorkhaj_Shadow_Aspect 				= "Ты под Аспектом |c000055Тени|r!"
L.Alerts_MawLorkhaj_Lunar_Conversion 			= "Смена на |cFEFF7FЛунный|r Аспект!"
L.Alerts_MawLorkhaj_Shadow_Conversion 			= "Смена на Аспект |c000055Тени|r!"
L.Alerts_MawLorkhaj_Rakkhat_Unstable_Void 		= "Внимание! |c000055Unstable Void|r под тобой!"
L.Alerts_MawLorkhaj_Rakkhat_Unstable_Void_Other = "Внимание! |c000055Unstable Void|r под |cFF0000<<!aC:1>>|r!"
L.Alerts_MawLorkhaj_Rakkhat_ThreshingWings 		= "Приближается |cFF0000Threshing Wings|r! Блокируй!"
L.Alerts_MawLorkhaj_Rakkhat_DarknessFalls 		= "Приближается |cFF0000Darkness Falls|r!"
L.Alerts_MawLorkhaj_Rakkhat_DarkBarrage 		= "Приближается |cFF0000Dark Barrage|r!"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion1 		= "Ты получил |cFEFF7FLunar Bastion|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion1_Other = "|cFF0000<<!aC:1>>|r получил |cFEFF7FLunar Bastion|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion2 		= "Ты потерял |cFEFF7FLunar Bastion|r"
L.Alerts_MawLorkhaj_Rakkhat_LunarBastion2_Other = "|cFF0000<<!aC:1>>|r потерял |cFEFF7FLunar Bastion|r"
L.Alerts_MawLorkhaj_Suneater_Eclipse 			= "Внимание! |cFF0000Eclipse Field|r действует на тебя!"
L.Alerts_MawLorkhaj_Suneater_Eclipse_Other 		= "Внимание! |cFF0000Eclipse Field|r действует на |cFF0000<<!aC:1>>|r!"
L.Alerts_MawLorkhaj_Shattered 					= "Твоя |c595959Броня|r была |cff0000Разбита|r."
L.Alerts_MawLorkhaj_MarkedForDeath 				= "Внимание! |c000055Пантеры|r преследуют тебя!"


--------------------------------
----    Dragonstar Arena    ----
--------------------------------
L.Settings_Dragonstar_Header              		= "Драгонстарская Арена (DSA)"
-- Settings
L.Settings_Dragonstar_General_Taking_Aim        = "Общее: Taking Aim"
L.Settings_Dragonstar_General_Taking_Aim_TT     = "Предупреждает, когда вы становитесь целью способности Taking Aim."
L.Settings_Dragonstar_General_Crystal_Blast     = "Общее: Crystal Blast"
L.Settings_Dragonstar_General_Crystal_Blast_TT  = "Предупреждает, когда вы становитесь целью способности Crystal Blast."
L.Settings_Dragonstar_Arena2_Crushing_Shock     = "Арена 2: Crushing Shock"
L.Settings_Dragonstar_Arena2_Crushing_Shock_TT  = "Предупреждает, когда вы становитесь целью способности Crushing Shock на Ледяной арене."
L.Settings_Dragonstar_Arena6_DrainingShot     	= "Арена 6: Drain Resource"
L.Settings_Dragonstar_Arena6_DrainingShot_TT  	= "Предупреждает, когда вы становитесь целью способности Draining Resource на Босмерской арене."
L.Settings_Dragonstar_Arena7_Unstable_Core      = "Арена 7: Unstable Core (Eclipse)"
L.Settings_Dragonstar_Arena7_Unstable_Core_TT   = "Предупреждает, когда на вас накладывается Unstable Core (Eclipse) боссом Храмовником на Жертвенной арене."
L.Settings_Dragonstar_Arena8_Ice_Charge         = "Арена 8: Ice Charge"
L.Settings_Dragonstar_Arena8_Ice_Charge_TT      = "Предупреждает, когда Ледяной центурион готов применить свою ледяную атаку."
L.Settings_Dragonstar_Arena8_Fire_Charge        = "Арена 8: Fire Charge"
L.Settings_Dragonstar_Arena8_Fire_Charge_TT     = "Предупреждает, когда Огненный центурион готов применить свою огненную атаку."
-- Alerts
L.Alerts_Dragonstar_General_Taking_Aim          = "Ты стал целью |cFF6600Taking Aim|r!"
L.Alerts_Dragonstar_General_Crystal_Blast       = "Ты стал целью |c990099Crystal Blast|r!"
L.Alerts_Dragonstar_Arena2_Crushing_Shock       = "Приближается |c3366EECrushing Shock|r! Блокируй!"
L.Alerts_Dragonstar_Arena6_DrainingShot         = "|c00ff99Draining Resource|r действует на тебя!"
L.Alerts_Dragonstar_Arena6_DrainingShot_Other	= "|c00ff99Draining Resource|r действует на |cFF0000<<!aC:1>>|r."
L.Alerts_Dragonstar_Arena7_Unstable_Core        = "На тебе |cDDDD33Unstable Core|r! Высовободись!"
L.Alerts_Dragonstar_Arena8_Ice_Charge           = "Приближается |c6699FFIce Charge|r на тебя! Прерви или увернись!"
L.Alerts_Dragonstar_Arena8_Ice_Charge_Other     = "|c6699FFIce Charge|r применяется на |cFF0000<<!aC:1>>|r. Прерви!"
L.Alerts_Dragonstar_Arena8_Fire_Charge          = "Приближается |cFF3113Fire Charge|r на тебя! Прерви или увернись!"
L.Alerts_Dragonstar_Arena8_Fire_Charge_Other    = "|c6699FFire Charge|r применяется на |cFF0000<<!aC:1>>|r. Прерви!"


--------------------------------
----       Debugging        ----
--------------------------------
L.Settings_Debug_Header                  		= "Отладка"
L.Settings_Debug                         		= "Включить отладку"
L.Settings_Debug_TT                      		= "Выключает вывод отладочной информации в окно чата"
L.Settings_DebugNotify                   		= "Отладка оповещений"
L.Settings_DebugNotify_TT                		= "Дополнительная отладочная информация для активных оповещений."


--INTERNAL--
for k, v in pairs(L) do
    local string = "RAIDNOTIFIER_" .. string.upper(k)
    ZO_CreateStringId(string, v)
end