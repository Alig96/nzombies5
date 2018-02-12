local environmentTest = GUnit.Test:new("[Framework] Config")

local function can_get_config_variable()
  local configData = nz.Framework.Config("server", "name")

  GUnit.assert(configData):isNotNil()
end

environmentTest:addSpec("can get a config variable", can_get_config_variable)
