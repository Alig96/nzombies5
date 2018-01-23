function nz.Creative.Spawn:addPlayerSpawner(pos)
  local ent = ents.Create("nz_player_spawn")
  pos.z = pos.z - ent:OBBMaxs().z
  ent:SetPos( pos )
  ent:Spawn()

  nz.Debug.Print("success", "[Creative:Spawn] Player Spawner placed at: " .. tostring(pos))

  return ent
end

function nz.Creative.Spawn:removePlayerSpawner(ent)
  if ent:GetClass() == "nz_player_spawn" then
    nz.Debug.Print("success", "[Creative:Spawn] Player Spawner removed at: " .. tostring(ent:GetPos()))
    ent:Remove()
  end
end
