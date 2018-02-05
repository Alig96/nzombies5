local function createSpawnMenu()
  nz.mainPanel = vgui.Create("nz.qMenuBasePanel")
end

hook.Add( "OnSpawnMenuOpen", "SpawnMenuWhitelist", function()
  if !IsValid(nz.mainPanel) then
    createSpawnMenu()
  end

  nz.mainPanel:Open()

  RestoreCursorPosition()
end )


hook.Add( "OnSpawnMenuClose", "bfdb", function()
  RememberCursorPosition()
  nz.mainPanel:Close()
end )
