local newController = {}

newController.id = "NewController"

function newController:authorizeRequest(requestingPlayer)
  if requestingPlayer:IsSuperAdmin() then
    return true
  end
end

function newController:validateRequest(requestData)
  if requestData[1] == "hey" then
    return true
  end

  return false
end

function newController:onSuccess(requestingPlayer, requestData)
  Log(LOG_INFO, "Yay! " .. requestingPlayer:Nick() ..  "'s request made a it through the contorller", "Controller:" .. self.id)
end

gel.fw:newController(newController.id, newController.onSuccess, newController.validateRequest, newController.authorizeRequest)

-- gel.fw:handleController("NewController", requestingPlayer, requestData)
