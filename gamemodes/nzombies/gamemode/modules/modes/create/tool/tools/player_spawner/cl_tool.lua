local toolInstructions = {
  leftClick = "Add Player Spawner",
  rightClick = "Remove Player Spawner",
}

local shootFunctions = {}
function shootFunctions:onLeftClick(trace)
  -- Get the current tool's form data
  local formData = nz.Interfaces.spawnMenu.toolsPanel:getActiveContentPanelFormData()
  if trace.HitPos and formData then
    local requestData = {requestedPosition = trace.HitPos}
    PrintTable(formData) -- Just to show it works, remove this from player spawner since it doesn't require any additional user input
    nz.Framework.Request["CreatePlayerSpawner"]:sendRequest(requestData)
  end
end

function shootFunctions:onRightClick(trace)
  if trace.Entity then
    nz.Framework.Request["DeletePlayerSpawner"]:sendRequest({requestedEntity = trace.Entity})
  end
end

nz.Create.Tool:new("player_spawner", "Player Spawner", "spawner", "Allows you to add/remove valid spawn locations for a player.", toolInstructions, shootFunctions, "nz.Forms.playerSpawnerTool")
