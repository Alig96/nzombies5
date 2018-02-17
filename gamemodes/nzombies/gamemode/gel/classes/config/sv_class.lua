local configClass = {}
configClass.filePath = "server.txt"

configClass.default = {
  server = {
    enviroment = ENV_PRIVATE,
  }
}

configClass.current = table.Copy(configClass.default)

function configClass:setDefault(filePath, defaultConfig)
  self.filePath = filePath
  self.default = defaultConfig
  self.current = defaultConfig
end

function configClass:writeDefaultToFile()
  -- Write the default configuration to disk
  gel.fw:writeTableToFile(self.filePath, self.default)
end

function configClass:loadFromFile()
  -- Check our config file exists, if not then write the default
  if !file.Exists(self.filePath, "DATA") then
    Log(LOG_WARN, "The server configuration file was not found. Cloning the default configuration.", "Framework:Config")
    self:writeDefaultToFile()
  end

  -- Read the configuration and then apply it
  local configData = gel.fw:readTableFromFile(self.filePath)
  Log(LOG_INFO, "Loaded Server Configuration file", "Framework:Config")
  self:apply(configData)
end

function configClass:apply(configData)
  table.Merge(self.current, configData)
  Log(LOG_INFO, "Applied Configuration data", "Framework:Config")
end

function configClass:getValue(realm, variableKey)
  local configData = self.current[realm][variableKey]

  if configData then
    return configData
  end

  Log(LOG_ERROR, "Could not find Config value: " .. variableKey, "Framework:Config")
end

-- Assign the class table to the gel global
gel.Internal.Config = configClass

-- Create shortcut
function gel.fw:getConfigValue(...)
  return gel.Internal.Config:getValue(...)
end

-- Create shortcut
function gel.fw:setConfig(...)
  return gel.Internal.Config:setDefault(...)
end

-- Create shortcut
function gel.fw:loadConfig()
  return gel.Internal.Config:loadFromFile()
end
