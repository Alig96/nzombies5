local function authorizeRequest(ply)
  if ply:IsSuperAdmin() then
    return true
  end
end

local function validateRequest(requestData)
  local requestedEntity = requestData["requestedEntity"]

  if isentity(requestedEntity) then -- and requestedEntity:GetClass() == "nz_player_spawner" then
    return true
  end

  return false
end

local function onSuccess(requestingPlayer, requestData)
  local requestedEntity = requestData["requestedEntity"]

  Log(LOG_DEBUG, requestingPlayer:Nick() ..  " has requested to remove a Player Spawner.", "Create:Spawn")
  nz.Create.Spawn:removePlayerSpawner(requestedEntity)
end

nz.Create.Spawn.handleDeletePlayerSpawner = nz.Framework.createController("DeletePlayerSpawner", onSuccess, authorizeRequest, validateRequest)
