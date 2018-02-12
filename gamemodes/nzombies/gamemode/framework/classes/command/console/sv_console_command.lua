local consoleCommand = {}
consoleCommand.commands = {}

function consoleCommand:addToListener(consoleCommandObject)
  local consoleHookString = consoleCommandObject.triggerSymbol .. consoleCommandObject.triggerPhrase

  -- Invoke the regular gmod console command lib
  concommand.Add(consoleHookString, consoleCommandObject.onCalled)

  Log(LOG_INFO, "Added Command: " .. consoleHookString, "Framework:Command:ConsoleCommand")
end

function consoleCommand:new(triggerPhrase, customFunction, triggerSymbol)
  -- Create a new command model (if we don't give a trigger symbol, make it an empty string)
  local newConsoleCommandObject = nz.Framework.newCommand(triggerPhrase, customFunction, triggerSymbol or "")
  -- Add the new console command to the listener
  self:addToListener(newConsoleCommandObject)

  return newConsoleCommandObject
end

-- Assign the meta table to the nz global
nz.Framework.Command.Console = setmetatable(consoleCommand, { __call = consoleCommand.new })
-- Make a shortcut to using this library
nz.Framework.newConsoleCommand = nz.Framework.Command.Console
