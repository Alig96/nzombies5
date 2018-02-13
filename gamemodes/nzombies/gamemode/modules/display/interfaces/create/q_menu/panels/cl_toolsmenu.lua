local toolMenuPanel = {}

toolMenuPanel.currentContentPanelId = ""

function toolMenuPanel:Init()
  -- Create the horizontal divider
  self:createHorizontalDivider()
  -- Create the tool list
  self:createToolList()
  -- Create the content panel
  self:createContentPanel()

  -- Get all our tool's categories and add them to the list
  local toolCategories = nz.Create.Tool:getAllCategories()
  for _, category in pairs(toolCategories) do
    self:addNewCategoryToToolList(category.id, category.name)
  end

  -- Get all our tools and add them to the list
  local tools = nz.Create.Tool:getAllTools()
  for _, tool in pairs(tools) do
    -- Make a new entry in the tool list for the tool
    self:addNewItemToToolList(tool.category.id, tool.id, tool.name, tool.formPanelId)
  end

  -- After all is added
  self:hideCurrentContentPanel()
end

function toolMenuPanel:createHorizontalDivider()
  self.horizontalDivider = vgui.Create("DHorizontalDivider", self)
  self.horizontalDivider:Dock(FILL)
  self.horizontalDivider:SetLeftWidth(130)
  self.horizontalDivider:SetLeftMin(130)
  self.horizontalDivider:SetRightMin(260)

  self.horizontalDivider:SetDividerWidth(20)
end

function toolMenuPanel:createToolList()
  -- Create a panel
  self.leftContainer = vgui.Create("DPanel", self.horizontalDivider)

  -- Create the tool list
  self.toolList = vgui.Create("DCategoryList", self.leftContainer)
  self.toolList:SetWidth(130)
  self.toolList:Dock(FILL)

  -- Create a table to hold all the vGui items
  self.toolItemButtons = {}
  self.toolCategoriesButtons = {}

  -- Put the container on the right of the divider
  self.horizontalDivider:SetLeft(self.leftContainer)
end

function toolMenuPanel:createContentPanel()
  -- Create a panel
  self.rightContainer = vgui.Create("DPanel", self.horizontalDivider)

  -- Create the content panel
  self.contentPanel = vgui.Create("DPanel", self.rightContainer)
  self.contentPanel:Dock(FILL)

  -- Create the table that will hold all content panels
  self.toolContentPanels = {}

  -- Put the container on the right of the divider
  self.horizontalDivider:SetRight(self.rightContainer)
end

function toolMenuPanel:addNewCategoryToToolList(idOfCategory, nameOfCategory)
  -- Create a table for the tool panels in the category
  self.toolContentPanels[idOfCategory] = {}

  -- Add a new category to the interface and store it in the table
  self.toolCategoriesButtons[idOfCategory] = self.toolList:Add(nameOfCategory)
  self.toolItemButtons[idOfCategory] = {}

  -- Invalidate the layout
  self:InvalidateLayout()
end

function toolMenuPanel:addNewItemToToolList(idOfCategory, idOfItem, textOfItem, formPanelId)
  local category = self.toolCategoriesButtons[idOfCategory]

  if category then
    local contentPanel = vgui.Create(formPanelId)
    -- Dock
    contentPanel:Dock(FILL)
    -- Set the content panel's parent to the main content panel
    contentPanel:SetParent(self.contentPanel)
    -- Add the content panel to the table of content panels
    self.toolContentPanels[idOfItem] = contentPanel

    -- Create a new button
    local button = category:Add(textOfItem)
    button.DoClick = function()
      -- When we press the item in the list
      -- Change the content panel to the id of the button that was pressed
      self:hideCurrentContentPanel()
      self:setActiveItem(idOfItem)

      -- Update the tool gun
      nz.Create.multiTool:setCurrentTool(idOfItem)
    end

    self.toolItemButtons[idOfCategory] = button
  end
end

function toolMenuPanel:hideCurrentContentPanel()
  -- Hide all the previous content panel items
  local contentPanelChildren = self.contentPanel:GetChildren()
  for _, panel in pairs(contentPanelChildren) do
    panel:SetVisible(false)
  end
end

function toolMenuPanel:setActiveItem(idOfItem)
  -- Hide all the previous content panel items
  self.toolContentPanels[idOfItem]:SetVisible(true)
  self.currentContentPanelId = idOfItem
end

function toolMenuPanel:getActiveContentPanelFormData()
  -- Get the active content panel's form data
  return self.toolContentPanels[self.currentContentPanelId]:getFormData()
end

vgui.Register("nz.ToolMenuPanel", toolMenuPanel)
