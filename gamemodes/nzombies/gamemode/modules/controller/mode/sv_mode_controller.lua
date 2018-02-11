local function authorizeRequest(controllerObject, ply)
  if ply:IsSuperAdmin() then
    return true
  end
end

local function validateRequest(controllerObject, requestData)
  local requestedMode = requestData["requestedMode"]

  if requestedMode == MODE_PLAY or requestedMode == MODE_CREATIVE then
    return true
  end

  return false
end

local function onSuccess(controllerObject, requestingPlayer, requestData)
  local requestedModeNumber = requestData["requestedMode"]
  nz.Mode:set(requestedModeNumber)
  Log(LOG_INFO, requestingPlayer:Nick() ..  " has changed the mode to: " .. requestedModeNumber .. ".", "Controller:" .. controllerObject.id)
end

nz.Controller.handleChangeMode = nz.Framework.createController("ChangeMode", onSuccess, authorizeRequest, validateRequest)
