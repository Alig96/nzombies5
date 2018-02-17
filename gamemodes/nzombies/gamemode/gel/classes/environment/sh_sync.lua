local environmentSync = {}

environmentSync.id = "Environment"

-- Data from the server to sync
if SERVER then
  function environmentSync:getData()
    local data = {
      environmentId = gel.Internal.Environment:get().id
    }

    return data
  end
end

-- On Client Recieveing
if CLIENT then
  function environmentSync:onReceive(requestData)
    gel.Internal.Environment:set(requestData["environmentId"])
  end
end

gel.fw:newSync(environmentSync.id,  environmentSync.getData, environmentSync.onReceive)
