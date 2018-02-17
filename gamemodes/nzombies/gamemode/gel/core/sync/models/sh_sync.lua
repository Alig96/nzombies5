local prototypeSync = {}

prototypeSync.id = "BaseSync"

function prototypeSync:getData()
  if CLIENT then
    Log(LOG_ERROR, "You should not be calling 'getData' on the Client.", "Framework:Sync")
  else
    return {}
  end
end

function prototypeSync:onReceive(syncData)
  if SERVER then
    Log(LOG_ERROR, "You should not be calling 'onRecieve' on the Server. Use a Request instead.", "Framework:Sync")
  end
end

-- Register this prototype as a model
gel.fw:newModel("Sync", prototypeSync, {"id", "getData", "onReceive"})
