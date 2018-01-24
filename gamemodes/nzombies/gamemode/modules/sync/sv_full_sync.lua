-- Loop through and run every sync function registered and send to the player.
function nz.fullSyncPlayer(ply)
  nz.Debug.Print("info", "[Sync] Sending a full sync to: " .. ply:Nick())
  for syncFunctionKey, _ in pairs(nz.Sync) do
    nz.Sync[syncFunctionKey](ply)
  end
  nz.Debug.Print("info", "[Sync] Finished syncing to: " .. ply:Nick())
end

-- lua_run nz.fullSyncAll()
function nz.fullSyncAll()
  for _, ply in pairs(player.GetAll()) do
    nz.fullSyncPlayer(ply)
  end
end
