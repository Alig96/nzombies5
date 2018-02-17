local colorClass = {}

local colorModel = gel.fw:getModel("Color")

function colorClass:new(id, color)
  -- Create a new color using the color model
  local newColor = colorModel:create(id, color)
  Log(LOG_INFO, "Registered Color: " .. id, "Framework:Color")
end

function colorClass:get(id)
  -- Find the color
  local color = colorModel:find(id)
  if color then
    return color
  end

  Log(LOG_INFO, "Could not get Color: " .. id, "Framework:Color")
end

-- Assign the class table to the gel global
gel.Internal.Color = colorClass

-- Make a shortcut to using this library
function gel.fw:newColor(...)
  return gel.Internal.Color:new(...)
end

-- Make a shortcut to using this library
function gel.fw:getColor(...)
  -- Just return the color's actual color value
  return gel.Internal.Color:get(...).color
end
