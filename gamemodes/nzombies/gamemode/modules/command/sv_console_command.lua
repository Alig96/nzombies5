ConsoleCommand = {}
ConsoleCommand.__index = ConsoleCommand

function ConsoleCommand:new( text, func )
  concommand.Add( text, func )
end

//Assign the meta table to the nz global
nz.Command.Console = setmetatable( ConsoleCommand, { __call = ConsoleCommand.new } )
