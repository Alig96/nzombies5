local updateEntityController = {}

updateEntityController.id = "UpdateEntity"

function updateEntityController:authorize(requestingPlayer)
  if requestingPlayer:IsSuperAdmin() then
    return true
  end
end

function updateEntityController:validate(requestData)
  if requestData["requestedEntity"] and requestData["formData"] then
    return true
  end

  return false
end

function updateEntityController:onSuccess(requestingPlayer, requestData)
  local entity = requestData["requestedEntity"]
  local formData = requestData["formData"]
  Log(LOG_INFO, requestingPlayer:Nick() .. " is updating entity: " .. entity.PrintName .. entity:EntIndex(), "Controller:" .. self.id)
  entity:updateEditableProperties(formData)
end

gel.fw:newController(updateEntityController)
