hook.Add("PlayerInitialSpawn", "gel.Internal.Sync.onPlayerInitialSpawn", function(ply)
  -- Send the player a full sync
  ply:sync()
end)

hook.Add("OnReloaded", "gel.Internal.Sync.onReload", function()
  gel.Internal.Sync:resync()
end)
