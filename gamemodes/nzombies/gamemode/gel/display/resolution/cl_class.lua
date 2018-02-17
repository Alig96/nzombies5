-- Make a shortcut to using this library
local defaultWidth = 1920
local defaultHeight = 1080
local scaleWidth = ScrW() / defaultWidth
local scaleHeight = ScrH() / defaultHeight

function gel.fw:resoloutionScale()
  return scaleWidth, scaleHeight
end
