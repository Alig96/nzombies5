local syncClass = {}

-- Get the Sync Model
local syncModel = gel.fw:getModel("Sync")

function syncClass:new(id, dataFunc, recieveFunc)
  -- Create a new Sync object
  local newSync = syncModel:create(id, dataFunc, recieveFunc)
  -- Make the network string
  local networkString = "gel.Internal.Sync." .. id

  -- Register the Sync
  net.Receive(networkString, function(length)
    Log(LOG_DEBUG, "Received: '" .. id .. "' Sync from Server. It's length is: " .. length, "Framework:Sync")
    local syncData = net.ReadTable()

    -- Call the onRecieve function for this sync
    local syncObject = syncModel:find(id)
    syncObject:onReceive(syncData)
  end)
  -- Notify
  Log(LOG_INFO, "Successfully created Sync: " .. newSync.id, "Framework:Sync")
  -- Return the finished sync object
  return newSync
end


-- Assign the class table to the gel global
gel.Internal.Sync = syncClass
-- Create shortcut
function gel.fw:newSync(...)
  gel.Internal.Sync:new(...)
end
