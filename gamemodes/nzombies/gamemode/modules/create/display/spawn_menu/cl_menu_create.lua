local createMenu = {}

function createMenu:Init()
  self:SetSize(gel.fw:resoloutionScale(1600, 800))
  self:Center()

  self.horizontalDivider = vgui.Create("DHorizontalDivider", self)
  self.horizontalDivider:Dock(FILL)
  self.horizontalDivider:SetLeftWidth(ScrW())
  self.horizontalDivider:SetDividerWidth(6)

  -- Add additonal panels
  self:addLeftPanel()

  self:addRightPanel()
end

function createMenu:addLeftPanel()
  self.leftSheet = vgui.Create("DPropertySheet", self.horizontalDivider)
  self.leftSheet.sheets = {}
  self.horizontalDivider:SetLeft(self.leftSheet)
  self.horizontalDivider:SetLeftMin(800)

  -- Create the Prop Sheet
  self:createPropsPanel()
  -- Create the Entities
  self:createEntitiesPanel()
end

function createMenu:createPropsPanel()
  -- Create the Prop Sheet
  self.leftSheet.sheets["Props"] = vgui.Create("nz_panel_props", self.leftSheet)
  -- Add it to the left panel
  self.leftSheet:AddSheet("Props", self.leftSheet.sheets["Props"], "icon16/lightbulb.png")
end

function createMenu:createEntitiesPanel()
  -- Create the Entities Sheet
  self.leftSheet.sheets["Entities"] = vgui.Create("DPanel", self.leftSheet)
  -- Add it to the left panel
  self.leftSheet:AddSheet("Entities", self.leftSheet.sheets["Entities"], "icon16/script_lightning.png")
end

function createMenu:addRightPanel()
  self.rightSheet = vgui.Create("DPropertySheet", self.horizontalDivider)
  self.rightSheet.sheets = {}
  self.horizontalDivider:SetRight(self.rightSheet)
  self.horizontalDivider:SetRightMin(400)

  -- Create the Tool Sheet
  self:createToolsPanel()
end

function createMenu:createToolsPanel()
  -- Create the Tools Sheet
  self.rightSheet.sheets["Tools"] = vgui.Create("nz_panel_tools", self.rightSheet)
  -- Add it to the right panel
  self.rightSheet:AddSheet("Tools", self.rightSheet.sheets["Tools"], "icon16/wrench.png")
end

-- Register this as an interface
gel.fw:newInterface("CreateMenu", createMenu)
