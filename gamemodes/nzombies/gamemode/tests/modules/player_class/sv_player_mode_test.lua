local playerClassTest = GUnit.Test:new("Player Class")

local function when_a_player_spawns_in_creative_mode_they_are_set_to_the_create_mode_class()
  -- Set the mode to creative
  nz.Mode:set(MODE_CREATIVE)

  -- Create a bot
  local bot = player.CreateNextBot( "test_bot" )

  -- Assert the bot's class is set to the create class since we're in create mode
  GUnit.assert(player_manager.GetPlayerClass( bot )):shouldEqual("player_create")
  -- Check that the bot is alive
  GUnit.assert(bot:Alive()):shouldEqual(true)
end

playerClassTest:beforeAll(function ()
  -- Set it to dev mode
  nz.Framework.Environment:setDev()
end)

playerClassTest:afterEach(GUnit.kickAllBots)

playerClassTest:addSpec("when a player spawns, in create mode, they are given the create mode class", when_a_player_spawns_in_creative_mode_they_are_set_to_the_create_mode_class)
