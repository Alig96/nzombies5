local prototypeCurve = {}

prototypeCurve.base = 5
prototypeCurve.difficulty = 1.01

function prototypeCurve:calculatePointOnCurve(currentPoint)
  return math.Round(self.base * math.pow(currentPoint, self.difficulty))
end

-- Register this prototype as a model
nz.Framework.registerModel(prototypeCurve, "Curve", {"base", "difficulty"})
