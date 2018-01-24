local function displayVersionNumber()
  local text = "v" .. NZ_VERSION

  -- Draw it
  local font = "Arial24"
  local x = ScrW() * 0.95
  local y = ScrH() * 0.05
  local colour = nz.Display.Colours["White"]
  draw.SimpleText(text, font, x, y, colour, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end

hook.Add("HUDPaint", "nz.Display.Hud.Version", displayVersionNumber )
