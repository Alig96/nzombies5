DebugMode = {}
DebugMode.__index = DebugMode

function DebugMode:set( bool )
  if isbool(bool) then
    nz.Debug.CurrentMode = bool
  end

  return nz.Debug.CurrentMode
end

function DebugMode:get()
  return nz.Debug.CurrentMode
end

function DebugMode:isDev()
  return nz.Debug.CurrentMode == true
end

function DebugMode:isProd()
  return nz.Debug.CurrentMode == false
end

//Assign the meta table to the nz global
nz.Debug.Mode = setmetatable( DebugMode, { __call = DebugMode.set } )
