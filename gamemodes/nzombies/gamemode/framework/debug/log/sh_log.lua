LOG_DEBUG = 0
LOG_INFO = 1
LOG_WARN = 2
LOG_ERROR = 3

local debugLog = {}
debugLog.levels = {
  [LOG_DEBUG] = nz.Framework.newLogLevel(LOG_DEBUG, "Debug", Color(3, 169, 244)),
  [LOG_INFO] = nz.Framework.newLogLevel(LOG_INFO, "Info", Color(3, 169, 244)),
  [LOG_WARN] = nz.Framework.newLogLevel(LOG_WARN, "Warning", Color(3, 169, 244)),
  [LOG_ERROR] = nz.Framework.newLogLevel(LOG_ERROR, "Error", Color(3, 169, 244)),
}

function debugLog:getLogLevelObject(logLevelId)
  if logLevelId == LOG_DEBUG or logLevelId == LOG_INFO or logLevelId == LOG_WARN or logLevelId == LOG_ERROR then
    return self.levels[logLevelId]
  end
end

function debugLog:shouldNotify(logLevelId)
  -- If we are in dev mode, then show debug messages else don't
  if logLevelId == LOG_DEBUG and !nz.Framework.Environment:isDev() then
    return false
  end

  return true
end

function debugLog:printToConsole(logObject)
  if self:shouldNotify(logObject.level.id) then
    local outputString = "[" .. logObject.level.name .. "] " .. "[" .. logObject.moduleName .. "] " .. logObject.message .. "\n"
    MsgC( logObject.level.color, outputString )
  end
end

function debugLog:log(logLevelId, logMessage, moduleName)
  -- Get the log level object
  local logLevelObject = self:getLogLevelObject(logLevelId)
  -- Create a Debug Message
  if logLevelObject then
    local logObject = nz.Framework.newLog(logLevelObject, logMessage, moduleName)
    -- Print the log message object
    self:printToConsole(logObject)

    return logObject
  end
end

-- Assign the meta table to the nz global
nz.Framework.Debug.Log = setmetatable(debugLog, { __call = debugLog.log })
-- Make a shortcut to using this library
Log = nz.Framework.Debug.Log
