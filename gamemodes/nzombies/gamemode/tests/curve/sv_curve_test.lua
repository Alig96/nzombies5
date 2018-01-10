local curveTest = GUnit.Test:new("Curve")

local function a_default_curve_can_be_created()
  //Create a curve
  local curveData = nz.Curve()

  //Since we used default curve, it should equal 5
  GUnit.assert(curveData[1]):shouldEqual(5)
  GUnit.assert(curveData[100]):shouldEqual(524)
end

local function a_custom_curve_can_be_created()
  //Create a curve
  local curveData = nz.Curve(75, 0.4)

  //Since we inputed our own curve data, the inital item should be 75
  GUnit.assert(curveData[1]):shouldEqual(75)
  GUnit.assert(curveData[100]):shouldEqual(473)
end

curveTest:addSpec("default can be created", a_default_curve_can_be_created)
curveTest:addSpec("custom can be created", a_custom_curve_can_be_created)
