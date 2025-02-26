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

  -- Checks if the players SteamID64 is in the table, and logs them if they arent. It will then print the table.
  if not playerData[ply:SteamID64()] then  
    table.insert(playerData, {plyName, sID64, ip})
    PrintTable(playerData)
  else
    print("Welcome "..plyName.." back to the server!")
    PrintTable(playerData)
  
    local altFound = false
    for k, v in ipairs(playerData) do    
      if v[2] ~= sID64 and v[3] == ip then
        print("Warning!"..ply.."has a duplicate IP and has been flagged as an Alt!")
        altFound = true
        table.insert(alts, ip)
      end
    end
    

    -- Prints the result of the for loop above.
    if altFound then
      print("Alt Detected")
    else
      print("No Alt Detected")
    end
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