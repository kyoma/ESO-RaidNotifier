local MY_MODULE_NAME = "Kyoma"
local MY_MODULE_VERSION = 4

local LCC = LibStub('LibCustomTitlesRN')
if not LCC then return end

local MY_MODULE = LCC:RegisterModule(MY_MODULE_NAME, MY_MODULE_VERSION)
if not MY_MODULE then return end

--                      Account           Character  Override    English                                German                                  French                                        Extra (e.g. color, hidden)
MY_MODULE:RegisterTitle("@Kyoma",           nil,       494,     {en = "Master Hoarder",                 de = "Meisterhamsterer"                                                         })
MY_MODULE:RegisterTitle("@Kyoma",           nil,       111,     {en = "Resto-in-Disguise"                                                                                               },    {color="#FF5FF5"})
MY_MODULE:RegisterTitle("@Stillian",        nil,      1391,     {en = "Fiery Soul"                                                                                                      })
MY_MODULE:RegisterTitle("@Zantaria",        nil,       627,     {en = "Exploiter"                                                                                                       })
MY_MODULE:RegisterTitle("@BlueMoon270",     nil,      1391,     {en = "Xanti's Mistress"                                                                                                })
MY_MODULE:RegisterTitle("@KisoValley",      nil,        92,     {en = "Decent"                                                                                                          })
MY_MODULE:RegisterTitle("@SloppyChef",      nil,     false,     {en = "Grote Vriendelijke Reus"                                                                                         })
MY_MODULE:RegisterTitle("@sp_korshun",      nil,      1444,     {en = "Achievement Hunter"                                                                                              })
MY_MODULE:RegisterTitle("@MMasing",         nil,        92,     {en = "Queen of Healing"                                                                                                },    {color={"#2DCAED", "#EFC509"}})
