local debugEnvironmentTest = GUnit.Test:new("Debug > Environment")

local function can_set_environment()
  -- Set the environment to public
  local debugEnvironment = nz.Debug.Environment:set(ENV_PUBLIC)
  GUnit.assert(debugEnvironment):shouldEqual(ENV_PUBLIC)

  -- Get the current environment & assert that its still public
  GUnit.assert(nz.Debug.Environment:get()):shouldEqual(ENV_PUBLIC)
end

local function can_check_if_in_dev_environment()
  -- Set the current debug Environment to dev Environment
  nz.Debug.Environment:set(ENV_DEV)

  -- Assert that we get true using the function
  GUnit.assert(nz.Debug.Environment:isDev()):shouldEqual(true)
end

local function can_check_if_in_private_environment()
  -- Set the current debug Environment to dev Environment
  nz.Debug.Environment:set(ENV_PRIVATE)

  -- Assert that we get true using the function
  GUnit.assert(nz.Debug.Environment:isPrivate()):shouldEqual(true)
end

local function can_check_if_in_public_environment()
  -- Set the current debug Environment to dev Environment
  nz.Debug.Environment:set(ENV_PUBLIC)

  -- Assert that we get true using the function
  GUnit.assert(nz.Debug.Environment:isPublic()):shouldEqual(true)
end

debugEnvironmentTest:addSpec("can set environment", can_set_environment)
debugEnvironmentTest:addSpec("can check if in dev environment", can_check_if_in_dev_environment)
debugEnvironmentTest:addSpec("can check if in private environment", can_check_if_in_private_environment)
debugEnvironmentTest:addSpec("can check if in public environment", can_check_if_in_public_environment)
