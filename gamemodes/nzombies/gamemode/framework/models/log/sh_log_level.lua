local prototypeLogLevel = {}

prototypeLogLevel.id = 0
prototypeLogLevel.name = "defaultLogLevelName"
prototypeLogLevel.color = Color(3, 169, 244)

-- Register this prototype as a model
nz.Framework.registerModel(prototypeLogLevel, "LogLevel", {"id", "name", "color"})
