local function ConsoleCommands()
  //Quick Reloads the stage, mostly used for testing/debug
  nz.Command.Console("qr", function()
  	RunConsoleCommand("changelevel", game.GetMap())
  end)
end

local function ChatCommands()
  nz.Command.Chat("create", function(ply, params)
    //Check if they are allowed to do this
    if ply then
      nz.Mode:set(MODE_CREATIVE)
    end
  end)

  nz.Command.Chat("play", function(ply, params)
    //Check if they are allowed to do this
    if ply then
      nz.Mode:set(MODE_PLAY)
    end
  end)
end

//This is the main entry point to the app
local function StartServer()
  //Set the enviroment
  nz.Debug.Mode:set(true)
  //Set all the custom console commands
  ConsoleCommands()
  //Set all the custom chat commands
  ChatCommands()

  //While the gamemode is in development, set the default to Creative
  nz.Mode:set(MODE_CREATIVE)
end

hook.Add( "RealmLoader.Finished", "Starts NZombies", StartServer )
