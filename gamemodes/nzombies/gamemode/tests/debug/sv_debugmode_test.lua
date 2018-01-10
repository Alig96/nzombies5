local debugModeTest = GUnit.Test:new("DebugMode")

local function can_get_mode_without_setting()
  //Get the current debug mode
  local debugMode = nz.Debug.Mode:get()
  //Assert its the default true
  GUnit.assert(debugMode):shouldEqual(true)
end

local function can_set_mode()
  //Set it to production mode
  local debugMode = nz.Debug.Mode:set(false)
  GUnit.assert(debugMode):shouldEqual(false)

  //Get the current debug mode using the function
  debugMode = nz.Debug.Mode:get()
  //Assert that its false still
  GUnit.assert(debugMode):shouldEqual(false)
end

local function can_check_if_in_dev_mode()
  //Set the current debug mode to dev mode
  local debugMode = nz.Debug.Mode:set(true)
  GUnit.assert(debugMode):shouldEqual(true)

  //Assert that we get true using the function
  GUnit.assert(nz.Debug.Mode:isDev()):shouldEqual(true)
end

local function can_check_if_in_production_mode()
  //Set the current debug mode to dev mode
  local debugMode = nz.Debug.Mode:set(false)
  GUnit.assert(debugMode):shouldEqual(false)

  //Assert that we get true using the function
  GUnit.assert(nz.Debug.Mode:isProd()):shouldEqual(true)
end


debugModeTest:addSpec("can get mode without setting it prior", can_get_mode_without_setting)
debugModeTest:addSpec("can set mode", can_set_mode)
debugModeTest:addSpec("can check if in dev mode", can_check_if_in_dev_mode)
debugModeTest:addSpec("can check if in production mode", can_check_if_in_production_mode)
