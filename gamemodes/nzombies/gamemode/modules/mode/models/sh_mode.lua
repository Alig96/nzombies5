local prototypeMode = {}

prototypeMode.id = 0
prototypeMode.name = "BaseMode"

-- Register this prototype as a model
gel.fw:newModel("Mode", prototypeMode, {"id", "name"})
