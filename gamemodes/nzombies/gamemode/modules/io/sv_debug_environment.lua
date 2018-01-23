DebugEnvironment = {}
DebugEnvironment.__index = DebugEnvironment

local defaultEnv = {
  ["dev"] = {
    ["serverEnviroment"] = ENV_DEV
  },

  ["private"] = {
    ["serverEnviroment"] = ENV_PRIVATE
  },

  ["public"] = {
    ["serverEnviroment"] = ENV_PUBLIC
  },
}

-- Default Environment Files

function DebugEnvironment:checkDefaultEnviromentFile(selectedEnvironment)
  local filePath = "nz/env/examples/" .. selectedEnvironment .. ".txt"

  -- Check if the nz/env/envFile file exists, if not, then create it
  if !file.Exists( filePath, "DATA" ) then
    nz.Debug.Print("warning", "Enviroment File: '" .. selectedEnvironment .. "' was not found, creating from default.")
  	file.Write( filePath, util.TableToJSON( defaultEnv[selectedEnvironment] ) )
  end
end

function DebugEnvironment:checkAllDefaultEnviromentFiles()
  for selectedEnvironment, _ in pairs(defaultEnv) do
    self:checkDefaultEnviromentFile(selectedEnvironment)
  end
end

-- Current Environment File
function DebugEnvironment:loadCurrentEnviromentFile()
  local filePath = "nz/env/current_enviroment.txt"

  -- Check if the nz/env/envFile file exists, if not, then create it
  if !file.Exists( filePath, "DATA" ) then
    nz.Debug.Print("warning", "The current environment file was not found. Cloned the 'Private' environment.")
  	file.Write( filePath, util.TableToJSON( defaultEnv["private"] ) )
  end

  -- Load the environment file
  local environmentData = util.JSONToTable( file.Read( filePath, "DATA" ) )
  -- Apply the data from the file
  -- Set the server enviroment
  if environmentData["serverEnviroment"] then
    nz.Debug.Environment:set(environmentData["serverEnviroment"])
  end
end

-- Assign the meta table to the nz global
nz.IO.Environment = setmetatable( DebugEnvironment, { __call = DebugEnvironment.set } )
