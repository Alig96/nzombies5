local controllerClassTest = GUnit.Test:new("[Framework] Controller Class")
local playerGen = GUnit.Generators.FakePlayer

local testControllerId = "TestController"

local function can_create_a_new_controller()
  local testControllerObject = {
    id = testControllerId,
    validate = function() return true end
  }
  -- Make a new controller where the validation function just passes true
  local newController = gel.fw:newController(testControllerObject)

  GUnit.assert(newController.id):shouldEqual(testControllerId)
end

local function a_controller_cannot_handle_a_request_with_no_player_and_data()
  local testControllerObject = {
    id = testControllerId,
  }
  -- Make a new controller
  local newController = gel.fw:newController(testControllerObject)
  -- Send a request with no player and data
  local response = newController:handleRequest(nil, nil)
  -- Assert that the response from the controller passed
  GUnit.assert(response):shouldEqual(false)
end

local function a_controller_cannot_handle_a_request_if_player_is_not_authorized()
  local testControllerObject = {
    id = testControllerId,
    validate = function() return true end,
    authorize = function() return false end,
  }
  -- Make a new controller using default authorization, and validation passes
  local newController = gel.fw:newController(testControllerObject)
  -- Make a fake player
  local fakePlayer = playerGen:new()
  -- Override the fake player's super admin status
  function fakePlayer:IsSuperAdmin()
    return false
  end
  -- Send a request with no player and data
  local response = newController:handleRequest(fakePlayer, {})
  -- Assert that the response from the controller passed
  GUnit.assert(response):shouldEqual(false)
end

local function a_controller_cannot_handle_a_request_if_the_data_is_not_valid()
  local testControllerObject = {
    id = testControllerId,
    validate = function() return false end,
    authorize = function() return true end,
  }
  -- Make a new controller using default authorization, where validation fails, but authorization passes
  local newController = gel.fw:newController(testControllerObject)
  -- Make a fake player
  local fakePlayer = playerGen:new()
  -- Override the fake player's super admin status
  function fakePlayer:IsSuperAdmin()
    return true
  end
  -- Send a request with no player and data
  local response = newController:handleRequest(fakePlayer, {})
  -- Assert that the response from the controller passed
  GUnit.assert(response):shouldEqual(false)
end

local function a_controller_can_handle_a_request_with_a_valid_player_and_data()
  local testControllerObject = {
    id = testControllerId,
    validate = function() return true end,
    authorize = function() return true end,
  }
  -- Make a new controller where the validation function just passes true
  local newController = gel.fw:newController(testControllerObject)
  -- Make a fake player
  local fakePlayer = playerGen:new()
  -- Override the fake player's super admin status
  function fakePlayer:IsSuperAdmin()
    return true
  end
  -- Send a request with the fake player and empty data
  local response = newController:handleRequest(fakePlayer, {})
  -- Assert that the response from the controller passed
  GUnit.assert(response):shouldEqual(true)
end

controllerClassTest:addSpec("can create a new controller", can_create_a_new_controller)
controllerClassTest:addSpec("a controller cannot handle a request, with no player and data", a_controller_cannot_handle_a_request_with_no_player_and_data)
controllerClassTest:addSpec("a controller cannot handle a request, if player is not authorized", a_controller_cannot_handle_a_request_if_player_is_not_authorized)
controllerClassTest:addSpec("a controller cannot handle a request, if data is not valid", a_controller_cannot_handle_a_request_if_the_data_is_not_valid)
controllerClassTest:addSpec("a controller can handle a request, with a valid player and valid data", a_controller_can_handle_a_request_with_a_valid_player_and_data)

local function afterEach()
  gel.Internal.Controller:delete(testControllerId)
end

controllerClassTest:afterEach(afterEach)
