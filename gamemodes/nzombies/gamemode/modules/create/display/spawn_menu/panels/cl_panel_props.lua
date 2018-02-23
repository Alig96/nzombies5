local propPanel = {}

function propPanel:Init()
  self:Dock(FILL)

  self.categoriesPanels = {}
end

function propPanel:createCategory(categoryName)
  self.categoriesPanels[categoryName] = vgui.Create("DTileLayout", self)
  self.categoriesPanels[categoryName]:SetBaseSize(64)
  self.categoriesPanels[categoryName]:Dock(FILL)
  self.categoriesPanels[categoryName]:SetSpaceX(4)
  self.categoriesPanels[categoryName]:SetSpaceY(4)

  -- Add it to the sheet
  self:AddSheet(categoryName, self.categoriesPanels[categoryName], "icon16/cross.png")

  -- Return the panel
  return self.categoriesPanels[categoryName]
end

function propPanel:getCategory(categoryName)
  local category = self.categoriesPanels[categoryName]

  if category == nil then
    category = self:createCategory(categoryName)
  end

  return category
end

function propPanel:addProp(prop)
  -- Get the category panel
  local tileLayout = self:getCategory(prop.category)
  -- Create a icon
  local propIcon = vgui.Create("SpawnIcon", tileLayout)
  propIcon:SetModel(prop.model)
  propIcon:SetTooltip(prop.name)
  function propIcon:DoClick()
    -- Simulate a click on the entity creator tool
    local interface = gel.fw:getInterface("CreateMenu")
    local button = interface.panel.rightSheet.sheets["Tools"].toolList.buttons["tool_entity_creator"]
    button:DoClickInternal()
    button:DoClick()

    -- Set this up on the entity creator
    nz.Tool:setToolData({entity = "nz_prop", data = prop})
  end

  tileLayout:Add(propIcon)
end

function propPanel:populate()
  local propModel = gel.fw:getModel("Prop")
  for id, prop in pairs(propModel:all()) do
    self:addProp(prop)
  end
end

vgui.Register("nz_panel_props", propPanel, "DColumnSheet")
