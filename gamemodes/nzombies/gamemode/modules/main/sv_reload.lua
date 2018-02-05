function GM:OnReloaded()
  nz.Debug.Print("warning", "Reloading nZombies5...")
  -- Resync all players
  nz.fullSyncAll()
end
