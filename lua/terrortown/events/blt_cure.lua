if CLIENT then
    EVENT.title = "title_blt_cure"
    EVENT.icon = Material("vgui/ttt/dynamic/roles/icon_blt.vmt")

    function EVENT:GetText()
        return {
            {
                string = "desc_blt_cure",
                params = {
                    nick = self.event.nick
                }
            }
        }
    end
end

if SERVER then
    function EVENT:Trigger(ply)
        return self:Add({
            nick = ply:Nick()
        })
    end
end

function EVENT:Serialize()
    return self.event.nick .. " cured their blight."
end