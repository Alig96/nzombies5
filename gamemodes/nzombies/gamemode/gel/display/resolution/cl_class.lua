-- Make a shortcut to using this library
local defaultWidth = 1920
local defaultHeight = 1080

function gel.fw:resoloutionScale(width, height)
  return ScrW() * (width / defaultWidth), ScrH() * (height / defaultHeight)
end
