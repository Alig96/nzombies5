local exampleController = {}

exampleController.id = "exampleController"

function exampleController:authorize(requestingPlayer)
  if requestingPlayer:IsSuperAdmin() then
    return true
  end
end

function exampleController:validate(requestData)
  if requestData[1] == "hey" then
    return true
  end

  return false
end

function exampleController:onSuccess(requestingPlayer, requestData)
  Log(LOG_INFO, "Yay! " .. requestingPlayer:Nick() ..  "'s request made a it through the contorller", "Controller:" .. self.id)
end

gel.fw:newController(exampleController)
-- gel.fw:handleController("NewController", requestingPlayer, requestData)
