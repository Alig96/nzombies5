local gameTest = GUnit.Test:new("Game")

local function a_game_can_be_created()
  //Create a game
  local currentGame = nz.Game()

  //Assert that the current round is 0
  GUnit.assert(currentGame.CurrentRound):shouldEqual(0)
end

gameTest:addSpec("a game can be created", a_game_can_be_created)
