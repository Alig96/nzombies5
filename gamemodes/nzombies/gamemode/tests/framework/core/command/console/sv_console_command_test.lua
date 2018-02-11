local consoleCommandTest = GUnit.Test:new("[Framework] Command > ConsoleCommand")

local function a_console_command_can_be_created()

  -- Create a console command
  local consoleCommand = nz.Framework.newConsoleCommand("new_command", function(params)
    nz.Tests.valueToChange = true
  end)

  -- Assert the console command has been created
  GUnit.assert(consoleCommand.triggerSymbol):shouldEqual("")
  GUnit.assert(consoleCommand.triggerPhrase):shouldEqual("new_command")

  -- Set a valueToChange
  nz.Tests.valueToChange = false
  -- Assert it is false
  GUnit.assert(nz.Tests.valueToChange):shouldEqual(false)

  -- Trigger the console command's customFunction
  consoleCommand.onCalled()

  -- Assert that the function was run and it has changed the value
  GUnit.assert(nz.Tests.valueToChange):shouldEqual(true)
end

consoleCommandTest:beforeAll(function ()
  nz.Tests = {}

  -- Set it to debug mode
  nz.Framework.Environment:setDev()
end)

consoleCommandTest:afterAll(function ()
  nz.Tests = null
end)

consoleCommandTest:addSpec("can be created", a_console_command_can_be_created)
