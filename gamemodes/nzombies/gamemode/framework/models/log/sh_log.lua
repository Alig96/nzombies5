local prototypeLog = {}

prototypeLog.level = {}
prototypeLog.moduleName = "General"
prototypeLog.message = "Ooops. Something went wrong."

-- Register this prototype as a model
nz.Framework.registerModel(prototypeLog, "Log", {"level", "message", "moduleName"})
