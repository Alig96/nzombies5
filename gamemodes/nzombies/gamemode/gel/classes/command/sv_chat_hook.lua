hook.Add("PlayerSay", "gel.Command.chatCommandListener", function(ply, text, public)
  text = string.lower(text)

  local triggerSymbol = text:sub(1, 1)
  local triggerPhrase = text:sub(2)
  local params = string.Explode(" ", triggerPhrase)

  -- Remove the trigger phrase from the params
  if params then
    triggerPhrase = params[1]
    table.remove(params, 1)
  end

  -- If the command exists
  local commandActivationString = triggerSymbol .. triggerPhrase
  local command = gel.Internal.Command.chatCommands[commandActivationString]
  if command then
    Log(LOG_INFO, ply:Nick() .. " ran command: " .. commandActivationString, "Framework:Command:ChatHook")
    command.onCalled(ply, params)
    -- Prevent it from showing in chat
    return false
  end
end)
