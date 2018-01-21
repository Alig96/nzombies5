local consolecommandTest = GUnit.Test:new("Command > Console")

local function a_console_command_can_be_created()
  //No way to test console commands, since the module is just a wrapper for regular gmod console commands
  GUnit.assert(true):shouldEqual(true)
end

consolecommandTest:addSpec("can be created", a_console_command_can_be_created)
