local requestClass = {}

-- Get the Request Model
local requestModel = gel.fw:getModel("Request")

function requestClass:new(requestObject)
  local id = requestObject.id
  if id == nil then Log(LOG_ERROR, "You must register a Request with an ID", "Framework:Request") return end
  -- Create a new Request object
  local newRequest = requestModel:create(id, requestObject.onReceive)
  -- Create the network string
  local networkString = "gel.Internal.Request." .. newRequest.id

  -- Create a magic method for sending a sync to the
  function newRequest:send(requestData)
    Log(LOG_DEBUG, "Sending a request to server", "Request:" .. self.id)

    net.Start(networkString)
      net.WriteTable(requestData)
    net.SendToServer()
  end

  -- Since we added the magic methods, we should update our request in the database
  requestModel:update(newRequest.id, newRequest)
  -- Notify
  Log(LOG_INFO, "Successfully created Request: " .. newRequest.id, "Framework:Request")
  -- Return the finished request object from the database
  return requestModel:find(newRequest.id)
end

-- Assign the class table to the gel global
gel.Internal.Request = requestClass

-- Create shortcut
function gel.fw:newRequest(...)
  gel.Internal.Request:new(...)
end

function gel.fw:sendRequest(id, requestData)
  -- Find the request from the database
  local request = requestModel:find(id)
  -- If we find it then send the request
  if request then
    request:send(requestData)
  else
    -- Notify
    Log(LOG_ERROR, "Could not find Request: " .. id, "Framework:Request")
  end
end
