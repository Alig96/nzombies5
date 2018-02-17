-- Globals
LOG_DEBUG = 0
LOG_INFO = 1
LOG_WARN = 2
LOG_ERROR = 3

-- Globals
ENV_DEV = 0
ENV_PRIVATE = 1
ENV_PUBLIC = 2

function Log(logLevelId, logMessage, moduleName)
  -- If the log library has been loaded then use that, if not just print
  -- Because we don't know if the debug library is ready or not
  if gel.Internal.Log then
    gel.Internal.Log:log(logLevelId, logMessage, moduleName)
  else
    print(logMessage)
  end
end

print("Now loading Gel Framework...")
print("  ________       .__    ___________                                                __")
print(" /  _____/  ____ |  |   \\_   _____/___________    _____   ______  _  _____________|  | __")
print("/   \\  ____/ __ \\|  |    |    __) \\_  __ \\__  \\  /     \\_/ __ \\ \\/ \\/ /  _ \\_  __ \\  |/ /")
print("\\    \\_\\  \\  ___/|  |__  |     \\   |  | \\// __ \\|  Y Y  \\  ___/\\     (  <_> )  | \\/    <")
print(" \\______  /\\___  >____/  \\___  /   |__|  (____  /__|_|  /\\___  >\\/\\_/ \\____/|__|  |__|_ \\")
print("        \\/     \\/            \\/               \\/      \\/     \\/                        \\/")

-- Critical
-- Load the framework's string library
gel.fw:loadDirectory("nzombies/gamemode/framework/critical/string")
-- Load the framework's database library
gel.fw:loadDirectory("nzombies/gamemode/framework/critical/database")
-- Load the framework's model library
gel.fw:loadDirectory("nzombies/gamemode/framework/critical/model")
-- Load the framework's debug library
gel.fw:loadDirectory("nzombies/gamemode/framework/critical/debug")

-- Core
-- Load the framework's core library
gel.fw:loadDirectory("nzombies/gamemode/framework/core")

-- Classes
-- Load the framework's additional class libraries
gel.fw:loadDirectory("nzombies/gamemode/framework/classes")

-- Display
-- Load the display classes
gel.fw:loadDirectory("nzombies/gamemode/framework/display")
