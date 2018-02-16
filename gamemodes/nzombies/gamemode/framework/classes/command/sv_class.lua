local commandClass = {}
commandClass.chatCommands = {}

local commandModel = gel.fw:getModel("Command")

function commandClass:newConsoleCommand(triggerPhrase, customFunction, triggerSymbol)
  -- Make a new console command using the command model
  local newConsoleCommand = commandModel:make(triggerPhrase, customFunction, triggerSymbol or "")
  local commandActivationString = newConsoleCommand.triggerSymbol .. newConsoleCommand.triggerPhrase
  -- Invoke the regular gmod console command lib
  concommand.Add(commandActivationString, newConsoleCommand.onCalled)
  Log(LOG_INFO, "Registered Console Command: " .. commandActivationString, "Framework:Command")
end

function commandClass:newChatCommand(triggerPhrase, customFunction, triggerSymbol)
  -- Make a new chat command using the command model
  local newChatCommand = commandModel:make(triggerPhrase, customFunction, triggerSymbol)
  local commandActivationString = newChatCommand.triggerSymbol .. newChatCommand.triggerPhrase
  -- Save the chat command to the listener
  self.chatCommands[commandActivationString] = newChatCommand
  Log(LOG_INFO, "Registered Chat Command: " .. commandActivationString, "Framework:Command")
end

-- Assign the class table to the gel global
gel.Internal.Command = commandClass

-- Make a shortcut to using this library
function gel.fw:newCommand(type, ...)
  if type == "Console" then
    gel.Internal.Command:newConsoleCommand(...)
  elseif type == "Chat" then
    gel.Internal.Command:newChatCommand(...)
  else
    Log(LOG_ERROR, "No Command type of: " .. type, "gel:Command")
  end
end
