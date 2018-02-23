local toolPanel = {}

function toolPanel:Init()
  -- Create the tool list
  self.toolList = vgui.Create("DCategoryList", self)
  self:SetLeft(self.toolList)
  -- Create the tool Info panel
  self.toolList.buttons = {}
  self.toolList.categories = {}
  self.toolList.contentPanels = {}
  self.currentContentPanel = vgui.Create("DPanel", self)
  self:SetRight(self.currentContentPanel)
end

function toolPanel:addCategory(categoryName)
  -- Add a new category to the interface and store it in the table
  self.toolList.categories[categoryName] = self.toolList:Add(categoryName)

  -- Invalidate the layout
  self:InvalidateLayout()

  return self:getCategory(categoryName)
end

function toolPanel:getCategory(categoryName)
  local category = self.toolList.categories[categoryName]

  if category == nil then
    category = self:addCategory(categoryName)
  end

  return category
end

function toolPanel:addTool(tool)
  local category = self:getCategory(tool.category)
  self:createToolContentPanel(tool)
  -- Create a new button
  self.toolList.buttons[tool.id] = category:Add(gel.fw:translate(tool.name))
  self.toolList.buttons[tool.id].DoClick = function()
    -- Change the current content panel
    self:setCurrentContentPanel(tool.id)
    -- Set the user's current tool to the selected tool
    nz.Tool:set(tool.id)
  end
end

function toolPanel:createToolContentPanel(tool)
  local contentPanel = vgui.Create("DPanel", self.currentContentPanel)
  contentPanel:Dock(FILL)
  -- Title
  contentPanel.toolTitle = vgui.Create("DLabel", contentPanel)
  contentPanel.toolTitle:Dock(TOP)
  contentPanel.toolTitle:DockMargin(4, 0, 0, 0)
  contentPanel.toolTitle:SetText(tool.name)
  contentPanel.toolTitle:SetFont("DermaLarge")
  contentPanel.toolTitle:SizeToContents()
  contentPanel.toolTitle:SetTextColor(gel.fw:getColor("black"))
  -- Description
  contentPanel.toolDescription = vgui.Create("DLabel", contentPanel)
  contentPanel.toolDescription:Dock(TOP)
  contentPanel.toolDescription:DockMargin(4, 0, 0, 0)
  contentPanel.toolDescription:SetText(tool.description)
  contentPanel.toolDescription:SetFont("DermaDefault")
  contentPanel.toolDescription:SizeToContents()
  contentPanel.toolDescription:SetTextColor(gel.fw:getColor("black"))

  -- Add it to the content panel list
  self.toolList.contentPanels[tool.id] = contentPanel
end


function toolPanel:hideCurrentContentPanel()
  -- Hide all the content panels
  local contentPanels = self.currentContentPanel:GetChildren()
  for _, panel in pairs(contentPanels) do
    panel:SetVisible(false)
  end
end

function toolPanel:setCurrentContentPanel(panelId)
  self:hideCurrentContentPanel()
  self.toolList.contentPanels[panelId]:SetVisible(true)
end

function toolPanel:populate()
  local toolModel = gel.fw:getModel("Tool")
  for id, tool in pairs(toolModel:all()) do
    self:addTool(tool)
  end
  -- Hide the current panel
  self:hideCurrentContentPanel()
end

vgui.Register("nz_panel_tools", toolPanel, "DHorizontalDivider")
