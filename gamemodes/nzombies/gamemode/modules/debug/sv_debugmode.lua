DebugMode = {}
DebugMode.__index = DebugMode

function DebugMode:set( bool )
  if isbool(bool) then
    nz.Debug.CurrentMode = bool
  end

  return nz.Debug.CurrentMode
end

function DebugMode:get()
  if nz.Debug.CurrentMode == null then
    nz.Debug.CurrentMode = true
  end

  return nz.Debug.CurrentMode
end

function DebugMode:isDev()
  return self.get() == true
end

function DebugMode:isProd()
  return self.get() == false
end

//Assign the meta table to the nz global
nz.Debug.Mode = setmetatable( DebugMode, { __call = DebugMode.set } )
