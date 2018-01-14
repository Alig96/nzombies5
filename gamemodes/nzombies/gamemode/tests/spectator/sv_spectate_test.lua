local spectatorTest = GUnit.Test:new("Spectator")

local function when_player_spawns_they_are_set_to_spectator()
  //Create a bot
  local bot = player.CreateNextBot( "test_bot" )

  //Assert the bot is set to being a spectator
  GUnit.assert(bot:isSpectator()):shouldEqual(true)
end

local function a_player_can_be_set_as_a_permanent_spectator()
  //Create a bot
  local bot = player.CreateNextBot( "test_bot" )

  //Assert the bot is set to being a spectator, but not a perm spectator
  GUnit.assert(bot:isSpectator()):shouldEqual(true)
  GUnit.assert(bot:isSpectator(true)):shouldEqual(false)

  //Set the bot as a perm spec
  bot:setAsSpectator(true)

  //Assert the bot is set to being a perm spectator
  GUnit.assert(bot:isSpectator(true)):shouldEqual(true)
end

spectatorTest:beforeAll(function ()
  //Set it to debug mode
  nz.Debug.Mode:set(true)
end)

spectatorTest:afterEach(function ()
  //Kick all bots
  for _, bot in pairs(player.GetBots()) do
    bot:Kick()
  end
end)

spectatorTest:addSpec("when a player spawns, they are set to spectator", when_player_spawns_they_are_set_to_spectator)
spectatorTest:addSpec("a player can be set as a permanent spectator", a_player_can_be_set_as_a_permanent_spectator)
