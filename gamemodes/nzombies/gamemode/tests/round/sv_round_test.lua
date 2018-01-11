local roundTest = GUnit.Test:new("Round")

local function a_round_can_be_created()
  //Create a round
  local round = nz.Round.Create()
  //Assert that the default round's max enemies is 1
  GUnit.assert(round.MaxEnemies):shouldEqual(1)
end

roundTest:addSpec("a round can be created", a_round_can_be_created)
