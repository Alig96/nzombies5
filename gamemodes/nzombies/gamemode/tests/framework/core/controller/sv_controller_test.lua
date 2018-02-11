local controllerTest = GUnit.Test:new("[Framework] Controller")
local playerGen = GUnit.Generators.FakePlayer

local function onSuccess(controller, requestingPlayer, requestData)
  nz.Tests.valueToChange = true
  PrintTable(requestData)
  Log(LOG_INFO, requestingPlayer:Nick() ..  " has changed the test value to true.", "Controller:" .. controller.id)
end

local function validate(requestData)
  return true
end

local function authorize(requestingPlayer)
  return true
end

local function a_controller_can_be_created()
  -- Create a controller
  local newController = nz.Framework.createController("TestController", onSuccess, authorize, validate)

  -- Assert the chat command has been created
  GUnit.assert(newController.id):shouldEqual("TestController")
end

local function a_controller_must_have_a_player_and_data()
  -- Create a controller
  local newController = nz.Framework.createController("TestController", onSuccess, authorize, validate)

  -- Run the controller
  local executed = newController()

  -- Assert the controller failed
  GUnit.assert(executed):shouldEqual(false)
end

local function a_controller_can_fail_if_player_is_not_authorized()
  -- Create a controller where the player always is not auth'd
  local newController = nz.Framework.createController("TestController", onSuccess, function(requestingPlayer) return false end, validate)
  local fakePlayer = playerGen:new()
  -- Run the controller
  local executed = newController(fakePlayer, {})

  -- Assert the controller failed
  GUnit.assert(executed):shouldEqual(false)
end

local function a_controller_can_fail_if_data_is_not_valid()
  -- Create a controller where the player always is not auth'd
  local newController = nz.Framework.createController("TestController", onSuccess, authorize, function(requestData) return false end)
  local fakePlayer = playerGen:new()
  -- Run the controller
  local executed = newController(fakePlayer, {})

  -- Assert the controller failed
  GUnit.assert(executed):shouldEqual(false)
end

local function a_controller_can_pass_if_player_AND_data_is_valid()
  -- Create a controller where the player always is not auth'd
  local newController = nz.Framework.createController("TestController", onSuccess, authorize, validate)
  local fakePlayer = playerGen:new()
  -- Run the controller
  local executed = newController(fakePlayer, {valueToChange = true})

  -- Assert the controller passed
  GUnit.assert(executed):shouldEqual(true)
  -- Assert that our test value is now true
  GUnit.assert(nz.Tests.valueToChange):shouldEqual(true)
end

controllerTest:beforeAll(function ()
  nz.Tests = {}

  -- Set it to dev mode
  nz.Framework.Environment:setDev()
end)

controllerTest:afterAll(function ()
  nz.Tests = null
end)

controllerTest:addSpec("can be created", a_controller_can_be_created)
controllerTest:addSpec("must have a player and data", a_controller_must_have_a_player_and_data)
controllerTest:addSpec("can fail if player is not authorized", a_controller_can_fail_if_player_is_not_authorized)
controllerTest:addSpec("can fail if data is not valid", a_controller_can_fail_if_data_is_not_valid)
controllerTest:addSpec("can pass if player AND data is valid", a_controller_can_pass_if_player_AND_data_is_valid)
