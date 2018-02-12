local function authorizeRequest(ply)
  if ply:IsSuperAdmin() then
    return true
  end
end

local function validateRequest(requestData)
  local requestedPosition = requestData["requestedPosition"]

  if isvector(requestedPosition) then
    return true
  end

  return false
end

local function onSuccess(requestingPlayer, requestData)
  local requestedPosition = requestData["requestedPosition"]

  Log(LOG_DEBUG, requestingPlayer:Nick() ..  " has requested to add a Player Spawner.", "Create:Spawn")
  nz.Create.Spawn:addPlayerSpawner(requestedPosition)
end

nz.Create.Spawn.handleCreatePlayerSpawner = nz.Framework.createController("CreatePlayerSpawner", onSuccess, authorizeRequest, validateRequest)
