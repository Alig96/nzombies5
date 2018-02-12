local toolClassTest = GUnit.Test:new("Modes > Create > Tools")

local function can_create_new_tool()
  nz.Create.Tool:new("player_spawner_test", "Player Spawner", "spawner")
  PrintTable(nz.Create.Tool:getTool("player_spawner_test"))
end

toolClassTest:addSpec("can create a new tool", can_create_new_tool)
