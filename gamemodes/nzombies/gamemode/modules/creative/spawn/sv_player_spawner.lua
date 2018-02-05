function nz.Creative.Spawn:addPlayerSpawner(pos)
  local ent = ents.Create("nz_player_spawner")
  pos.z = pos.z - ent:OBBMaxs().z
  ent:SetPos( pos )
  ent:Spawn()

  nz.Debug.Print("success", "[Creative:Spawn] Player Spawner placed at: " .. tostring(pos))

  return ent
end

function nz.Creative.Spawn:removePlayerSpawner(ent)
  if ent:GetClass() == "nz_player_spawner" then
    local posString = tostring(ent:GetPos())
    ent:Remove()
    ent = nil
    nz.Debug.Print("success", "[Creative:Spawn] Player Spawner removed at: " .. posString)
    return ent
  end
end
