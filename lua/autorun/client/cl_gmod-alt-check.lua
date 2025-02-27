-- Alt Checker 
-- Developed by: MM (theyarma)
include "autorun/sh_gmod-alt-check.lua"  -- Good: including a shared file for both client and server.
include "vgui/vgui.lua"                  -- Good: including the client-side VGUI file.
include "autorun/sv_gmod-alt-check.lua"  -- Warning: Including a server-side file on the client. This could lead to unexpected behavior or security issues. Remove this file from client-side includes.

net.Receive("ReceivedData", function()
    local message = net.ReadString()
    -- Consider adding error checking to ensure that the received string is valid.
    chat.AddText(Color(105,40,105), "[Server]: ", Color(255,255,255), message)
    -- Suggestion: You might add some logging here for debugging purposes or handle multiple message types.
end)
