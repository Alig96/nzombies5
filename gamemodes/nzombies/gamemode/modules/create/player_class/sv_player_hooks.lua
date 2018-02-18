local function setPlayerClass(ply)
  if nz.Mode:isCreate() then
    Log(LOG_DEBUG, "Set " .. ply:Nick() .. " to the Creative Class.", "Create:Player Class")
    player_manager.SetPlayerClass(ply, "player_create")
  end
end

hook.Add("PlayerSpawn", "nz.Create.setPlayerClass", setPlayerClass)

function GM:PlayerNoClip(ply, desiredState)
  if ply:Alive() and nz.Mode:isCreate() then
    return true
  end
end
