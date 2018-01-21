DebugPrint = {}
DebugPrint.__index = DebugPrint

//https://materialuicolors.co/
local colours = {
  primary = Color( 156, 39, 17 ),
  success = Color( 76, 175, 80 ),
  info = Color( 3, 169, 244 ),
  warning = Color( 255, 87, 34 ),
  danger = Color( 244, 67, 54 ),
}

function DebugPrint:new( level, text )
  if nz.Debug.Environment:isDev() then
    local levelPrint = level:gsub("^%l", string.upper)
    local outputString = "[" .. levelPrint .. "] " .. text .. "\n"
    MsgC( colours[level], outputString )

    return outputString
  end
end

//Assign the meta table to the nz global
nz.Debug.Print = setmetatable( DebugPrint, { __call = DebugPrint.new } )
