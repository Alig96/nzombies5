Curve = {}
Curve.__index = Curve
//Curve
Curve.Base = 5
Curve.Difficulty = 1.01
//Max
Curve.Max = 100

function Curve:calculateCurve( currentRound )
  return math.Round(self.Base * math.pow(currentRound, self.Difficulty))
end

function Curve:new( base, difficulty, max )
  //Check they have inputed variables
  self.Base = base or self.Base
  self.Difficulty = difficulty or self.Difficulty
  self.Max = max or self.Max

  //Generate the Curve Data
  local curveData = {}
  for i = 1, self.Max do
    curveData[i] = self:calculateCurve(i)
  end

  return curveData
end

//Assign the meta table to the nz global
nz.Curve = setmetatable( Curve, { __call = Curve.new } )
