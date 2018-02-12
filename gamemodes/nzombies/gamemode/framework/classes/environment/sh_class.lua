environment = {}

environment.currentEnvironment = ENV_DEV

function environment:get()
  return self.currentEnvironment
end

function environment:validateInput(envNum)
  if envNum == ENV_DEV or envNum == ENV_PRIVATE or envNum == ENV_PUBLIC then
    return true
  end

  return false
end

function environment:toString(envNum)
  if envNum == nil then envNum = self:get() end

  local environmentString = "Invalid"

  if envNum == ENV_DEV then
    environmentString = "Development"
  elseif envNum == ENV_PRIVATE then
    environmentString = "Private"
  elseif envNum == ENV_PUBLIC then
    environmentString = "Public"
  end

  return environmentString
end

function environment:set(envNum)
  -- Validate the given environment number
  if self:validateInput(envNum) then
    -- Set the environment
    self.currentEnvironment = envNum
    -- Notify the console
    Log(LOG_INFO, "Environment was set to: " .. self:toString(envNum), "Framework:Environment")

    if SERVER then
      self:sync()
    end
  end

  return self:get()
end

if SERVER then
  function environment:sync()
    -- Broadcast to all players
    nz.Framework.Sync["Environment"]:broadcast()
  end
end

-- Helpers
function environment:setDev()
  return self:set(ENV_DEV)
end

function environment:setPrivate()
  return self:set(ENV_PRIVATE)
end

function environment:setPublic()
  return self:set(ENV_PUBLIC)
end

function environment:isDev()
  return self:get() == ENV_DEV
end

function environment:isPrivate()
  return self:get() == ENV_PRIVATE
end

function environment:isPublic()
  return self:get() == ENV_PUBLIC
end

-- Assign the meta table to the nz global
nz.Framework.Environment = setmetatable(environment, { __call = environment.get })
