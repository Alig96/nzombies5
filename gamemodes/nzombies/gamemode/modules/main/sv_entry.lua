local function ConsoleCommands()
  //Quick Reloads the stage, mostly used for testing/debug
  nz.Command.Console("qr", function()
  	RunConsoleCommand("changelevel", game.GetMap())
  end)
end

local function ChatCommands()
  nz.Command.Chat("qr", function(ply, params)
    RunConsoleCommand("changelevel", game.GetMap())
  end)
end

//This is the main entry point to the app
local function StartServer()
  //Set the enviroment
  nz.Debug.Mode:set(false)
  //Set all the custom console commands
  ConsoleCommands()
  //Set all the custom chat commands
  ChatCommands()
end

hook.Add( "RealmLoader.Finished", "Starts NZombies", StartServer )
