function GM:PlayerInitialSpawn( ply )
  Log(LOG_INFO, ply:Nick() .. " is Sending Client Info.")

  -- Send the player a full sync
  nz.fullSyncPlayer(ply)

  -- As soon as they spawn, set them to a roaming spectator
  ply:setAsSpectator()

  -- Since the player hasn't actually spawned yet, we gotta kill and cycle their spectator mode
  timer.Simple(1, function () if ply:IsValid() then ply:KillSilent() ply:cycleSpectateMode() end end)
end

function GM:PlayerDeathThink(ply)
  if ply:isSpectator() then
    if ply:KeyPressed( IN_ATTACK ) then
      ply:cycleSpectatePlayer()
    elseif ply:KeyPressed( IN_ATTACK2 ) then
      ply:cycleSpectateMode()
    end
  end

  if nz.Mode:isCreative() then
    ply:Spawn()
  end
end
