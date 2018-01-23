local curveTest = GUnit.Test:new("Curve")

local function a_default_curve_can_be_created()
  -- Create a curve
  local newCurve = nz.Curve.Create()

  -- Calculate the first point on the curve
  -- Since we used default curve, it should equal 5
  GUnit.assert(newCurve:calculatePointOnCurve(1)):shouldEqual(5)
  -- Calculate the 100th point on the curve
  -- Since we used default curve, it should equal 524
  GUnit.assert(newCurve:calculatePointOnCurve(100)):shouldEqual(524)
end

local function a_custom_curve_can_be_created()
  -- Create a curve
  local newCurve = nz.Curve.Create(75, 0.4)

  -- Calculate the first point on the curve
  GUnit.assert(newCurve:calculatePointOnCurve(1)):shouldEqual(75)
  -- Calculate the 100th point on the curve
  GUnit.assert(newCurve:calculatePointOnCurve(100)):shouldEqual(473)
end

curveTest:addSpec("default can be created", a_default_curve_can_be_created)
curveTest:addSpec("custom can be created", a_custom_curve_can_be_created)
