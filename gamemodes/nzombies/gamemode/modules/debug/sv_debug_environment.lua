DebugEnvironment = {}
DebugEnvironment.__index = DebugEnvironment

function DebugEnvironment:set( envNum )
  if envNum == ENV_DEV or envNum == ENV_PRIVATE or envNum == ENV_PUBLIC then
    nz.CurrentEnvironment = envNum
  end

  return nz.CurrentEnvironment
end

function DebugEnvironment:get()
  return nz.CurrentEnvironment
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
