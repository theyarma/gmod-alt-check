-- Alt Checker
-- Developed by: MM (theyarma)
include"autorun/sh_gmod-alt-check.lua" -- NOTE: No need to include this file since Lua uses a global scope.
AddCSLuaFile("vgui/vgui.lua")
local playerData = {} -- Consider using a table keyed by SteamID64 instead of an array; this would allow constant-time lookups.
local alts = {} -- Similarly, a dictionary keyed by IP could improve lookup efficiency in isAltDetected().
-- Adds new players into the database. This resets every time you open the server.
hook.Add("PlayerInitialSpawn", "PlayerLog", function(ply)
  -- Variables
  local plyName = ply:Nick()
  local sID64 = ply:SteamID64()
  local ip = ply:IPAddress()
  local altFound = false
  -- Checks if the player's SteamID64 is in the table, and logs them if they aren't.
  if not playerData[ply:SteamID64()] then
    table.insert(playerData, {plyName, sID64, ip})
    -- SUGGESTION: Instead of inserting into an array, consider storing it like:
    -- playerData[sID64] = {name = plyName, ip = ip}
  end

  -- Detects if an account's IP matches but the SteamID64 does not, flags them as an alt, and stores them in a new table.
  for k, v in pairs(playerData) do
    if v[2] ~= sID64 and v[3] == ip then
      -- NOTE: The concatenation here lacks spaces. Consider: "Warning! " .. ply:Nick() .. " has a duplicate IP..."
      print("Warning!" .. ply .. "has a duplicate IP and has been flagged as an Alt!")
      altFound = true
      table.insert(alts, ip)
    end
  end
end)

local function isAltDetected(ply)
  -- Grabs IP then checks the alt table if we have marked them as an alt.
  local ip = ply:IPAddress()
  -- SUGGESTION: Instead of using table.HasValue (which iterates through the table),
  -- use a table indexed by IP to get constant-time lookup.
  local isAlt = table.HasValue(alts, ip)
  return isAlt
end

-- NOTE: You have a second hook on "PlayerInitialSpawn". This can work but may lead to ordering issues.
-- CONSIDERATION: It might be better to combine both functionalities (logging and alt detection) into one hook.
hook.Add("PlayerInitialSpawn", "AltDetection", function(ply)
  local isAlt = isAltDetected(ply)
  if isAlt then
    print(ply:Nick() .. " has been detected as an alt. Please investigate.")
  else
    print(ply:Nick() .. " is not an alt.")
  end
end)

util.AddNetworkString("CheckerButtonEvent")
net.Receive("CheckerButtonEvent", function(len, ply)
  local recievedData = net.ReadString()
  print(ply:Nick() .. " clicked the button!")
  net.Start("ReceivedData")
  net.WriteString("Server recieved a message from: " .. ply:Nick())
  net.Send(ply)
end)