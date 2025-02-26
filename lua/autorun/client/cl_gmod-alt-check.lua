-- Alt Checker 
-- Developed by: MM (theyarma)
include "autorun/sh_gmod-alt-check.lua"
include "vgui/vgui.lua"
include "autorun/sv_gmod-alt-check.lua"

net.Receive("ReceivedData", function()

    local message = net.ReadString()
    chat.AddText(Color(105,40,105), "[Server]: ", Color(255,255,255), message)

end)

