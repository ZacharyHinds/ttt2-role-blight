L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[BLIGHT.name] = "Blight"
L["info_popup_" .. BLIGHT.name] = [[You are a Blight! Infect whoever kills you!]]
L["body_found_" .. BLIGHT.abbr] = "They were a Blight!"
L["search_role_" .. BLIGHT.abbr] = "This person was a Blight!"
L["target_" .. BLIGHT.name] = "Blight"
L["ttt2_desc_" .. BLIGHT.name] = [[The Blight is a traitor who infects the person who kills them!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_blt_sick"] = "You feel sick"
L["ttt2_blt_cured"] = "You feel much better"

-- EVENT STRINGS
L["title_blt_sick"] = "A Blight was killed"
L["desc_blt_sick"] = "{nick} was blighted."
L["title_blt_cure"] = "A player's blight was cured"
L["desc_blt_cure"] = "{nick} recovered from their blight."
