local curveClass = {}

local curveModel = gel.fw:getModel("Curve")

function curveClass:newExponentialCurve(base, growthRate)
  -- Make a new exponential curve using the curve model
  local newExponentialCurve = curveModel:make({base = base, growthRate = growthRate})

  function newExponentialCurve:calculateY(x)
    return self.constants.base * math.pow(self.constants.growthRate, x)
  end
  -- Return it
  return newExponentialCurve
end

function curveClass:newSinusoidalCurve(height, frequency, shift)
  -- Make a new Sinusoidal curve using the curve model
  local newSinusoidalCurve = curveModel:make({height = height or 1, frequency = frequency or 1, shift = shift or 0})

  function newSinusoidalCurve:calculateY(x)
    local amplitude = self.constants.height
    local c = self.constants.shift
    return amplitude * math.sin((x * self.constants.frequency) + c)
  end

  -- Return it
  return newSinusoidalCurve
end


-- Assign the class table to the gel global
gel.Internal.Curve = curveClass

-- Make a shortcut to using this library
function gel.fw:newCurve(type, ...)
  if type == "Exponential" then
    return gel.Internal.Curve:newExponentialCurve(...)
  elseif type == "Sinusoidal" then
    return gel.Internal.Curve:newSinusoidalCurve(...)
  else
    Log(LOG_ERROR, "No Curve type of: " .. type, "gel:Curve")
  end
end
