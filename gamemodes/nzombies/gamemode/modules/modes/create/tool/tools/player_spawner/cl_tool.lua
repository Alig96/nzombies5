local toolInstructions = {
  leftClick = "Add Player Spawner",
  rightClick = "Remove Player Spawner",
}

local shootFunctions = {}
function shootFunctions:onLeftClick(trace)
  if trace.HitPos then
    nz.Framework.Request["CreatePlayerSpawner"]:sendRequest({requestedPosition = trace.HitPos})
  end
end

function shootFunctions:onRightClick(trace)
  if trace.Entity then
    nz.Framework.Request["DeletePlayerSpawner"]:sendRequest({requestedEntity = trace.Entity})
  end
end

nz.Create.Tool:new("player_spawner", "Player Spawner", "spawner", "Allows you to add/remove valid spawn locations for a player.", toolInstructions, shootFunctions)
