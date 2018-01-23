local chatcommandTest = GUnit.Test:new("Command > Chat")
local playerGen = GUnit.Generators.FakePlayer

local function a_chat_command_can_be_created()

  -- Create a chat command
  local chatCommand = nz.Command.Chat("new_command", function(ply, params)
    nz.Tests.valueToChange = true
  end)

  -- Assert the chat command has been created
  GUnit.assert(chatCommand.triggerSymbol):shouldEqual("/")
  GUnit.assert(chatCommand.triggerPhrase):shouldEqual("new_command")

  -- Set a valueToChange
  nz.Tests.valueToChange = false
  -- Assert it is false
  GUnit.assert(nz.Tests.valueToChange):shouldEqual(false)

  -- Trigger the chat command's customFunction
  chatCommand.customFunction(playerGen:new())

  -- Assert that the function was run and it has changed the value
  GUnit.assert(nz.Tests.valueToChange):shouldEqual(true)
end

chatcommandTest:beforeAll(function ()
  nz.Tests = {}

  -- Set it to debug mode
  nz.Debug.Environment:set(ENV_DEV)
end)
chatcommandTest:afterAll(function ()
  nz.Tests = null
end)
chatcommandTest:addSpec("can be created", a_chat_command_can_be_created)
