local environmentModel = gel.Internal.Model:get("Environment")

environmentClass = {}

environmentClass.availableEnvironments = {
  [ENV_DEV] = environmentModel:make(ENV_DEV, "Development"),
  [ENV_PRIVATE] = environmentModel:make(ENV_PRIVATE, "Private"),
  [ENV_PUBLIC] = environmentModel:make(ENV_PUBLIC, "Public"),
}

environmentClass.currentEnvironment = environmentClass.availableEnvironments[ENV_DEV]

function environmentClass:get(envId)
  if envId then
    return self.availableEnvironments[envId]
  end

  return self.currentEnvironment
end

function environmentClass:set(envNum)
  local environment = self:get(envNum)
  if environment then
    -- Set the current environment
    self.currentEnvironment = environment
    -- Notify the console
    Log(LOG_INFO, "Environment was set to: " .. self.currentEnvironment.name, "Framework:Environment")

    if SERVER then
      -- Broadcast the environment to all players
      gel.fw:broadcastSync("Environment")
    end
  end
  -- Return the environment
  return environment
end

-- Helpers
function environmentClass:isDev()
  return self:get().id == ENV_DEV
end

function environmentClass:isPrivate()
  return self:get().id == ENV_PRIVATE
end

function environmentClass:isPublic()
  return self:get().id == ENV_PUBLIC
end

-- Assign the class table to the gel global
gel.Internal.Environment = environmentClass

-- Create shortcut
function gel.fw:setEnvironment(envId)
  return gel.Internal.Environment:set(envId)
end
-- Create shortcut
function gel.fw:isDev()
  return gel.Internal.Environment:isDev()
end
-- Create shortcut
function gel.fw:isPrivate()
  return gel.Internal.Environment:isPrivate()
end
-- Create shortcut
function gel.fw:isPublic()
  return gel.Internal.Environment:isPublic()
end
