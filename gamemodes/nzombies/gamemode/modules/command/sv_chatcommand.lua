ChatCommand = {}
ChatCommand.__index = ChatCommand
ChatCommand.defaultTriggerSymbol = "/"
ChatCommand.defaultTriggerPhrase = "hi"
ChatCommand.defaultFunction = function() end

function ChatCommand:new( triggerPhrase, customFunction, triggerSymbol )
  local newChatCommand = {
    triggerPhrase = triggerPhrase or self.defaultTriggerPhrase ,
    customFunction = customFunction or self.defaultFunction,
    triggerSymbol = triggerSymbol or self.defaultTriggerSymbol,
  }
  //Set it as a meta table
  setmetatable( newChatCommand, ChatCommand )

  //Add it to the listener
  self:addToListener(newChatCommand)

  return newChatCommand
end

function ChatCommand:addToListener( chatCommand )
  if nz.Command.ChatListener[chatCommand["triggerSymbol"]] == null then
    nz.Command.ChatListener[chatCommand["triggerSymbol"]] = {}
  end

  nz.Command.ChatListener[chatCommand["triggerSymbol"]][chatCommand["triggerPhrase"]] = chatCommand
end

//Assign the meta table to the nz global
nz.Command.Chat = setmetatable( ChatCommand, { __call = ChatCommand.new } )
