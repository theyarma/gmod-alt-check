-- Alt Checker 
-- Developed by: MM (theyarma)
include "autorun/sh_gmod-alt-check.lua"

local playerData = {}

hook.Add("PlayerInitialSpawn", "PlayerLog", function(ply) 
-- Assume there is a playerIsNew variable
  if playerIsNew then
    local steamID = ply:SteamID64()
    local ip = ply:GetIPAddress()
    table.insert(playerData, {steamID, ip})
  end

end)

