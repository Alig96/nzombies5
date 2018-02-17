local requestClass = {}

-- Get the Request Model
local requestModel = gel.fw:getModel("Request")

function requestClass:new(id, recieveFunc)
  -- Create a new Request object
  local newRequest = requestModel:create(id, recieveFunc)
  -- Create the network string
  local networkString = "gel.Internal.Request." .. id
  util.AddNetworkString(networkString)

  -- Register the Request
  net.Receive(networkString, function(length, requestingPlayer)
    Log(LOG_DEBUG, "Received Request from: '" .. requestingPlayer:Nick() .. "'. It's length is: " .. length, "Request:" .. id)
    local requestData = net.ReadTable()

    -- Call the onRecieve function for this request
    local request = requestModel:find(id)
    request:onReceive(requestingPlayer, requestData)
  end)

  -- Notify
  Log(LOG_INFO, "Successfully created Request: " .. newRequest.id, "Framework:Request")

  -- Return the finished request object from the database
  return newRequest
end

-- Assign the class table to the gel global
gel.Internal.Request = requestClass

-- Create shortcut
function gel.fw:newRequest(...)
  gel.Internal.Request:new(...)
end
