local chatCommandTest = GUnit.Test:new("[Framework] Command > ChatCommand")
local playerGen = GUnit.Generators.FakePlayer

local function a_chat_command_can_be_created()

  -- Create a chat command
  local chatCommand = nz.Framework.newChatCommand("new_command", function(ply, params)
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
  chatCommand.onCalled(playerGen:new())

  -- Assert that the function was run and it has changed the value
  GUnit.assert(nz.Tests.valueToChange):shouldEqual(true)
end

chatCommandTest:beforeAll(function ()
  nz.Tests = {}

  -- Set it to dev mode
  nz.Framework.Environment:setDev()
end)

chatCommandTest:afterAll(function ()
  nz.Tests = null
end)

chatCommandTest:addSpec("can be created", a_chat_command_can_be_created)
