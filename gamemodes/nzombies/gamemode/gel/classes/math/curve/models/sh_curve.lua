local prototypeCurve = {}

prototypeCurve.constants = {}

function prototypeCurve:calculateY(x)
  return 0
end

-- Register this prototype as a model
gel.fw:newModel("Curve", prototypeCurve, {"constants"})
