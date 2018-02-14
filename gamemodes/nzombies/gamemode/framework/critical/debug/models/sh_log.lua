local prototypeLog = {}

prototypeLog.level = {}
prototypeLog.moduleName = "GM"
prototypeLog.message = "Ooops. Something went wrong."

-- Register this prototype as a model
gel.Internal.Model:new("Log", prototypeLog, {"level", "message", "moduleName"})
