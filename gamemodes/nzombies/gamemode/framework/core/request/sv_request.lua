-- The server side of a request
function nz.Framework.createRequest(id, recieveFunc)
  -- Create a request model
  local requestModel = nz.Framework.newRequest(id, recieveFunc)
  local networkString = "nz.Framework.Request." .. id

  -- Create the network string
  util.AddNetworkString(networkString)

  -- Create a magic method for recieveing a request
  local function receiveRequest(length, requestingPlayer)
    if requestingPlayer:IsValid() then
      Log(LOG_DEBUG, "Received Request: '" .. id .. "' from: " .. requestingPlayer:Nick() .. ". It's length is: " .. length, "Framework:Request")
      local requestData = net.ReadTable()

      -- Call onReceive function
      nz.Framework.Request[id].onReceive(requestingPlayer, requestData)
      -- Notify the requesting player if the status of their request passed or not
    end
  end

  -- Register the reciever/Store the model
  nz.Framework.Request[id] = requestModel
  net.Receive(networkString, receiveRequest)

  Log(LOG_DEBUG, "Registered reciever: " .. networkString, "Framework:Request")

  return nz.Framework.Request[id]
end
