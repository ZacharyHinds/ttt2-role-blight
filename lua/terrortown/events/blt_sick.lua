EVENT.base = "kill"

if CLIENT then
    EVENT.title = "title_blt_sick"
    EVENT.icon = Material("vgui/ttt/dynamic/roles/icon_blt.vmt")

    function EVENT:GetText()
        local killText = self.BaseClass.GetText(self)

        killText[#killText + 1] = {
            string = "desc_blt_sick",
            params = {
                nick = self.event.attacker.nick
            }
        }

        return killText
    end
end

if SERVER then
    function EVENT:Trigger(victim, attacker, dmgInfo)

        victim.wasBlightDeath = true

        return self.BaseClass.Trigger(self, victim, attacker, dmgInfo)
    end
end

hook.Add("TTT2OnTriggeredEvent", "cancel_blight_kill_event", function(type, eventData)
    if type ~= EVENT_KILL then return end

    local ply = player.GetBySteamID64(eventData.victim.sid64)

    if not IsValid(ply) or not ply.wasBlightDeath then return end

    ply.wasBlightDeath = nil 

    return false
end)