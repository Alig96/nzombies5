local prototypeMode = {}

prototypeMode.id = 0
prototypeMode.name = "BaseMode"

-- Register this prototype as a model
nz.Framework.registerModel(prototypeMode, "Mode", {"id", "name"})
