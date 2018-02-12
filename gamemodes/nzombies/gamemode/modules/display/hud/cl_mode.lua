local function displayCurrentMode()
  local text = nz.Mode:toString() .. " Mode"

  -- Draw it
  local font = "Arial24"
  local x = ScrW() * 0.025
  local y = 25
  local colour = Color(255, 255, 255)

  draw.SimpleText(text, font, x, y, colour, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end

hook.Add("HUDPaint", "nz.Display.Hud.Mode", displayCurrentMode)
