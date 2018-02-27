local entityRemoverTool = {}

entityRemoverTool.id = "tool_entity_remover"
entityRemoverTool.name = "#tool_entity_remover"
entityRemoverTool.description = "#tool_entity_remover_description"
entityRemoverTool.instructions = {
  leftClick = "#tool_entity_remover_instructions_left",
  rightClick = "tool_entity_remover_instructions_right",
}

function entityRemoverTool:onLeftClick(trace)
  local entity = trace.Entity
  if entity then
    -- Send an update
    gel.fw:sendRequest("RemoveEntity", {requestedEntity = entity})
  end
end

function entityRemoverTool:onRightClick(trace)

end

-- Register this tool
nz.Tool:new(entityRemoverTool)
