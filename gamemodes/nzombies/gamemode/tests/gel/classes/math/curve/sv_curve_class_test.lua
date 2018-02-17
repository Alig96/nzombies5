local controllerClassTest = GUnit.Test:new("[Framework] Math > Curve")

local function can_make_a_exponential_curve()
  local newExponentialCurve = gel.fw:newCurve("Exponential", 5, 2)
  -- Assert the curve works
  GUnit.assert(newExponentialCurve:calculateY(0)):shouldEqual(5)
  GUnit.assert(newExponentialCurve:calculateY(1)):shouldEqual(10)
end

local function can_make_a_sinusoidal_curve()
  local newSinusoidalCurve = gel.fw:newCurve("Sinusoidal", 5)
  -- Assert the curve works
  --GUnit.assert(newExponentialCurve:calculateY(0)):shouldEqual(5)
  --GUnit.assert(newExponentialCurve:calculateY(1)):shouldEqual(10)
end

controllerClassTest:addSpec("can make a exponential curve", can_make_a_exponential_curve)
controllerClassTest:addSpec("can make a sinusoidal curve", can_make_a_sinusoidal_curve)
