local chatCommand = {}
chatCommand.commands = {}

function chatCommand:addToListener(chatCommandObject)
  local chatHookString = chatCommandObject.triggerSymbol .. chatCommandObject.triggerPhrase

  chatCommand.commands[chatHookString] = chatCommandObject

  Log(LOG_INFO, "Added Command: " .. chatHookString, "Framework:Command:ChatCommand")
end

function chatCommand:new(triggerPhrase, customFunction, triggerSymbol)
  -- Create a new command model
  local newChatCommandObject = nz.Framework.newCommand(triggerPhrase, customFunction, triggerSymbol)
  -- Add the new chat command to the listener
  self:addToListener(newChatCommandObject)

  return newChatCommandObject
end

-- Assign the meta table to the nz global
nz.Framework.Command.Chat = setmetatable(chatCommand, { __call = chatCommand.new })
-- Make a shortcut to using this library
nz.Framework.newChatCommand = nz.Framework.Command.Chat
