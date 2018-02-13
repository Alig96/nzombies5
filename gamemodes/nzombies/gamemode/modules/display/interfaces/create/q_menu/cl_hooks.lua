local function createSpawnMenu()
  nz.Interfaces.spawnMenu = vgui.Create("nz.qMenuBasePanel")
end

hook.Add("OnSpawnMenuOpen", "SpawnMenuWhitelist", function()
  if !IsValid(nz.Interfaces.spawnMenu) then
    createSpawnMenu()
  end

  nz.Interfaces.spawnMenu:Open()

  RestoreCursorPosition()
end)


hook.Add("OnSpawnMenuClose", "bfdb", function()
  RememberCursorPosition()
  nz.Interfaces.spawnMenu:Close()
end)
