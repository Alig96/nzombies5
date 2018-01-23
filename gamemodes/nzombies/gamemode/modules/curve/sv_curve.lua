Curve = {}
Curve.__index = Curve
-- Curve
Curve.Base = 5
Curve.Difficulty = 1.01

function Curve:calculatePointOnCurve( currentPoint )
  return math.Round(self.Base * math.pow(currentPoint, self.Difficulty))
end

function Curve:new( base, difficulty )
  -- Create a new curve
  local newCurve = table.Copy( Curve )
  -- Remove the meta data
  newCurve.new = null
  newCurve.__index = null

  -- Check they have inputed variables
  newCurve.Base = base or self.Base
  newCurve.Difficulty = difficulty or self.Difficulty

  return newCurve
end

-- Assign the meta table to the nz global
nz.Curve.Create = setmetatable( Curve, { __call = Curve.new } )
