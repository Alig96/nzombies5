local text = "nZombies is running in Development Mode."

local function displayDevEnvironmentMessage()
  -- Draw it
  local font = "Arial24"
  local x = ScrW() * 0.025
  local y = ScrH() * 0.975
  local colour = Color(255, 255, 255)

  if nz.Framework.Environment:isDev() then
    draw.SimpleText(text, font, x, y, colour, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
  end
end

hook.Add("HUDPaint", "nz.Display.Hud.Environment", displayDevEnvironmentMessage)
