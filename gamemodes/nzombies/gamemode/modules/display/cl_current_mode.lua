-- Get and edit the font
local helvetica = gel.fw:getFont("Helvetica")
 -- Use the generate option to register the font
helvetica.size = 20
helvetica.weight = 900
local helvetica20 = helvetica:generate()

-- Use the color libary
local color = gel.fw:getColor("primary")

gel.fw:newHUD("CurrentMode", function()
  local text = nz.Mode:get().name .. " Mode"
  -- Draw it
  local x = ScrW() / 2
  local y = ScrH() / 2

  draw.SimpleText(text, helvetica20, x, y - 100, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)
