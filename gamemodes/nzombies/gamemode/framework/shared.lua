-- Framework
gel = {}
-- Internal
gel.Internal = {}
-- External
gel.fw = {}

-- Globals
LOG_DEBUG = 0
LOG_INFO = 1
LOG_WARN = 2
LOG_ERROR = 3

function Log(logLevelId, logMessage, moduleName)
  -- If the log library has been loaded then use that, if not just print
  -- Because we don't know if the debug library is ready or not
  if gel.Internal.Log then
    gel.Internal.Log:log(logLevelId, logMessage, moduleName)
  else
    print(logMessage)
  end
end

-- Load the framework's string library
realmLoader("nzombies/gamemode/framework/critical/string")
-- Load the framework's database library
realmLoader("nzombies/gamemode/framework/critical/database")
-- Load the framework's model library
realmLoader("nzombies/gamemode/framework/critical/model")
-- Load the framework's debug library
realmLoader("nzombies/gamemode/framework/critical/debug")
