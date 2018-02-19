-- Get the tool model
local toolModel = gel.fw:getModel("Tool")

local toolClass = {}
toolClass.current = nil

function toolClass:new(toolObject)
  -- Create a new tool object
  local newTool = toolModel:create(toolObject.id, toolObject.name, toolObject.description, toolObject.instructions, toolObject.onLeftClick, toolObject.onRightClick)
  -- Notify
  Log(LOG_INFO, "Successfully created Tool: " .. newTool.id, "Tool")
  -- Return the finished tool object from the database
  return self:get(toolObject.id)
end

function toolClass:set(id)
  -- Find the tool
  local tool = self:get(id)
  if tool then
    toolClass.current = id
    Log(LOG_INFO, "Set current tool to: " .. gel.fw:translate(tool.name), "Tool")
    -- Get the tool gun out
    RunConsoleCommand("use", "nz_multi_tool")
  end
end

function toolClass:get(id)
  if id == nil then id = self.current end
  if id == nil then return end
  -- Find the tool
  local tool = toolModel:find(id)
  if tool then
    return tool
  end

  Log(LOG_ERROR, "Could not get Tool: " .. id, "Tool")
end

-- Assign this class to the global nz table
nz.Tool = toolClass

-- lua_run_cl nz.Tool:set("tool_player_spawner")