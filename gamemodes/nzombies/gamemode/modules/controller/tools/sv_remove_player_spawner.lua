local function authorizeRequest(ply)
  if ply:IsSuperAdmin() then
    return true
  else
    nz.Debug.Print("danger", "[Controller:Tools:Player Spawner] Could not remove a player spawner since " .. ply:Nick() .. " is not authorised.")
    return false
  end
end

local function validateRequest(requestData)
  local requestedEntity = requestData["selectedEntity"]

  if isentity(requestedEntity) and requestedEntity:GetClass() == "nz_player_spawner" then
    return true
  end

  nz.Debug.Print("danger", "[Controller:Tools:Player Spawner] Could not remove a player spawner because the entity provided was not the right class.")
  return false
end

-- Handles all incoming requests from a player
function nz.Controller.handleRemovePlayerSpawner(ply, requestData)
  -- Check the user is authorised to do this action
  local authorised = authorizeRequest(ply)
  -- Validate the request
  local validated = validateRequest(requestData)

  -- If both tests pass
  if authorised and validated then
    nz.Debug.Print("success", "[Controller:Tools:Player Spawner] " .. ply:Nick() ..  " has made a successful request to 'Remove a player Spawner'.")
    -- Execute the requests
    nz.Creative.Spawn:removePlayerSpawner(requestData["selectedEntity"])
    return true
  end

  return false
end
