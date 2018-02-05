local function authorizeRequest(ply)
  if ply:IsSuperAdmin() then
    return true
  else
    nz.Debug.Print("danger", "[Controller:Tools:Player Spawner] Could not create a player spawner since " .. ply:Nick() .. " is not authorised.")
    return false
  end
end

local function validateRequest(requestData)
  local requestedCreationPosition = requestData["createPosition"]

  if isvector(requestedCreationPosition) then
    return true
  end

  nz.Debug.Print("danger", "[Controller:Tools:Player Spawner] Could not create a player spawner because there was no supplied vector.")
  return false
end

-- Handles all incoming requests from a player
function nz.Controller.handleCreatePlayerSpawner(ply, requestData)
  -- Check the user is authorised to do this action
  local authorised = authorizeRequest(ply)
  -- Validate the request
  local validated = validateRequest(requestData)

  -- If both tests pass
  if authorised and validated then
    nz.Debug.Print("success", "[Controller:Tools:Player Spawner] " .. ply:Nick() ..  " has made a successful request to 'Create a player Spawner'.")
    -- Execute the requests
    nz.Creative.Spawn:addPlayerSpawner(requestData["createPosition"])
    return true
  end

  return false
end
