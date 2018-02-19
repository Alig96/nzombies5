local changeModeController = {}

changeModeController.id = "ChangeMode"

function changeModeController:authorize(requestingPlayer)
  if requestingPlayer:IsSuperAdmin() then
    return true
  end
end

function changeModeController:validate(requestData)
  if requestData["currentMode"] == MODE_SURVIVAL or requestData["currentMode"] == MODE_CREATE then
    return true
  end

  return false
end

function changeModeController:onSuccess(requestingPlayer, requestData)
  Log(LOG_INFO, requestingPlayer:Nick() .. " is changing the current mode", "Controller:" .. self.id)
  nz.Mode:set(requestData["currentMode"])
end

gel.fw:newController(changeModeController)
