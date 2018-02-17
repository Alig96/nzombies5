local prototypeHUD = {}

prototypeHUD.id = "BaseHUD"

function prototypeHUD:draw()
  local x = ScrW() / 2
  local y = ScrH() / 2
  draw.SimpleText("You must override the default 'draw' method in HUD object: " .. self.id, "Default", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

-- Register this prototype as a model
gel.fw:newModel("HUD", prototypeHUD, {"id", "draw"})
