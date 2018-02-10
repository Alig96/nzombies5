local logLevelModelTest = GUnit.Test:new("[Framework] Models > LogLevel")

local function can_create_log_level_model()
  local newLogLevel = nz.Framework.newLogLevel()

  -- Assert it has the defaults of the model.
  GUnit.assert(newLogLevel.name):shouldEqual("defaultLogLevelName")
end

logLevelModelTest:addSpec("can create log level model", can_create_log_level_model)
