-- The server side of a sync
function nz.Framework.createSync(id, recieveFunc, dataFunc)
  -- Create a sync model
  local syncModel = nz.Framework.newSync(id, recieveFunc, dataFunc)
  local networkString = "nz.Framework.Sync." .. id

  -- Create the network string
  util.AddNetworkString(networkString)

  -- Create a magic method for recieveing a sync
  function syncModel:sendSync(recieveingPlayer)
    Log(LOG_DEBUG, "Sending: '" .. id .. "' Sync to: " .. recieveingPlayer:Nick() .. ".", "Framework:Sync")

    net.Start(networkString)
      net.WriteTable(self:dataToSync())
    net.Send(recieveingPlayer)
  end

  -- Create a magic method for broadcasting a sync
  function syncModel:broadcast()
    Log(LOG_DEBUG, "Broadcasting to all current players: " .. id, "Framework:Sync")

    for _, ply in pairs(player.GetAll()) do
      nz.Framework.Sync[id]:sendSync(ply)
    end
  end

  -- Register the reciever/Store the model
  nz.Framework.Sync[id] = syncModel

  return nz.Framework.Sync[id]
end

-- nz.Framework.Sync[id]:sendSync(ply)
