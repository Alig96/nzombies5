local syncClass = {}

-- Get the Sync Model
local syncModel = gel.fw:getModel("Sync")

function syncClass:new(syncObject)
  local id = syncObject.id
  if id == nil then Log(LOG_ERROR, "You must register a Sync with an ID", "Framework:Sync") return end
  -- Create a new Sync object
  local newSync = syncModel:create(id, syncObject.getData, syncObject.onReceive)
  -- Make the network string
  local networkString = "gel.Internal.Sync." .. id

  -- Register the Sync
  net.Receive(networkString, function(length)
    Log(LOG_DEBUG, "Received: '" .. id .. "' Sync from Server. It's length is: " .. length, "Framework:Sync")
    local syncData = net.ReadTable()

    -- Call the onRecieve function for this sync
    local sync = syncModel:find(id)
    sync:onReceive(syncData)
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
