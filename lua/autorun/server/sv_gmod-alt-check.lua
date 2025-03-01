-- Alt Checker
-- Developed by: MM (theyarma)
local playerData = {}
local alts = {}

-- Alt Checker and Logger
hook.Add("PlayerInitialSpawn", "PlayerLog", function(ply)
  -- Variables
  local plyName = ply:Nick()
  local sID64 = ply:SteamID64()
  local ip = ply:IPAddress()
  local altFound = false


  -- Checks if the player's SteamID64 is in the table, and logs them in a playerData table.
  if not playerData[sID64] then

    if not ip then ip = 'Cannot Find' end

    local data = {}
    data.IP = ip
    data.NAME = plyName
    playerData[sID64] = data
    print("Player Logged")

  end  
  
-- Checks if players IP matches a logged IP, but the SteamID64 does not, and flags it in a alt table if it does.
  for _, v in pairs(playerData) do
    
    -- If the IP does not match any IP in the playerData list, it moves on to the next.
    if v.IP ~= ip then continue end
    
    -- Logs the alt in a table keyed by IP
    local data = {}
    data.SteamID = sID64
    alts[ip] = data

  end


-- Chat Command
  hook.Add("PlayerSay", "PlayerChat", function(ply, text)

    

    -- Variable Definitions
    local args = string.Explode(" ", text, 2)
    local cmd = args[1]
    local targetIP = args[2]
    
   
  

    -- Checks if the player is an admin, and returns a message if not.   
      if not ply:IsAdmin() then 
        ply:PrintMessage(HUD_PRINTTALK, "[Alt Checker] - You are not an admin!") 
        return 
      end

      -- Checks if the command has valid arguments, and returns a help message if not.
      if cmd == "!alts" then
        if not targetIP or targetIP == "" then
          ply:PrintMessage(HUD_PRINTTALK, "[Alt Checker] - Use the command like this: !alts <IP>")
          return
        end

        -- If the players IP is flagged as a possible alt, it is stored in a seperate table
        local altData = alts[targetIP]
        if altData then
          local altList = {}
          for _, v in pairs(altData) do
            table.insert(altList, alts.SteamID)
          end
          
          -- We concat down here to avoid a error with datatypes.
          local altString = table.concat(altList, ", ")
          ly:PrintMessage(HUD_PRINTTALK, "[Alt Checker] - Alt Detected: " .. altString)
         else
        ply:PrintMessage(HUD_PRINTTALK, "[Alt Checker] - No Alts Detected for: " .. targetIP)
        end
      
      end 
  end)
end)



