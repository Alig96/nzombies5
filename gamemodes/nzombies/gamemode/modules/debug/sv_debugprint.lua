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
  if nz.Debug.Mode:isDev() then
    local levelPrint = level:gsub("^%l", string.upper)
    MsgC( colours[level], "[" .. levelPrint .. "] " .. text .. "\n" )
  end
end

//Test all colours at once
function DebugPrint:test()
  for k, v in pairs(colours) do
    nz.Debug.Print(k, "This is a " .. k .. " test")
  end
end

//Assign the meta table to the nz global
nz.Debug.Print = setmetatable( DebugPrint, { __call = DebugPrint.new } )
