local function displayVersionNumber()
  local text = "v" .. NZ_VERSION

  -- Draw it
  local font = "Arial24"
  local x = ScrW() * 0.95
  local y = ScrH() * 0.03
  local colour = nz.Display.Colours["White"]
  if globalScoreboard and globalScoreboard:IsVisible() then
    draw.SimpleText(text, font, x, y, colour, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
  end
end

hook.Add("HUDPaint", "nz.Display.Hud.Version", displayVersionNumber )
