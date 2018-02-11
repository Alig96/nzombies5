local logModuleName = "Framework:Models:Controller"

local prototypeController = {}

prototypeController.id = "BaseController"

function prototypeController:onSuccess(callingPlayer, requestData)
  --print(callingPlayer:Nick() .. " mad a successful request to controller: " .. self.id)
  print("Yay! " .. callingPlayer:Nick() .. " made a successful request to controller: " .. self.id .. ". Here is the request data:")
  PrintTable(requestData)
end

function prototypeController:validate(requestData)
  Log(LOG_ERROR, "You must override the BaseController's validate method. Controller: " .. self.id, logModuleName)
  return false
end

function prototypeController:authorize(callingPlayer)
  if callingPlayer:IsSuperAdmin() then
    return true
  else
    return false
  end
end

-- Register this prototype as a model
nz.Framework.registerModel(prototypeController, "Controller", {"id", "onSuccess", "authorize", "validate"})
