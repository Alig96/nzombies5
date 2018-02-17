local serverConfig = {
  server = {
    hostname = "nZombies Server " .. NZ_VERSION,
    enviroment = ENV_PRIVATE,
  }
}

local function consoleCommands()
  if gel.fw:isDev() then
    -- Quick Tests the game, used for testing/debug
    gel.fw:newCommand("Console", "qt", function(ply)
      if ply:IsValid() then return end
      RunConsoleCommand("test-only", "nzombies5")
    end)
  end
end

local function chatCommands()
  gel.fw:newCommand("Chat", "create", function(ply, params)
    -- Send it to the controller
    nz.Mode.updateController(ply, {
      ["requestedMode"] = MODE_CREATE,
    })
  end)

gel.fw:newCommand("Chat", "play", function(ply, params)
    -- Send it to the controller
    nz.Mode.updateController(ply, {
      ["requestedMode"] = MODE_PLAY,
    })
  end)
end

-- This is the main entry point to the app
local function startServer(includeDir)
  if includeDir == "nzombies/gamemode/modules" then
    -- Annouce it
    print("Starting nZombies Version: v" .. NZ_VERSION)
    -- Setup the gamemode's config
    gel.fw:setConfig("nz/server.txt", serverConfig)
    -- Load the config from the folder
    gel.fw:loadConfig()
    -- Set the server enviroment
    gel.fw:setEnvironment(gel.fw:getConfigValue("server", "enviroment"))
    -- Set all the custom console commands
    consoleCommands()
    -- Set all the custom chat commands
    chatCommands()
    -- While in dev, force the game to start in creative
    --nz.Mode:set(MODE_CREATE)
  end
end

hook.Add("realmLoader.Finished", "nz.startServer", startServer)
