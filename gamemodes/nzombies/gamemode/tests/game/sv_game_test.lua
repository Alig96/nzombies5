local gameTest = GUnit.Test:new("Game")
local playerGen = GUnit.Generators.FakePlayer

local function a_game_cannot_be_created_with_not_enough_players()
  -- Create a fake players array with no players
  local allPlayers = {}
  -- Create a game
  local currentGame = nz.Game.Create(allPlayers)

  -- Assert that the game is false
  GUnit.assert(currentGame):shouldEqual(false)
end

local function a_game_can_be_created_with_enough_players()
  -- Create a fake players array with 2 players
  local allPlayers = {playerGen:new(), playerGen:new()}
  -- Create a game
  local currentGame = nz.Game.Create(allPlayers)

  -- Assert that the current game state is in the ready state
  GUnit.assert(currentGame.CurrentState):shouldEqual(GAME_READY)
end

local function a_game_can_generate_a_round()
  -- Create a fake player
  local player1 = playerGen:new()
  -- Create an all players array
  local allPlayers = {player1}
  -- Create a game
  local currentGame = nz.Game.Create(allPlayers)

  -- Generate a round
  currentGame:generateRound(1)

  -- Ensure that the rounds of the game have been generated
  GUnit.assert(#currentGame.Rounds):greaterThan(0)
end

local function a_game_can_be_setup()
  -- Create a fake player
  local player1 = playerGen:new()
  -- Create an all players array
  local allPlayers = {player1}
  -- Create a game
  local currentGame = nz.Game.Create(allPlayers)

  -- Assert that the game has the fake player in its all player array
  GUnit.assert(table.HasValue( currentGame.CurrentPlayers, player1 )):shouldEqual(true)
end

local function a_game_can_be_started()
  -- Create a fake player
  local player1 = playerGen:new()
  -- Create an all players array
  local allPlayers = {player1}
  -- Create a game
  local currentGame = nz.Game.Create(allPlayers)

  -- Start the game
  currentGame:start()

  -- Assert that the current game state is in the ready state
  GUnit.assert(currentGame.CurrentState):shouldEqual(GAME_PROG)
end

local function a_game_can_be_finished()
  -- Create a fake player
  local player1 = playerGen:new()
  -- Create an all players array
  local allPlayers = {player1}
  -- Create a game
  local currentGame = nz.Game.Create(allPlayers)

  -- Start the game
  currentGame:start()

  -- End the game
  currentGame:finish()

  -- Assert that the current game state is in the ready state
  GUnit.assert(currentGame.CurrentState):shouldEqual(GAME_FINISHED)
end

local function a_game_can_be_simulated()
  -- Create a fake player
  local player1 = playerGen:new()
  -- Create an all players array
  local allPlayers = {player1}
  -- Create a game
  local currentGame = nz.Game.Create(allPlayers)

  -- Simulate the game
  while currentGame.CurrentState != GAME_FINISHED do
    -- Simulate the timer being triggered
    currentGame:handler()

    -- Simulate the round starting since time doesn't advance during a while loop & we dont want to wait for the default 5 seconds
    currentGame.CurrentRound.StartingTime = 0

    -- Keep the game going until the 2nd round
    if currentGame.CurrentRoundCounter < 2 then
      if currentGame.CurrentState == ROUND_PROG then
        -- Set the enemies killed to the max to simulate we finished the round
        currentGame.CurrentRound.EnemiesKilled = currentGame.CurrentRound.MaxEnemies
      end
    else
      -- If we reach round 2 end the game & simulation
      currentGame:finish()
    end
  end

  -- Assert that the game ended
  GUnit.assert(currentGame.CurrentState):shouldEqual(GAME_FINISHED)
end

gameTest:beforeAll(function ()
  -- Set it to debug environment
  nz.Debug.Environment:set(ENV_DEV)
end)

gameTest:addSpec("a game cannot be created with not enough players", a_game_cannot_be_created_with_not_enough_players)
gameTest:addSpec("a game can be created with enough players", a_game_can_be_created_with_enough_players)
gameTest:addSpec("a game can generate a round", a_game_can_generate_a_round)
gameTest:addSpec("a game can be setup", a_game_can_be_setup)
gameTest:addSpec("a game can be started", a_game_can_be_started)
gameTest:addSpec("a game can be finished", a_game_can_be_finished)
gameTest:addSpec("a game can be simulated", a_game_can_be_simulated)
