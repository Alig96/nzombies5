local prototypeSync = {}

prototypeSync.id = "BaseSync"

function prototypeSync:onReceive(syncData)
  if SERVER then
    Log(LOG_ERROR, "You should not be calling 'onRecieve' on the Server. Use a Request instead.", "Framework:Models:Sync")
  end
end

function prototypeSync:dataToSync()
  if CLIENT then
    Log(LOG_ERROR, "You should not be calling 'dataToSync' on the Client.", "Framework:Models:Sync")
  else
    return {}
  end
end

-- Register this prototype as a model
nz.Framework.registerModel(prototypeSync, "Sync", {"id", "onReceive", "dataToSync"})
