local function setPlayerClass(ply)
  if nz.Mode:isCreative() then
    if player_manager.GetPlayerClass(ply) != "player_create" then
      nz.Debug.Print("info", "[PlayerClass] Set " .. ply:Nick() .. " to the Creative Class.")
      player_manager.SetPlayerClass(ply, "player_create")
    end
  elseif nz.Mode:isPlay() then
    -- placeholder
  end
end

hook.Add( "PlayerSpawn", "nz.SetPlayerClass", setPlayerClass )
