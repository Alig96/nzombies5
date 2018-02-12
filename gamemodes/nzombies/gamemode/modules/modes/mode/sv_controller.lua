local function authorizeRequest(requestingPlayer)
  if requestingPlayer:IsSuperAdmin() then
    return true
  end
end

local function validateRequest(requestData)
  local requestedMode = requestData["requestedMode"]

  if nz.Mode:validate(requestedMode) then
    return true
  end

  return false
end

local function onSuccess(requestingPlayer, requestData)
  local requestedModeNumber = requestData["requestedMode"]
  nz.Mode:set(requestedModeNumber)
  Log(LOG_INFO, requestingPlayer:Nick() ..  " updated the current mode.", "Modes:Mode")
end

nz.Mode.updateController = nz.Framework.createController("Mode", onSuccess, authorizeRequest, validateRequest)
