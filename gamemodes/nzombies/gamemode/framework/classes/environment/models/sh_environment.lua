local prototypeEnvironment = {}

prototypeEnvironment.id = 0
prototypeEnvironment.name = "Base Environment"

-- Register this prototype as a model
gel.fw:newModel("Environment", prototypeEnvironment, {"id", "name"})
