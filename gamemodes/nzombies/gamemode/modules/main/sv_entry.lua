local function consoleCommands()
  -- Quick Reloads the stage, mostly used for testing/debug
  nz.Command.Console("qr", function()
  	RunConsoleCommand("changelevel", game.GetMap())
  end)

  -- Quick Tests the game, used for testing/debug
  nz.Command.Console("qt", function()
    RunConsoleCommand("test-only", "nzombies5")
  end)
end

local function chatCommands()
  nz.Command.Chat("create", function(ply, params)
    -- Check if they are allowed to do this
    if ply then
      nz.Mode:set(MODE_CREATIVE)
    end
  end)

  nz.Command.Chat("play", function(ply, params)
    -- Check if they are allowed to do this
    if ply then
      nz.Mode:set(MODE_PLAY)
    end
  end)
end

-- This is the main entry point to the app
local function startServer()
  -- Annouce it
  nz.Debug.Print("success", "Starting nZombies Version: v" .. NZ_VERSION)
  -- Load the current enviroment file
  nz.IO.Environment:loadCurrentEnviromentFile()
  -- Set all the custom console commands
  consoleCommands()
  -- Set all the custom chat commands
  chatCommands()
  -- While the gamemode is in development, set the default to Creative
  nz.Mode:set(MODE_CREATIVE)
end

hook.Add( "RealmLoader.Finished", "Starts NZombies", startServer )
