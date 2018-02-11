local moduleName = "Framework:Models:Request"
local prototypeRequest = {}

prototypeRequest.id = "BaseRequest"

function prototypeRequest:onReceive(callingPlayer, requestData)
  if CLIENT then
    Log(LOG_ERROR, "You should not be calling 'onRecieve' on the Client. Use a Sync instead.", moduleName)
  end
end

-- Register this prototype as a model
nz.Framework.registerModel(prototypeRequest, "Request", {"id", "onReceive"})
