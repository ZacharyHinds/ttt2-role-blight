hook.Add("Initialize", "BlightInitStatus", function()
  STATUS:RegisterStatus("blighted_status", {
    hud = Material("vgui/ttt/dynamic/roles/icon_blt.vmt"),
    type = "bad"
  })
end)

hook.Add("TTT2FinishedLoading", "blt_devicon", function() -- addon developer emblame for me ^_^
  AddTTT2AddonDev("76561198049910438")
end)

net.Receive("ttt2_blt_msg", function()
  local msg = net.ReadString()
  EPOP:AddMessage({
    text = LANG.TryTranslation(msg),
    color = BLIGHT.ltcolor}
  )
end)
