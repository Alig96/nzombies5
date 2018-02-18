local prototypeInterface = {}

prototypeInterface.id = "BaseInterface"

prototypeInterface.panel = {}
prototypeInterface.hangOpen = false

function prototypeInterface:Open()
  RestoreCursorPosition()

  self.hangOpen = false

  if self.panel:IsVisible() then return end

  self.panel:SetVisible(true)
  self.panel:MakePopup()
  self.panel:SetKeyboardInputEnabled(false)
  self.panel:SetMouseInputEnabled(true)
  self.panel:SetAlpha(255)
end

function prototypeInterface:Close()
  if self.hangOpen then
    self.hangOpen = false
    return
  end

  RememberCursorPosition()

  self.panel:SetKeyboardInputEnabled(false)
  self.panel:SetMouseInputEnabled(false)
  self.panel:SetVisible(false)
end

function prototypeInterface:startKeyFocus(focusedPanel)
  self.focusedPanel = focusedPanel
  self.panel:SetKeyboardInputEnabled(true)
  self.hangOpen = true
end

function prototypeInterface:endKeyFocus(unfocusedPanel)
  if self.focusedPanel != unfocusedPanel then return end
  self.panel:SetKeyboardInputEnabled(false)
end

-- Register this prototype as a model
gel.fw:newModel("Interface", prototypeInterface, {"id"})
