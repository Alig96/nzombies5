local function createSpawnMenu()
  nz.Interfaces.spawnMenu = vgui.Create("nz.qMenuBasePanel")
end

hook.Add("OnSpawnMenuOpen", "SpawnMenuWhitelist", function()
  if !IsValid(nz.Interfaces.spawnMenu) then
    createSpawnMenu()
  end

  nz.Interfaces.spawnMenu:Open()
end)


hook.Add("OnSpawnMenuClose", "bfdb", function()
  nz.Interfaces.spawnMenu:Close()
end)

hook.Add("OnTextEntryGetFocus", "SpawnMenuKeyboardFocusOn", function(focusedPanel)
  if focusedPanel:HasParent(nz.Interfaces.spawnMenu) then
    nz.Interfaces.spawnMenu:startKeyFocus(focusedPanel)
  end
end)

hook.Add("OnTextEntryLoseFocus", "SpawnMenuKeyboardFocusOff", function(unfocusedPanel)
  if unfocusedPanel:HasParent(nz.Interfaces.spawnMenu) then
    nz.Interfaces.spawnMenu:endKeyFocus(unfocusedPanel)
  end
end)

hook.Add("GUIMousePressed", "SpawnMenuOpenGUIMouseReleased", function()
  if !nz.Interfaces.spawnMenu:IsVisible() then return end

  return true
end)

hook.Add("GUIMouseReleased", "SpawnMenuOpenGUIMouseReleased", function()
  if !nz.Interfaces.spawnMenu:IsVisible() then return end

  nz.Interfaces.spawnMenu:Close()

  return true
end)
