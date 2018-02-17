local prototypeRequest = {}

prototypeRequest.id = "BaseRequest"

function prototypeRequest:onReceive(callingPlayer, requestData)
  if CLIENT then
    Log(LOG_ERROR, "You should not be calling 'onRecieve' on the Client. Use a Sync instead.", "Request:" ..  self.id)
  end
end

-- Register this prototype as a model
gel.fw:newModel("Request", prototypeRequest, {"id", "onReceive"})
