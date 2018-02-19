local deletePlayerSpawnerController = {}

deletePlayerSpawnerController.id = "DeletePlayerSpawner"

function deletePlayerSpawnerController:authorize(requestingPlayer)
  if requestingPlayer:IsSuperAdmin() then
    return true
  end
end

function deletePlayerSpawnerController:validate(requestData)
  if requestData["requestedEntity"] then
    return true
  end

  return false
end

function deletePlayerSpawnerController:onSuccess(requestingPlayer, requestData)
  Log(LOG_INFO, requestingPlayer:Nick() .. " is deleteing a Player Spawner", "Controller:" .. self.id)
  requestData["requestedEntity"]:Remove()
end

gel.fw:newController(deletePlayerSpawnerController)
