-- Prevent respawning with the base gamemode
function GM:PlayerDeathThink(ply)
  if nz.Mode:isCreate() then
    ply:Spawn()
  end
end

function GM:PlayerInitialSpawn(ply)
  -- Since the player hasn't actually spawned yet, we gotta wait a second then set them as a spectator (by killing them)
  timer.Simple(1, function() if ply:IsValid() then ply:KillSilent() end end)
end
