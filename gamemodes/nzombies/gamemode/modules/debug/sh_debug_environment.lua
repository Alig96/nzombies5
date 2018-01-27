DebugEnvironment = {}
DebugEnvironment.__index = DebugEnvironment

function DebugEnvironment:set( envNum )
  if envNum == ENV_DEV or envNum == ENV_PRIVATE or envNum == ENV_PUBLIC then
    nz.Debug.CurrentEnvironment = envNum

    local environmentString = "null"
    if envNum == ENV_DEV then
      environmentString = "Development"
    elseif envNum == ENV_PRIVATE then
      environmentString = "Private"
    elseif envNum == ENV_PUBLIC then
      environmentString = "Public"
    end

    nz.Debug.Print("success", "[Environment] Environment was set to: " .. environmentString)
    if SERVER then
      -- Broadcast it to all players
      nz.Broadcast("sendDebugEnviroment")
    end
  end

  return nz.Debug.CurrentEnvironment
end

function DebugEnvironment:get()
  return nz.Debug.CurrentEnvironment
end

-- Helpers
function DebugEnvironment:isDev()
  return self.get() == ENV_DEV
end

function DebugEnvironment:isPrivate()
  return self.get() == ENV_PRIVATE
end

function DebugEnvironment:isPublic()
  return self.get() == ENV_PUBLIC
end

-- Assign the meta table to the nz global
nz.Debug.Environment = setmetatable( DebugEnvironment, { __call = DebugEnvironment.set } )
