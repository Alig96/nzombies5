local commandModelTest = GUnit.Test:new("[Framework] Models > Command")

local function can_create_command_model()
  local newCommand = nz.Framework.newCommand()

  -- Get the current environment & assert that its still public
  GUnit.assert(newCommand.triggerPhrase):shouldEqual("trigger")
end

commandModelTest:addSpec("can create command model", can_create_command_model)
