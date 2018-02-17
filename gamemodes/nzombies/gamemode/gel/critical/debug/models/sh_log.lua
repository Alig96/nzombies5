local prototypeLog = {}

prototypeLog.level = {}
prototypeLog.moduleName = "GM"
prototypeLog.message = "Ooops. Something went wrong."

-- Register this prototype as a model
gel.fw:newModel("Log", prototypeLog, {"level", "message", "moduleName"})
