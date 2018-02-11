function nz.Framework.fullSyncAllPlayers()
  for _, ply in pairs(player.GetAll()) do
    ply:fullSync()
  end
end
