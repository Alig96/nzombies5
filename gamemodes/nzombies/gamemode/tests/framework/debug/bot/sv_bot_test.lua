local botTest = GUnit.Test:new("[Framework] Debug > Bot")

local function when_player_spawns_they_are_set_to_spectator()

  Log(LOG_INFO, "Spawning bot..." )
  player.CreateNextBot( "test_bot" )

  -- Assert that we have 1 player
  GUnit.assert(#player.GetBots()):greaterThan(0)
end

botTest:beforeAll(function ()
  -- Set it to dev mode
  nz.Framework.Environment:setDev()
end)

botTest:afterEach(GUnit.kickAllBots)

botTest:addSpec("a bot can be spawned as a player", when_player_spawns_they_are_set_to_spectator)
