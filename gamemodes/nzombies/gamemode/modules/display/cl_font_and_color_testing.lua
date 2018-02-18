-- Get and edit the font
local helvetica = gel.fw:getFont("Helvetica")

 -- Use the generate option to register the font
helvetica.size = 20
helvetica.weight = 900
local helvetica20 = helvetica:generate()
-- Use the generate option to register the font
helvetica.size = 40
helvetica.italic = true
local helvetica40Italic = helvetica:generate()
-- Use the color libary
local color = gel.fw:getColor("primary")

-- Test
local text = "v" .. NZ_VERSION

gel.fw:newHUD("VersionNumber", function()
  -- Draw it
  local x = ScrW() / 2
  local y = ScrH() / 2

  draw.SimpleText(text, helvetica20, x, y, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  draw.SimpleText(gel.fw:translate("welcome"), helvetica40Italic, x, y + 100, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)
