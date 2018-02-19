local exampleSync = {}

exampleSync.id = "NewSync"

-- Data from the server to sync
if SERVER then
  function exampleSync:getData()
    local data = {"hi"}

    return data
  end
end

-- On Client Recieveing
if CLIENT then
  function exampleSync:onReceive(requestData)
    PrintTable(requestData)
  end
end

gel.fw:newSync(exampleSync)
-- gel.fw:broadcastSync("NewSync")
