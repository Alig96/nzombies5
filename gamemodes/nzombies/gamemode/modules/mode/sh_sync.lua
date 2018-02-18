local modeSync = {}

modeSync.id = "Mode"

-- Data from the server to sync
if SERVER then
  function modeSync:getData()
    local data = {
      currentMode = nz.Mode:get().id
    }

    return data
  end
end

-- On Client Recieveing
if CLIENT then
  function modeSync:onReceive(requestData)
    PrintTable(requestData)
    nz.Mode:set(requestData["currentMode"])
  end
end

gel.fw:newSync(modeSync.id, modeSync.getData, modeSync.onReceive)
