local entityCreatorTool = {}

entityCreatorTool.id = "tool_entity_creator"
entityCreatorTool.name = "#tool_entity_creator"
entityCreatorTool.description = "#tool_entity_creator_description"
entityCreatorTool.instructions = {
  leftClick = "#tool_entity_creator_instructions_left",
  rightClick = "tool_entity_creator_instructions_right",
}

function entityCreatorTool:onLeftClick(trace)
  local toolData = nz.Tool:getToolData()
  if toolData.id then
    -- Send an update
    gel.fw:sendRequest("CreateEntity", {requestedPosition = trace.HitPos, requestedEntity = toolData.entity, entityData = toolData.data})
  end
end

function entityCreatorTool:onRightClick(trace)

end

-- Register this tool
nz.Tool:new(entityCreatorTool)
