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
    print("Player Logged")

  end  
  
  for _, v in pairs(playerData) do
    
    if v.IP ~= ip then continue end

    local data = {}
    data.SteamID = sID64
    alts[ip] = data


  end


  -- Chat Command

  hook.Add("PlayerSay", "PlayerChat", function(ply, text)
    
    -- Variable Definitions
    local args = string.Explode(" ", text, 2)
    local targetIP = args[2]
    local alts = alts[targetIP] or {}
    alts = table.concat(alts, ", ")

    -- Checks if the player is an admin.     
      if not ply:IsAdmin() then 
        ply:PrintMessage(HUD_PRINTTALK, "You are not an admin!") 
        return 
      end
      
      -- Prints out response based on alts table search.
      if text == "!alts " and table.HasValue(alts, targetIP) then
        ply:PrintMessage(HUD_PRINTTALK, "Alt Detected: " .. alts)     
      else
        print("No alt for".. alts)
        ply:PrintMessage(HUD_PRINTTALK, "No Alts Detected for: " .. targetIP)  
      end 
  
  end)

end)