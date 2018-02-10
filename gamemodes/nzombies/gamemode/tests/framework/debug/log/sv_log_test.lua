local debugLogTest = GUnit.Test:new("[Framework] Debug > Log")
local moduleName = "Tests:Framework:Debug:Log"

local function can_log_a_debug_message()
  local debugLogLevel = LOG_DEBUG
  local debugLogObject = Log(debugLogLevel, "Test", moduleName)

  -- Assert that it is the correct format
  GUnit.assert(debugLogObject.message):shouldEqual("Test")
end

debugLogTest:addSpec("can log a debug message", can_log_a_debug_message)

local function can_log_a_info_message()
  local debugLogLevel = LOG_INFO
  local debugLogObject = Log(debugLogLevel, "Test", moduleName)

  -- Assert that it is the correct format
  GUnit.assert(debugLogObject.message):shouldEqual("Test")
end

debugLogTest:addSpec("can log a info message", can_log_a_info_message)

local function can_log_a_warning_message()
  local debugLogLevel = LOG_WARN
  local debugLogObject = Log(debugLogLevel, "Test", moduleName)

  -- Assert that it is the correct format
  GUnit.assert(debugLogObject.message):shouldEqual("Test")
end

debugLogTest:addSpec("can log a warning message", can_log_a_warning_message)

local function can_log_a_error_message()
  local debugLogLevel = LOG_ERROR
  local debugLogObject = Log(debugLogLevel, "Test", moduleName)

  -- Assert that it is the correct format
  GUnit.assert(debugLogObject.message):shouldEqual("Test")
end

debugLogTest:addSpec("can log a error message", can_log_a_error_message)
