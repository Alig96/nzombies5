function GM:PlayerInitialSpawn(ply)
  Log(LOG_INFO, ply:Nick() .. " is Sending Client Info.")

  -- Send the player a full sync
  --nz.fullSyncPlayer(ply)
  ply:fullSync()

  -- Since the player hasn't actually spawned yet, we gotta wait a second then set them as a spectator
  timer.Simple(1, function() if ply:IsValid() then ply:setAsSpectator() end end)
end

function GM:PlayerDeathThink(ply)
  if nz.Mode:isCreative() then
    ply:Spawn()
  end
end
