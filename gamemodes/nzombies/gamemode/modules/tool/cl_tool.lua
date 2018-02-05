Tool = {}
Tool.__index = Tool

Tool.Id = "nz_basic_tool"
Tool.Name = "Basic Tool"
Tool.Description = "Left Click: Print the Trace.\nRight Click: Print the trace."

Tool.categoryId = "spawners"
Tool.contentPanelName = "nz.PlayerSpawnerTool"

function Tool:leftClick(self, trace)
  print("Left Click Default:")
  PrintTable(trace)
end

function Tool:rightClick(self, trace)
  print("Right Click Default:")
  PrintTable(trace)
end

function Tool:new(idOfTool, nameOfTool, descriptionOfTool, categoryId, contentPanelName, leftClickFunction, rightClickFunction)
    local newTool = {
      Id = idOfTool or self.Id,
      Name = nameOfTool or self.Name,
      Description = descriptionOfTool or self.Description,

      categoryId = categoryId or self.categoryId,
      contentPanelName = contentPanelName or self.contentPanelName,

      leftClick = leftClickFunction or self.leftClick,
      rightClick = rightClickFunction or self.rightClick,
    }

    -- Add it to the listener
    self:addToListener(newTool)

    return newTool
  end

function Tool:addToListener(toolData)
  local id = toolData["Id"]
  if id then
    nz.Tools[id] = toolData
    nz.Debug.Print("success", "[Tool:Tools] Added tool: " .. toolData["Name"])
  end
end

nz.Tool = setmetatable( Tool, { __call = Tool.new } )
