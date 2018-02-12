local toolInstructions = {
  leftClick = "Add Player Spawner",
  rightClick = "Remove Player Spawner",
}

local toolFunctions = {}
function toolFunctions.onLeftClick(trace)
  print("Hey it worked!")
end

function toolFunctions.onRightClick(trace)
  print("Hey it worked!")
end

nz.Create.Tool:new("player_spawner", "Player Spawner", "spawner", "Allows you to add/remove valid spawn locations for a player.", toolInstructions)
