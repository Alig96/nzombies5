local createMenu = {}

function createMenu:Init()
  self:SetSize(gel.fw:resoloutionScale(500, 300))
  self:Center()

  -- Add additonal panels
  self:addBaseSheetPanel()
  self:createToolsPanel()
end

function createMenu:addBaseSheetPanel()
  self.baseSheet = vgui.Create("DPropertySheet", self)
  self.baseSheet:Dock(FILL)

  self.basicSheets = {}
end

function createMenu:addSheet(idOfSheet, vGuiPanel)
  self.basicSheets[idOfSheet] = vGuiPanel
  self.baseSheet:AddSheet(idOfSheet, self.basicSheets[idOfSheet], "icon16/bullet_wrench.png")
end

function createMenu:createToolsPanel()
  self.toolsPanel = vgui.Create("Panel", self)

  self.toolsPanel.form = gel.fw:newForm(self.toolsPanel, {
    {
      categoryId = "Category",
      id = "genericAtrribute",
      name = "Generic Atrribute",
      type = "Generic",
      defaultValue = "Test",
    },
    {
      categoryId = "New Cat",
      id = "genericAtrribute2",
      name = "Generic Atrribute2",
      type = "Generic",
      defaultValue = "1",
    },
  })

  -- Any additional properties
  self:addSheet("Tools", self.toolsPanel)
end

-- Register this as an interface
gel.fw:newInterface("CreateMenu", createMenu)
