local debugEnvironmentTest = GUnit.Test:new("IO > Debug Enviroment")

debugEnvironmentTest:beforeAll(function ()
  -- Set it to debug mode
  nz.Debug.Environment:set(ENV_DEV)
end)

local function default_environment_files_can_be_checked()
  local paths = {
    ["dev"] = "nz/env/examples/dev.txt",
    ["private"] = "nz/env/examples/private.txt",
    ["public"] = "nz/env/examples/public.txt",
  }

  -- Delete all the defaults
  for _, path in pairs (paths) do
    file.Delete(path)
  end

  -- Assert they're all gone
  for _, path in pairs (paths) do
    GUnit.assert(file.Exists(path, "DATA" )):shouldEqual(false)
  end

  -- Check all the default files
  nz.IO.Environment:checkAllDefaultEnviromentFiles()
  -- Assert that they are all there now
  for _, path in pairs (paths) do
    GUnit.assert(file.Exists(path, "DATA" )):shouldEqual(true)
  end
end

local function the_current_enviroment_file_can_be_loaded()
  -- Assert that the current enviroment is dev
  GUnit.assert(nz.Debug.Environment:isDev()):shouldEqual(true)

  -- Make a copy of the current enviroment file (if there is one) & delete the current environment file it
  local currentFilePath = "nz/env/current_enviroment.txt"
  local backupFilePath = "nz/env/backup_current_enviroment.txt"
  if file.Exists( currentFilePath, "DATA" ) then
    file.Write( backupFilePath, file.Read( currentFilePath, "DATA" ) )
    file.Delete( currentFilePath )
  end

  -- Load the current enviroment file
  nz.IO.Environment:loadCurrentEnviromentFile()
  -- Assert that the current enviroment file exists
  GUnit.assert(file.Exists( currentFilePath, "DATA" )):shouldEqual(true)
  -- Assert that the current enviroment is now the default of private
  GUnit.assert(nz.Debug.Environment:isPrivate()):shouldEqual(true)

  -- Copy the environment file back (if we have a backup) & delete the backup
  if file.Exists( backupFilePath, "DATA" ) then
    file.Write( currentFilePath, file.Read( backupFilePath, "DATA" ) )
    file.Delete( backupFilePath )
  end
end

debugEnvironmentTest:addSpec("the default environment files are checked", default_environment_files_can_be_checked)
debugEnvironmentTest:addSpec("the current enviroment file can be loaded", the_current_enviroment_file_can_be_loaded)
