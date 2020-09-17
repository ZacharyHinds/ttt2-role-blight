CreateConVar("ttt2_blt_dmg", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_blt_kill", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_blt_delay", "3", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_blt_healstation_cure", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_blt_min", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_blight_dynamic_convars", function(tbl)
  tbl[ROLE_BLIGHT] = tbl[ROLE_BLIGHT] or {}

  table.insert(tbl[ROLE_BLIGHT], {
    cvar = "ttt2_blt_healstation_cure",
    checkbox = true,
    desc = "ttt2_blt_healstation_cure (def. 1)"
  })

  table.insert(tbl[ROLE_BLIGHT], {
    cvar = "ttt2_blt_delay",
    slider = true,
    min = 0,
    max = 100,
    desc = "ttt2_blt_delay (def. 3)"
  })

  table.insert(tbl[ROLE_BLIGHT], {
    cvar = "ttt2_blt_min",
    slider = true,
    min = 1,
    max = 100,
    desc = "ttt2_blt_min (def. 1)"
  })

  table.insert(tbl[ROLE_BLIGHT], {
    cvar = "ttt2_blt_dmg",
    slider = true,
    min = 1,
    max = 20,
    desc = "ttt2_blt_dmg (def. 5)"
  })
end)
