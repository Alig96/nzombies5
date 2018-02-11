-- The client side of a sync
function nz.Framework.createSync(id, recieveFunc)
  -- Create a sync model
  local syncModel = nz.Framework.newSync(id, recieveFunc)
  local networkString = "nz.Framework.Sync." .. id

  -- Create a magic method for recieveing a sync
  local function receiveSync(length)
    Log(LOG_INFO, "Received Sync: '" .. id .. "' from Server. It's length is: " .. length, "Framework:Sync")
    local syncData = net.ReadTable()

    -- Call onReceive function
    nz.Framework.Sync[id].onReceive(syncData)
  end

  -- Register the reciever/Store the model
  nz.Framework.Sync[id] = syncModel
  net.Receive(networkString, receiveSync)

  Log(LOG_INFO, "Registered reciever: " .. networkString, "Framework:Sync")

  return nz.Framework.Sync[id]
end
