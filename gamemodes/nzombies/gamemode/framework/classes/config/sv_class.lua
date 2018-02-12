config = {}

config.filePath = "nz/server.txt"
config.default = {
  server = {
    enviroment = ENV_PRIVATE,
    name = "nZombies Server " .. NZ_VERSION
  }
}

config.current = table.Copy(config.default)

function config:writeDefaultToFile()
  -- Write the default configuration to disk
  nz.Framework.IO:writeTableToFile(self.filePath, self.default)
end

function config:loadFromFile()

  -- Check our config file exists, if not then write the default
  if !file.Exists(self.filePath, "DATA") then
    Log(LOG_WARN, "The server configuration file was not found. Cloning the default configuration.", "Framework:Config")
    self:writeDefaultToFile()
  end

  -- Read the configuration and then apply it
  local configData = nz.Framework.IO:readTableFromFile(self.filePath)
  Log(LOG_INFO, "Loaded Server Configuration file", "Framework:Config")
  self:apply(configData)
end

function config:apply(configData)
  table.Merge(self.current, configData)
  Log(LOG_INFO, "Applied Configuration data", "Framework:Config")
end

function config:get(realm, variableKey)
  local configData = config.current[realm][variableKey]

  if configData then
    return configData
  end

  Log(LOG_ERROR, "Could not find Config value: " .. variableKey, "Framework:Config")
end

-- Assign the meta table to the nz global
nz.Framework.Config = setmetatable(config, { __call = config.get })
