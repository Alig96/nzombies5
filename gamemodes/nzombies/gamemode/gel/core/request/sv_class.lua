local requestClass = {}

-- Get the Request Model
local requestModel = gel.fw:getModel("Request")

function requestClass:new(requestObject)
  local id = requestObject.id
  if id == nil then Log(LOG_ERROR, "You must register a request with an ID.", "Framework:Request") return end
  -- Create a new Request object
  local newRequest = requestModel:create(id, requestObject.onReceive)
  -- Create the network string
  local networkString = "gel.Internal.Request." .. newRequest.id
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
