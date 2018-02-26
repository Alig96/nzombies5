local entityCreatorTool = {}

entityCreatorTool.id = "tool_area_linker"
entityCreatorTool.name = "#tool_area_linker"
entityCreatorTool.description = "#tool_area_linker_description"
entityCreatorTool.instructions = {
  leftClick = "#tool_area_linker_instructions_left",
  rightClick = "#tool_area_linker_instructions_right",
}

function entityCreatorTool:onLeftClick(trace)
  local toolData = nz.Tool:getToolData()
  local entity = trace.Entity
  if toolData.entity and entity.isLinkable then
    -- Send a request to the server with this entity
    gel.fw:sendRequest("LinkEntity", {requestedEntity = entity, areaEntity = toolData.entity})
  end
end

function entityCreatorTool:onRightClick(trace)
  local entity = trace.Entity
  if entity and entity:GetClass() == "nz_area_link" then
    print("Loaded Area Link to right click")
    nz.Tool:setToolData({entity = entity})
  end
end

-- Register this tool
nz.Tool:new(entityCreatorTool)
