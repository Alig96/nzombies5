local gameTest = GUnit.Test:new("Game")
local playerGen = GUnit.Generators.FakePlayer

local function a_game_cannot_be_created_with_not_enough_players()
  //Create a fake players array with no players
  local allPlayers = {}
  //Create a game
  local currentGame = nz.Game(allPlayers)

  //Assert that the game is false
  GUnit.assert(currentGame):shouldEqual(false)
end

local function a_game_can_be_created_with_enough_players()
  //Create a fake players array with 2 players
  local allPlayers = {playerGen:new(), playerGen:new()}
  //Create a game
  local currentGame = nz.Game(allPlayers)

  //Assert that the current round is 0
  GUnit.assert(currentGame.CurrentRound):shouldEqual(0)
  GUnit.assert(currentGame.CurrentState):shouldEqual(GAME_INIT)
end

local function a_game_can_be_setup()
  //Create a fake player
  local player1 = playerGen:new()
  //Create an all players array
  local allPlayers = {player1}
  //Create a game
  local currentGame = nz.Game(allPlayers)

  //Assert that the game has the fake player in its all player array
  GUnit.assert(table.HasValue( currentGame.CurrentPlayers, player1 )):shouldEqual(true)
end

gameTest:addSpec("a game cannot be created with not enough players", a_game_cannot_be_created_with_not_enough_players)
gameTest:addSpec("a game can be created with enough players", a_game_can_be_created_with_enough_players)
gameTest:addSpec("a game can be setup", a_game_can_be_setup)
