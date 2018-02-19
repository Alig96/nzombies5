local clientConfig = {
  language = {
    current = "english"
  }
}

-- This is the main entry point to the app
local function startClient(includeDir)
  if includeDir == "nzombies/gamemode/modules" then
    -- Annouce it
    print("Starting nZombies Client Version: v" .. NZ_VERSION)

    -- Setup the gamemode's config
    gel.fw:setConfig("nz/client.txt", clientConfig)
    -- Load the config from the folder
    gel.fw:loadConfig()
    -- Set our language
    gel.fw:setLanguage(gel.fw:getConfigValue("language", "current"))
  end
end

hook.Add("realmLoader.Finished", "nz.startClient", startClient)
