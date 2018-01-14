local function setPlayerClass(ply)
  if nz.Mode:isCreative() then
    nz.Debug.Print("info", "[PlayerClass] Set " .. ply:Nick() .. " to the Creative Class.")
    player_manager.SetPlayerClass( ply, "player_create" )
  elseif nz.Mode:isPlay() then
    nz.Debug.Print("info", "[PlayerClass] Set " .. ply:Nick() .. " to the Play Class.")
    //player_manager.SetPlayerClass( ply, "player_sandbox" )
  end
end

hook.Add( "PlayerSpawn", "nz.SetPlayerClass", setPlayerClass )
