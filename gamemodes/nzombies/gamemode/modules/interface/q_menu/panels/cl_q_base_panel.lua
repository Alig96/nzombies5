local qMenuBasePanel = {}

function qMenuBasePanel:Init()
  self:SetSize(500, 300)
  self:Center()

  -- Add additonal panels
  self:addBaseSheetPanel()
  self:createToolsPanel()
end

function qMenuBasePanel:createToolsPanel()
  local toolMenuPanel = vgui.Create("nz.ToolMenuPanel", self)
  -- Any additional properties

  self:addSheet("Tools", toolMenuPanel)
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

function qMenuBasePanel:Open()
  self:MakePopup()
  self:SetVisible(true)
  self:SetMouseInputEnabled(true)
end

function qMenuBasePanel:Close()
  self:SetVisible(false)
  self:SetMouseInputEnabled(false)
end

vgui.Register("nz.qMenuBasePanel", qMenuBasePanel)
