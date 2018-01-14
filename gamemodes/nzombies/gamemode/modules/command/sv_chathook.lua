hook.Add("PlayerSay", "nz.chatcommand.listener", function(ply, text, public)
  text = string.lower(text)

  local triggerChar = text:sub(1, 1)
  local triggerString = text:sub(2)
  local params = string.Explode( " ", triggerString )

  if params then
    triggerString = params[1]
    table.remove(params, 1)
  end

  if nz.Command.ChatListener[triggerChar] and nz.Command.ChatListener[triggerChar][triggerString] then
    local command = nz.Command.ChatListener[triggerChar][triggerString]
    nz.Debug.Print("info", "[ChatCommand] " .. ply:Nick() .. " ran chat command: " .. triggerString)
    command.customFunction(ply, params)
    return false
  end
end)
