local moduleName = "Main:Player"

function GM:PlayerInitialSpawn(ply)
  Log(LOG_DEBUG, ply:Nick() .. " is Sending Client Info.", moduleName)

  -- Send the player a full sync
  ply:fullSync()

  -- Since the player hasn't actually spawned yet, we gotta wait a second then set them as a spectator
  timer.Simple(1, function() if ply:IsValid() then ply:setAsSpectator() end end)
end

function GM:PlayerDeathThink(ply)
  if nz.Mode:isCreative() then
    ply:Spawn()
  end
end

local function setPlayerClass(ply)
  if nz.Mode:isCreative() then
    Log(LOG_DEBUG, "Set " .. ply:Nick() .. " to the Creative Class.", moduleName)
    player_manager.SetPlayerClass( ply, "player_create" )
  elseif nz.Mode:isPlay() then
    Log(LOG_DEBUG, "Set " .. ply:Nick() .. " to the Player Class.", moduleName)
    -- player_manager.SetPlayerClass( ply, "player_sandbox" )
  end
end

hook.Add("PlayerSpawn", "nz.Main.setPlayerClass", setPlayerClass)

function GM:PlayerNoClip(ply, desiredState)
  if ply:Alive() and nz.Mode:isCreative() then
    return true
  end
end
