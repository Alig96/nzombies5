-- This is the main entry point to the app
local function startClient(includeDir)
  if includeDir == "nzombies/gamemode/modules" then
    -- Annouce it
    print("Starting nZombies Client Version: v" .. NZ_VERSION)
    -- Set our language
    gel.fw:setLanguage("german")
    -- Print the welcome message
    print(gel.fw:translate("welcome"))
  end
end

hook.Add("realmLoader.Finished", "nz.startClient", startClient)
