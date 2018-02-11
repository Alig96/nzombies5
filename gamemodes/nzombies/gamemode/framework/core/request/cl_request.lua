-- The client side of a request
function nz.Framework.createRequest(id, recieveFunc)
  -- Create a request model
  local requestModel = nz.Framework.newRequest(id)
  local networkString = "nz.Framework.Request." .. id

  -- Create a magic method for recieveing a request
  function requestModel:sendRequest(requestData)
    Log(LOG_INFO, "Sending: '" .. id .. "' Request to server.", "Framework:Request")

    net.Start(networkString)
      net.WriteTable(requestData)
    net.SendToServer()
  end

  -- Register the reciever/Store the model
  nz.Framework.Request[id] = requestModel

  return nz.Framework.Request[id]
end
