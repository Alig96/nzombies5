-- Here is a sample format for a new Sync object
local sync = {}

-- Data from the server to sync
if SERVER then
  function sync:getData()
    local data = {"hi"}

    return data
  end
end

-- On Client Recieveing
if CLIENT then
  function sync:onReceive(requestData)
    PrintTable(requestData)
  end
end

gel.fw:newSync("TestSync",  sync.getData, sync.onReceive)
