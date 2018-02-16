local logClass = {}
local logLevelModel = gel.fw:getModel("LogLevel")
local logModel = gel.fw:getModel("Log")

function logClass:createLogLevels()
  if self.levels == nil then
    self.levels = {
      [LOG_DEBUG] = logLevelModel:make(LOG_DEBUG, "Debug", Color(52, 152, 219)),
      [LOG_INFO] = logLevelModel:make(LOG_INFO, "Info", Color(39, 174, 96)),
      [LOG_WARN] = logLevelModel:make(LOG_WARN, "Warning", Color(211, 84, 0)),
      [LOG_ERROR] = logLevelModel:make(LOG_ERROR, "Error", Color(192, 57, 43)),
    }
  end
end

function logClass:getLogLevel(logLevelId)
  if logLevelId == LOG_DEBUG or logLevelId == LOG_INFO or logLevelId == LOG_WARN or logLevelId == LOG_ERROR then
    return self.levels[logLevelId]
  end
end

function logClass:shouldNotify(logLevelId)
  -- If the Environment library is loaded then we should check if we should log or not
  if gel.Internal.Environment then
    if logLevelId == LOG_DEBUG and !gel.fw:isDev() then
      return false
    end
  end
  return true
end

function logClass:printToConsole(logObject)
  if self:shouldNotify(logObject.level.id) then
    local outputString = "[" .. logObject.level.name .. "] " .. "[" .. logObject.moduleName .. "] " .. logObject.message .. "\n"
    MsgC(logObject.level.color, outputString)
  end
end

function logClass:log(logLevelId, logMessage, moduleName)
  -- Incase we haven't made them
  self:createLogLevels()

  -- Get the log level object
  local logLevel = self:getLogLevel(logLevelId)
  -- Create a Debug Message
  if logLevel then
    local log = logModel:make(logLevel, logMessage, moduleName)

    -- Print the log object
    self:printToConsole(log)
  end
end

-- Assign the table to the global
gel.Internal.Log = logClass
