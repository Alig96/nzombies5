function GM:OnReloaded()
  Log(LOG_WARN, "Reloading nZombies5...")
  -- Resync all players
  nz.fullSyncAll()
end
