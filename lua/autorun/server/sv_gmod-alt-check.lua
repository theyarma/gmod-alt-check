-- Alt Checker 
-- Developed by: MM (theyarma)
include "autorun/sh_gmod-alt-check.lua"

local playerData = {}
local alts = {}


-- Adds new players into the database. This resets every time you open the server.  
hook.Add("PlayerInitialSpawn", "PlayerLog", function(ply) 

  --Variables
  local plyName = ply:Nick()
  local sID64 = ply:SteamID64()
  local ip = ply:IPAddress()
  local altFound = false

  -- Checks if the players SteamID64 is in the table, and logs them if they arent.
  if not playerData[ply:SteamID64()] then  
    table.insert(playerData, {plyName, sID64, ip})
  
  else
    
    -- detects if an accounts IP matches but steamID64 does not and flags them as an alt, and stores them in a new table
    
  
    for k, v in pairs(playerData) do    
      if v[2] ~= sID64 and v[3] == ip then
        print("Warning!"..ply.."has a duplicate IP and has been flagged as an Alt!")
        altFound = true
        table.insert(alts, ip)
      end
    end
  end
  
  if altFound then
    print("Alt found!")
  else
    print("No alts found!")
  end

end)




local function isAltDetected(ply)

  -- Grabs IP then checks alt table if we have marked them as an alt.
  local ip = ply:IPAddress()
  local isAlt = table.HasValue(alts, ip)
  return isAlt

end

hook.Add("PlayerInitialSpawn", "AltDetection", function()


end)