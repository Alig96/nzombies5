-- Create the font
gel.fw:newFont("Helvetica")

-- Get and edit the font
local fontObject = gel.fw:getFont("Helvetica")
fontObject.size = 20
fontObject.weight = 900
fontObject.underline = true
 -- Use the generate option to register the font
local fontName = fontObject:generate()

-- Use the color libary
local orange = gel.fw:getColor("orange")

-- Test
local text = "v" .. NZ_VERSION

local function displayVersionNumber()
  -- Draw it
  local x = ScrW() / 2
  local y = ScrH() / 2

  draw.SimpleText(text, fontName, x, y, orange, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

hook.Add("HUDPaint", "nz.Display.Hud.Version", displayVersionNumber)
