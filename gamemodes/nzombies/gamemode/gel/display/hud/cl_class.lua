local hudClass = {}

local hudModel = gel.fw:getModel("HUD")

function hudClass:new(id, drawFunc, shouldDrawFunc)
  -- Create a new hud using the model
  local newHUD = hudModel:create(id, drawFunc, shouldDrawFunc)
  -- Register it with the hook
  hook.Add("HUDPaint", "gel.Display.HUD." .. id, function()
    if newHUD:shouldDraw() then
      newHUD:draw()
    end
  end)
  -- Notify
  Log(LOG_INFO, "Successfully created HUD: " .. newHUD.id, "Framework:HUD")
  -- Return the finished hud object from the database
  return hudModel:find(newHUD.id)
end

-- Assign the class table to the gel global
gel.Internal.HUD = hudClass

-- Make a shortcut to using this library
function gel.fw:newHUD(...)
  return gel.Internal.HUD:new(...)
end
