function nz.Creative.Spawn:addPlayerSpawner(pos)
  local ent = ents.Create("nz_player_spawner")
  pos.z = pos.z - ent:OBBMaxs().z
  ent:SetPos( pos )
  ent:Spawn()

  Log(LOG_INFO, "Player Spawner placed at: " .. tostring(pos), "Creative:Spawn")

  return ent
end

function nz.Creative.Spawn:removePlayerSpawner(ent)
  if ent:GetClass() == "nz_player_spawner" then
    local posString = tostring(ent:GetPos())
    ent:Remove()
    ent = nil
    Log(LOG_INFO, "Player Spawner removed at: " .. posString, "Creative:Spawn")
    return ent
  end
end
