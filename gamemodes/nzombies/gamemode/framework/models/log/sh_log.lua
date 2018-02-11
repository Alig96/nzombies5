local prototypeLog = {}

prototypeLog.level = {}
prototypeLog.moduleName = "GM"
prototypeLog.message = "Ooops. Something went wrong."

-- Register this prototype as a model
nz.Framework.registerModel(prototypeLog, "Log", {"level", "message", "moduleName"})
