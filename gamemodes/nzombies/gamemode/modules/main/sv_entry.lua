local function consoleCommands()
  if nz.Framework.Environment:isDev() then
    -- Quick Reloads the stage, mostly used for testing/debug
    nz.Framework.newConsoleCommand("qr", function(ply)
      if ply:IsValid() then return end
    	RunConsoleCommand("changelevel", game.GetMap())
    end)

    -- Quick Tests the game, used for testing/debug
    nz.Framework.newConsoleCommand("qt", function(ply)
      if ply:IsValid() then return end
      RunConsoleCommand("test-only", "nzombies5")
    end)
  end
end

local function chatCommands()
  nz.Framework.newChatCommand("create", function(ply, params)
    -- Send it to the controller
    nz.Controller.handleChangeMode(ply, {
      ["requestedMode"] = MODE_CREATIVE,
    })
  end)

  nz.Framework.newChatCommand("play", function(ply, params)
    -- Send it to the controller
    nz.Controller.handleChangeMode(ply, {
      ["requestedMode"] = MODE_PLAY,
    })
  end)
end

-- This is the main entry point to the app
local function startServer(includeDir)
  if includeDir == "nzombies/gamemode/modules" then
    -- Annouce it
    print("Starting nZombies Version: v" .. NZ_VERSION)
    -- Load the current enviroment file
    nz.IO.Environment:loadCurrentEnviromentFile()
    -- Set all the custom console commands
    consoleCommands()
    -- Set all the custom chat commands
    chatCommands()
    -- While the gamemode is in development, set the default to Creative
    --nz.Mode:set(MODE_CREATIVE)
  end
end

hook.Add("realmLoader.Finished", "nz.startServer", startServer)
