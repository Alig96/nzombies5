function nz.Create.Spawn:addPlayerSpawner(pos)
  local ent = ents.Create("nz_player_spawner")
  pos.z = pos.z - ent:OBBMaxs().z
  ent:SetPos( pos )
  ent:Spawn()

  Log(LOG_INFO, "Player Spawner placed at: " .. tostring(pos), "Create:Spawn")

  return ent
end

function nz.Create.Spawn:removePlayerSpawner(ent)
  if ent:GetClass() == "nz_player_spawner" then
    local posString = tostring(ent:GetPos())
    ent:Remove()
    ent = nil
    Log(LOG_INFO, "Player Spawner removed at: " .. posString, "Create:Spawn")
    return ent
  else
    Log(LOG_ERROR, "Cannot remove entity because it is not a valid Player Spawner Object", "Create:Spawn")
  end
end
