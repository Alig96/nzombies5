local removeEntityController = {}

removeEntityController.id = "RemoveEntity"

function removeEntityController:authorize(requestingPlayer)
  if requestingPlayer:IsSuperAdmin() then
    return true
  end
end

function removeEntityController:validate(requestData)
  if requestData["requestedEntity"] then
    return true
  end

  return false
end

function removeEntityController:onSuccess(requestingPlayer, requestData)
  local entity = requestData["requestedEntity"]
  local entityManager = nz.entityManager:get(entity:GetClass())

  if entityManager then
    entityManager:delete(entity)
  end
end

gel.fw:newController(removeEntityController)
