local entityPanel = {}

function entityPanel:Init()
  self:Dock(FILL)

  self.categoriesPanels = {}
end

function entityPanel:createCategory(categoryName)
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

function entityPanel:getCategory(categoryName)
  local category = self.categoriesPanels[categoryName]

  if category == nil then
    category = self:createCategory(categoryName)
  end

  return category
end

function entityPanel:addEntity(entity)
  PrintTable(entity)
  -- Get the category panel
  local tileLayout = self:getCategory(entity.category)
  -- Create a icon
  local entityIcon = vgui.Create("SpawnIcon", tileLayout)
  entityIcon:SetModel(entity.model)
  entityIcon:SetTooltip(entity.PrintName)
  function entityIcon:DoClick()
    -- Simulate a click on the entity creator tool
    local interface = gel.fw:getInterface("CreateMenu")
    local button = interface.panel.rightSheet.sheets["Tools"].toolList.buttons["tool_entity_creator"]
    button:DoClickInternal()
    button:DoClick()

    -- Set this up on the entity creator
    -- Add what ever entity data we want to the data table, for now we dont need anything
    nz.Tool:setToolData({entity = entity.ClassName, data = {
      name = entity.PrintName
    }})
  end

  tileLayout:Add(entityIcon)
end

function entityPanel:populate()
  local allEntities = scripted_ents.GetList()
  for id, entity in pairs(allEntities) do
    if id != "nz_prop" and entity.Base == "nz_editable_entity" then
      self:addEntity(entity.t)
    end
  end
end

vgui.Register("nz_panel_entities", entityPanel, "DColumnSheet")
