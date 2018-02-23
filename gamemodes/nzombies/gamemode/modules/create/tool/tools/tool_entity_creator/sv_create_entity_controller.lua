local createEntityController = {}

createEntityController.id = "CreateEntity"

function createEntityController:authorize(requestingPlayer)
  if requestingPlayer:IsSuperAdmin() then
    return true
  end
end

function createEntityController:validate(requestData)
  if requestData["requestedEntity"] and requestData["requestedPosition"] and requestData["entityData"] then
    return true
  end

  return false
end

function createEntityController:onSuccess(requestingPlayer, requestData)
  local entityId = requestData["requestedEntity"]
  local pos = requestData["requestedPosition"]
  local entityData = requestData["entityData"]

  local entityManager = nz.entityManager:get(entityId)

  if entityManager then
    entityManager:spawn(pos, Angle(0,0,0), entityData)
  end
  --Log(LOG_INFO, requestingPlayer:Nick() .. " is updating entity: " .. entity.PrintName .. entity:EntIndex(), "Controller:" .. self.id)
  --entity:updateEditableProperties(formData)
end

gel.fw:newController(createEntityController)
