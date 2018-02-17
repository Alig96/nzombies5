local interfaceModel = gel.fw:getModel("Interface")

hook.Add("OnTextEntryGetFocus", "gel.Interface.OnTextEntryGetFocus", function(focusedPanel)
  for _, interface in pairs(interfaceModel:all()) do
    if focusedPanel:HasParent(interface.panel) then
      interface:startKeyFocus(focusedPanel)
    end
  end
end)

hook.Add("OnTextEntryLoseFocus", "gel.Interface.OnTextEntryLoseFocus", function(unfocusedPanel)
  for _, interface in pairs(interfaceModel:all()) do
    if unfocusedPanel:HasParent(interface.panel) then
      interface:endKeyFocus(unfocusedPanel)
    end
  end
end)

hook.Add("GUIMousePressed", "gel.Interface.GUIMousePressed", function()
  for _, interface in pairs(interfaceModel:all()) do
    if !interface.panel:IsVisible() then return end
  end

  return true
end)

hook.Add("GUIMouseReleased", "gel.Interface.GUIMouseReleased", function()
  for _, interface in pairs(interfaceModel:all()) do
    if !interface.panel:IsVisible() then return end
  end

  for _, interface in pairs(interfaceModel:all()) do
    interface:Close()
  end

  return true
end)
