util.AddNetworkString("ttt2_blt_msg")

local function resetBlight()
  local plys = player.GetAll()
  for i = 1, #plys do
    local ply = plys[i]
    ply:SetNWBool("isBlighted", false)
    ply.blightTime = nil
    ply.blightPly = nil
  end
end

hook.Add("TTTEndRound", "resetBlight", resetBlight)
hook.Add("TTTPrepRound", "resetBlight", resetBlight)
hook.Add("TTTBeginRound", "resetBlight", resetBlight)

local function FindBlightPly()
  local plys = player.GetAll()
  for i = 1, #plys do
    if plys[i]:GetSubRole() == ROLE_BLIGHT then return plys[i] end
  end
end

hook.Add("Think", "BlightThink", function()
  if GetRoundState() ~= ROUND_ACTIVE then return end
  local plys = util.GetAlivePlayers()
  for i = 1, #plys do
    local ply = plys[i]
    if not ply:GetNWBool("isBlighted") then continue end
    local blt_ply
    if ply.blightPly then
      blt_ply = player.GetBySteamID(ply.blightPly)
    else
      blt_ply = FindBlightPly()
    end

    local blight_delay = GetConVar("ttt2_blt_delay"):GetInt()
    local blight_min = GetConVar("ttt2_blt_min"):GetInt()
    local blight_heal_cure = GetConVar("ttt2_blt_heal_cure"):GetBool()
    if not ply.blightTime then ply.blightTime = CurTime() + blight_delay end

    if ply.blightTime <= CurTime() then
      local blight_dmg = GetConVar("ttt2_blt_dmg"):GetInt()
      if ply:Health() - blight_dmg < blight_min then
        blight_dmg = ply:Health() - blight_min
      end
      if ply:Health() > ply.health_check_blight and blight_heal_cure then
        -- print("[Blight] " .. ply:Health() - ply.health_check_blight)
        blight_dmg = 0
      end
      local dmginfo = DamageInfo()
      dmginfo:SetDamage(blight_dmg)
      dmginfo:SetDamageType(DMG_RADIATION)
      dmginfo:SetAttacker(blt_ply)
      ply:TakeDamageInfo(dmginfo)
      -- print("[Blight] " .. ply.health_check_blight)
      if ply:Health() <= blight_min or (ply:Health() > ply.health_check_blight and blight_heal_cure) then
        ply:SetNWBool("isBlighted", false)
        ply.blightTime = nil
        ply.blightPly = nil
        STATUS:RemoveStatus(ply, "blighted_status")
        net.Start("ttt2_blt_msg")
        net.WriteString("ttt2_blt_cured")
        net.Send(ply)
      else
        ply.health_check_blight = ply:Health()
        ply.blightTime = CurTime() + blight_delay
      end
    end
  end
end)

hook.Add("TTTPlayerUsedHealthStation", "BlightHealthStation", function(ply)
  if ply:GetNWBool("isBlighted") and GetConVar("ttt2_blt_healstation_cure"):GetBool() then
    ply:SetNWBool("isBlighted", false)
    ply.blightTime = nil
    ply.blightPly = nil
    STATUS:RemoveStatus(ply, "blighted_status")
    net.Start("ttt2_blt_msg")
    net.WriteString("ttt2_blt_cured")
    net.Send(ply)
  end
end)

hook.Add("TTT2PostPlayerDeath", "BlightKilled", function(ply, _, attacker)
  if GetRoundState() ~= ROUND_ACTIVE then return end
  if not IsValid(ply) or not IsValid(attacker) or not attacker:IsPlayer() then return end
  if ply:GetSubRole() ~= ROLE_BLIGHT then return end
  if SpecDM and (ply.IsGhost and ply:IsGhost() or (attacker.IsGhost and attacker:IsGhost())) then return end
  attacker:SetNWBool("isBlighted", true)
  attacker.blightTime = CurTime() + GetConVar("ttt2_blt_delay"):GetInt()
  attacker.blightPly = ply:SteamID()
  attacker.health_check_blight = attacker:Health()
  -- print("[Blight] " .. attacker.health_check_blight)
  STATUS:AddStatus(attacker, "blighted_status")
  net.Start("ttt2_blt_msg")
  net.WriteString("ttt2_blt_sick")
  net.Send(attacker)
end)
