local newSync = {}

newSync.id = "NewSync"

-- Data from the server to sync
if SERVER then
  function newSync:getData()
    local data = {"hi"}

    return data
  end
end

-- On Client Recieveing
if CLIENT then
  function newSync:onReceive(requestData)
    PrintTable(requestData)
  end
end

gel.fw:newSync(newSync.id,  newSync.getData, newSync.onReceive)

-- gel.fw:broadcastSync("NewSync")
