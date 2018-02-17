local syncClass = {}

-- Get the Sync Model
local syncModel = gel.fw:getModel("Sync")

function syncClass:new(id, dataFunc, recieveFunc)
  -- Create a new Sync object
  local newSync = syncModel:create(id, dataFunc, recieveFunc)
  -- Create the network string
  local networkString = "gel.Internal.Sync." .. id
  util.AddNetworkString(networkString)

  -- Create a magic method for sending a sync to a player
  function newSync:send(recieveingPlayer)
    Log(LOG_DEBUG, "Sending: '" .. self.id .. "' Sync to: " .. recieveingPlayer:Nick(), "Framework:Sync")

    net.Start(networkString)
      net.WriteTable(self:getData())
    net.Send(recieveingPlayer)
  end

  -- Create a magic method for broadcasting a sync to all players
  function newSync:broadcast()
    Log(LOG_DEBUG, "Broadcasting to all current players: " .. id, "Framework:Sync")

    for _, ply in pairs(player.GetAll()) do
      self:send(ply)
    end
  end

  -- Since we added the magic methods, we should update our sync in the database
  syncModel:update(newSync.id, newSync)
  -- Notify
  Log(LOG_INFO, "Successfully created Sync: " .. newSync.id, "Framework:Sync")
  -- Return the finished controller object from the database
  return syncModel:find(newSync.id)
end

function syncClass:syncPlayer(recieveingPlayer)
  local allSyncs = syncModel:all()
  Log(LOG_DEBUG, "Sending a full sync to: " .. recieveingPlayer:Nick(), "Framework:Sync")
  for _, sync in pairs(allSyncs) do
    sync:send(recieveingPlayer)
  end
  Log(LOG_DEBUG, "Finished sending a full sync to: " .. recieveingPlayer:Nick(), "Framework:Sync")
end

function syncClass:resync(recieveingPlayer)
  for _, ply in pairs(player.GetAll()) do
    ply:sync()
  end
end

-- Assign the class table to the gel global
gel.Internal.Sync = syncClass

-- Create shortcut
function gel.fw:newSync(...)
  gel.Internal.Sync:new(...)
end

-- Create shortcut
function gel.fw:broadcastSync(id)
  -- Find the sync from the database
  local sync = syncModel:find(id)
  -- If we find it then send the request
  if sync then
    sync:broadcast()
  else
    -- Notify
    Log(LOG_ERROR, "Could not find Sync: " .. id, "Framework:Sync")
  end
end
