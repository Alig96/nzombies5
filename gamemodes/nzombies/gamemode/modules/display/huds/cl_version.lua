local text = "v" .. NZ_VERSION

local function displayVersionNumber()
  -- Draw it
  local font = "Arial24"
  local x = ScrW() * 0.95
  local y = ScrH() * 0.03
  local colour = Color(255, 255, 255)

  draw.SimpleText(text, font, x, y, colour, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end

hook.Add("HUDPaint", "nz.Display.Hud.Version", displayVersionNumber)
