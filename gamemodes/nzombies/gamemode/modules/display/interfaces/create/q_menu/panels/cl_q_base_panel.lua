local qMenuBasePanel = {}

function qMenuBasePanel:Init()
  self:SetSize(500, 300)
  self:Center()

  self.hangOpen = false

  -- Add additonal panels
  self:addBaseSheetPanel()
  self:createToolsPanel()

  self:SetMouseInputEnabled(true)
  self:Close()
end

function qMenuBasePanel:addBaseSheetPanel()
  self.baseSheet = vgui.Create("DPropertySheet", self)
  self.baseSheet:Dock(FILL)

  self.basicSheets = {}
end

function qMenuBasePanel:addSheet(idOfSheet, vGuiPanel)
  self.basicSheets[idOfSheet] = vGuiPanel
  self.baseSheet:AddSheet(idOfSheet, self.basicSheets[idOfSheet], "icon16/bullet_wrench.png")
end

function qMenuBasePanel:createToolsPanel()
  self.toolsPanel = vgui.Create("nz.ToolMenuPanel", self)
  -- Any additional properties

  self:addSheet("Tools", self.toolsPanel)
end

function qMenuBasePanel:startKeyFocus(focusedPanel)
  self.focusedPanel = focusedPanel
  self:SetKeyboardInputEnabled(true)
  self.hangOpen = true
end

function qMenuBasePanel:endKeyFocus(unfocusedPanel)
  if self.focusedPanel != unfocusedPanel then return end
  self:SetKeyboardInputEnabled(false)
end

function qMenuBasePanel:Open()
  RestoreCursorPosition()

  self.hangOpen = false

  if self:IsVisible() then return end

  self:MakePopup()
  self:SetVisible(true)
  self:SetKeyboardInputEnabled(false)
  self:SetMouseInputEnabled(true)
  self:SetAlpha(255)
end

function qMenuBasePanel:Close()
  if self.hangOpen then
    self.hangOpen = false
    return
  end

  RememberCursorPosition()

  self:SetKeyboardInputEnabled(false)
  self:SetMouseInputEnabled(false)
  self:SetVisible(false)
end

vgui.Register("nz.qMenuBasePanel", qMenuBasePanel, "EditablePanel")
