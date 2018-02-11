local logModuleName = "Sync"

function nz.Broadcast(syncFunctionKey)
  Log(LOG_INFO, "Broadcasting to all current players: " .. syncFunctionKey, logModuleName)
  if nz.Sync[syncFunctionKey] then
    for _, ply in pairs(player.GetAll()) do
      nz.Sync[syncFunctionKey](ply)
    end
  end
end

-- Loop through and run every sync function registered and send to the player.
function nz.fullSyncPlayer(ply)
  Log(LOG_INFO, "Sending a full sync to: " .. ply:Nick(), logModuleName)
  for syncFunctionKey, _ in pairs(nz.Sync) do
    nz.Sync[syncFunctionKey](ply)
  end
  Log(LOG_INFO, "Finished syncing to: " .. ply:Nick(), logModuleName)
end

-- lua_run nz.fullSyncAll()
function nz.fullSyncAll()
  for _, ply in pairs(player.GetAll()) do
    nz.fullSyncPlayer(ply)
  end
end
