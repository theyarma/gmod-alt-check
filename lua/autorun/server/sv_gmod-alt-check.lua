-- Alt Checker
-- Developed by: MM (theyarma)
local playerData = {} -- Consider using a table keyed by SteamID64 instead of an array; this would allow constant-time lookups.
local alts = {} -- Similarly, a dictionary keyed by IP could improve lookup efficiency in isAltDetected().


hook.Add("PlayerInitialSpawn", "PlayerLog", function(ply)
  -- Variables
  local plyName = ply:Nick()
  local sID64 = ply:SteamID64()
  local ip = ply:IPAddress()
  local altFound = false
  
  -- Checks if the player's SteamID64 is in the table, and logs them if they aren't.
  if not playerData[sID64] then

    if not ip then ip = 'Cannot Find' end

    local data = {}
    data.IP = ip
    data.NAME = plyName
    playerData[sID64] = data

  end  
  
  for _, v in pairs(playerData) do
    
    if v.IP ~= ip then continue end -- I like

    local data = {}
    data.SteamID = sID64
    alts[ip] = data
  end
end)