hook.Add("PlayerInitialSpawn", "gel.Internal.Player.onPlayerInitialSpawn", function(ply)
  Log(LOG_DEBUG, ply:Nick() .. " is Sending Client Info.", moduleName)
end)
