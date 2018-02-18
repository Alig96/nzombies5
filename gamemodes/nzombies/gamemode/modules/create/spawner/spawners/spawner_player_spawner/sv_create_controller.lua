local createPlayerSpawnerController = {}

createPlayerSpawnerController.id = "CreatePlayerSpawner"

function createPlayerSpawnerController:authorizeRequest(requestingPlayer)
  if requestingPlayer:IsSuperAdmin() then
    return true
  end
end

function createPlayerSpawnerController:validateRequest(requestData)
  if requestData["requestedPosition"] then
    return true
  end

  return false
end

function createPlayerSpawnerController:onSuccess(requestingPlayer, requestData)
  Log(LOG_INFO, requestingPlayer:Nick() .. " is creating a Player Spawner", "Controller:" .. self.id)
  local playerSpawner = nz.Spawner:get("player_spawner")
  playerSpawner:spawn(requestData["requestedPosition"], Angle(0, 0, 0))
end

gel.fw:newController(createPlayerSpawnerController.id, createPlayerSpawnerController.onSuccess, createPlayerSpawnerController.validateRequest, createPlayerSpawnerController.authorizeRequest)
