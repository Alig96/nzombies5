local botTest = GUnit.Test:new("Bot")

local function when_player_spawns_they_are_set_to_spectator()

  nz.Debug.Print("info", "[Bot] Spawning bot." )
  player.CreateNextBot( "test_bot" )

  //Assert that we have 1 player
  GUnit.assert(#player.GetBots()):shouldEqual(1)
end

botTest:beforeAll(function ()
  //Set it to debug mode
  nz.Debug.Mode:set(true)
end)

botTest:afterEach(function ()
  //Kick all bots
  for _, bot in pairs(player.GetBots()) do
    bot:Kick()
  end
end)

botTest:addSpec("a bot can be spawned as a player", when_player_spawns_they_are_set_to_spectator)
