local playerSpawnerTool = {}

playerSpawnerTool.id = "tool_player_spawner"
playerSpawnerTool.name = "#tool_player_spawner_name"
playerSpawnerTool.description = "#tool_player_spawner_description"
playerSpawnerTool.instructions = {
  leftClick = "#tool_player_spawner_instructions_left",
  rightClick = "#tool_player_spawner_instructions_right",
}

function playerSpawnerTool:onLeftClick(trace)
  if trace.HitPos then
    local requestData = {requestedPosition = trace.HitPos}
    gel.fw:sendRequest("CreatePlayerSpawner", requestData)
  end
end

function playerSpawnerTool:onRightClick(trace)
  if trace.Entity then
    gel.fw:sendRequest("DeletePlayerSpawner", {requestedEntity = trace.Entity})
  end
end

-- Register this tool
nz.Tool:new(playerSpawnerTool)
