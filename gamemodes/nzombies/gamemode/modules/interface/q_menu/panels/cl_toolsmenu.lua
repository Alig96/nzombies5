local toolMenuPanel = {}

function toolMenuPanel:Init()
  -- Create the horizontal divider
  self:createHorizontalDivider()
  -- Create the tool list
  self:createToolList()
  -- Create the content panel
  self:createContentPanel()

  -- Testing
  self:addNewCategoryToToolList("spawners", "Spawners")
  self:addNewCategoryToToolList("weapons", "Weapons")

  -- Make a quick panel
  self:addNewItemToToolList("spawners", "nz_player_spawner_tool", "Player Spawner", "nz.PlayerSpawnerTool")

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

function toolMenuPanel:addNewItemToToolList(idOfCategory, idOfItem, textOfItem, contentPanelName)
  local category = self.toolCategoriesButtons[idOfCategory]

  if category then
    local contentPanel = vgui.Create(contentPanelName)
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
      -- we should switch our current tool to this
      self:setupToolGun(idOfItem)
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
end

function toolMenuPanel:setupToolGun(idOfTool)
  -- Switch our current weapon to the tool gun
  RunConsoleCommand( "use", "nz_multi_tool" )
  local toolGun = LocalPlayer():GetWeapon( "nz_multi_tool" )
  toolGun:setCurrentTool(idOfTool)
end

vgui.Register("nz.ToolMenuPanel", toolMenuPanel)
