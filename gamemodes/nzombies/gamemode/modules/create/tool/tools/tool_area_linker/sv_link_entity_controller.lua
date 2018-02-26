local linkEntityController = {}

linkEntityController.id = "LinkEntity"

function linkEntityController:authorize(requestingPlayer)
  if requestingPlayer:IsSuperAdmin() then
    return true
  end
end

function linkEntityController:validate(requestData)
  if requestData["requestedEntity"] and requestData["areaEntity"] and isentity(requestData["requestedEntity"]) and isentity(requestData["areaEntity"]) then
    return true
  end

  return false
end

function linkEntityController:onSuccess(requestingPlayer, requestData)
  local entityToLink = requestData["requestedEntity"]
  local areaEntity = requestData["areaEntity"]
  if entityToLink.isLinkable then
    entityToLink:SetLinkEntity(areaEntity)
    Log(LOG_INFO, requestingPlayer:Nick() .. " is linking entity: " .. entityToLink:__tostring() .. " to Area: " .. areaEntity:__tostring(), "Controller:" .. self.id)
  end
end

gel.fw:newController(linkEntityController)
