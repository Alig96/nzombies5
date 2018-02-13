local moduleName = "Create:Tool"
local toolClass = {}
toolClass.categories = {}
toolClass.tools = {}

function toolClass:getAllCategories()
  return self.categories
end

function toolClass:getAllTools()
  return self.tools
end

function toolClass:getCategory(id)
  local category = self.categories[id]
  if category then
    return category
  end

  Log(LOG_ERROR, "Could not find Category: " .. id, moduleName)
end

function toolClass:newCategory(id, name, advanced)
  if self.categories[id] then
    Log(LOG_ERROR, "Attempted to register Tool Category: '" .. name .. "' that already exists.", moduleName)
  else
    self.categories[id] = nz.Framework.newToolCategory(id, name, advanced)
    Log(LOG_DEBUG, "Registered Tool Category:" .. name, moduleName)
  end
end

function toolClass:getTool(id)
  local tool = self.tools[id]
  if tool then
    return tool
  end

  Log(LOG_ERROR, "Could not find Tool: " .. id, moduleName)
end

function toolClass:new(id, name, categoryId, description, instructions, shootFunctions, formPanelId)
  -- Get the category
  local category = self:getCategory(categoryId)

  -- Register the tool
  if self.tools[id] then
    Log(LOG_ERROR, "Attempted to register Tool: '" .. name .. "' that already exists.", moduleName)
  else
    self.tools[id] = nz.Framework.newTool(id, name, category, description, instructions, shootFunctions.onLeftClick, shootFunctions.onRightClick, formPanelId)
    Log(LOG_DEBUG, "Registered Tool: " .. name, moduleName)
  end

  -- Return the tool
  return self.tools[id]
end

-- Assign the meta table to the nz global
nz.Create.Tool = setmetatable(toolClass, toolClass)
