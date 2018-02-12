local environmentTest = GUnit.Test:new("[Framework] Environment")

local function can_set_environment()
  -- Set the environment to public
  local environment = nz.Framework.Environment:setPublic()
  GUnit.assert(environment):shouldEqual(ENV_PUBLIC)

  -- Get the current environment & assert that its still public
  GUnit.assert(nz.Framework.Environment()):shouldEqual(ENV_PUBLIC)
end

local function can_check_if_in_dev_environment()
  -- Set the current debug Environment to dev Environment
  nz.Framework.Environment:setDev()

  -- Assert that we get true using the function
  GUnit.assert(nz.Framework.Environment:isDev()):shouldEqual(true)
end

local function can_check_if_in_private_environment()
  -- Set the current debug Environment to private Environment
  nz.Framework.Environment:setPrivate()

  -- Assert that we get true using the function
  GUnit.assert(nz.Framework.Environment:isPrivate()):shouldEqual(true)
end

local function can_check_if_in_public_environment()
  -- Set the current debug Environment to public Environment
  nz.Framework.Environment:setPublic()

  -- Assert that we get true using the function
  GUnit.assert(nz.Framework.Environment:isPublic()):shouldEqual(true)
end

environmentTest:addSpec("can set environment", can_set_environment)
environmentTest:addSpec("can check if in dev environment", can_check_if_in_dev_environment)
environmentTest:addSpec("can check if in private environment", can_check_if_in_private_environment)
environmentTest:addSpec("can check if in public environment", can_check_if_in_public_environment)
