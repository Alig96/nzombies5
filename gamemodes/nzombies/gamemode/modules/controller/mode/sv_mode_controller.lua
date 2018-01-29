local function authorizeRequest(ply)
  if ply:IsSuperAdmin() then
    return true
  else
    nz.Debug.Print("danger", "[Controller:Mode] Could not change mode since " .. ply:Nick() .. " is not authorised.")
    return false
  end
end

local function validateRequest(requestData)
  local requestedMode = requestData["requestedMode"]

  if requestedMode == MODE_PLAY or requestedMode == MODE_CREATIVE then
    return true
  end

  nz.Debug.Print("danger", "[Controller:Mode] Could not change mode since the data supplied did not pass validation.")
  return false
end

-- Handles all incoming requests from a player
function nz.Controller.handleChangeMode(ply, requestData)
  -- Check the user is authorised to do this action
  local authorised = authorizeRequest(ply)
  -- Validate the request
  local validated = validateRequest(requestData)

  -- If both tests pass
  if authorised and validated then
    nz.Debug.Print("success", "[Controller:Mode] " .. ply:Nick() ..  " has made a successful request to change the mode.")
    -- Execute the requests
    nz.Mode:set(requestData["requestedMode"])

    return true
  end

  return false
end
