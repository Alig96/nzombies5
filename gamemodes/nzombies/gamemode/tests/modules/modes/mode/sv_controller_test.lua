local modeControllerTest = GUnit.Test:new("Modes > Mode > Controller")

local function must_authorize_player()
  -- Set the current mode to play mode
  nz.Mode:set(MODE_PLAY)

  -- Create a fake player that will fail the check
  local unauthorizedPlayer = {
    ["Nick"] = function() return "Bot" end,
    ["IsSuperAdmin"] = function() return false end
  }

  local requestData = {
    ["requestedMode"] = MODE_CREATIVE,
  }

  -- Send a request with the player and data
  local status = nz.Mode.updateController(unauthorizedPlayer, requestData)
  -- The request should fail so the status should be false, and the game is still in play mode
  GUnit.assert(status):shouldEqual(false)
  GUnit.assert(nz.Mode:isCreative()):shouldEqual(false)
end

local function must_validate_data()
  -- Set the current mode to play mode
  nz.Mode:set(MODE_PLAY)

  -- Create an authorized player that will pass the check
  local authorizedPlayer = {
    ["Nick"] = function() return "Bot" end,
    ["IsSuperAdmin"] = function() return true end
  }

  -- Alter the request data to be invalid
  local requestData = {
    ["requestedMode"] = MODE_INVALID,
  }

  -- Send a request with the player and data
  local status = nz.Mode.updateController(authorizedPlayer, requestData)
  -- The request should fail so the status should be false, and the game is still in play mode
  GUnit.assert(status):shouldEqual(false)
  GUnit.assert(nz.Mode:isCreative()):shouldEqual(false)
end

local function can_change_mode_with_valid_request()
  -- Set the current mode to play mode
  nz.Mode:set(MODE_PLAY)

  -- Create a authorized player
  local authorizedPlayer = {
    ["Nick"] = function() return "Bot" end,
    ["IsSuperAdmin"] = function() return true end
  }

  -- Create a valid request
  local requestData = {
    ["requestedMode"] = MODE_CREATIVE,
  }

  -- Send a request with the player and data
  local status = nz.Mode.updateController(authorizedPlayer, requestData)
  -- The request should fail so the status should be false, and the game is still in play mode
  GUnit.assert(status):shouldEqual(true)
  GUnit.assert(nz.Mode:isCreative()):shouldEqual(true)
end

modeControllerTest:addSpec("the mode cannot be changed, if the player is not authorized", must_authorize_player)
modeControllerTest:addSpec("the mode cannot be changed, if the data is not valid", must_validate_data)
modeControllerTest:addSpec("the mode can be changed, if the player is authorized and the data is valid", can_change_mode_with_valid_request)
