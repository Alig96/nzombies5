local creativeModeText = "Creative Mode"
local playModeText = "Play Mode"

local function displayCurrentMode()
  local text = ""
  if nz.Mode:isCreative() then
    text = creativeModeText
  end

  if nz.Mode:isPlay() then
    text = playModeText
  end
  -- Draw it
  local font = "Arial24"
  local x = ScrW() * 0.025
  local y = 25
  local colour = nz.Display.Colours["Info"]

  draw.SimpleText(text, font, x, y, colour, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end

hook.Add("HUDPaint", "nz.Display.Hud.Mode", displayCurrentMode )
