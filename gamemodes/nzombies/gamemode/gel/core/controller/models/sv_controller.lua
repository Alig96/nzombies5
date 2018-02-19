local prototypeController = {}

prototypeController.id = "BaseController"

function prototypeController:authorize(callingPlayer)
  if callingPlayer:IsSuperAdmin() then
    return true
  else
    return false
  end
end

function prototypeController:validate(requestData)
  Log(LOG_ERROR, "You must override the Controller's validate method.", "Controller:" .. self.id)
  return false
end

function prototypeController:onSuccess(callingPlayer, requestData)
  print("Yay! " .. callingPlayer:Nick() .. " made a successful request to controller: " .. self.id .. ". Here is the request data:")
  PrintTable(requestData)
end

-- Register this prototype as a model
gel.fw:newModel("Controller", prototypeController, {"id", "authorize", "validate", "onSuccess"})
