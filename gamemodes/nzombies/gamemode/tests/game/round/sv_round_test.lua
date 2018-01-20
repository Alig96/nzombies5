local roundTest = GUnit.Test:new("Round")

local function a_round_can_be_created()
  //Create a round
  local round = nz.Round.Create()

  //Assert that the round is in the initial state
  GUnit.assert(round.CurrentState):shouldEqual(ROUND_INIT)
end

local function a_round_can_be_prepared()
  //Create a round
  local round = nz.Round.Create()

  //Start the round
  round:prepare()

  //Assert that the round is in the 'inprogress' state
  GUnit.assert(round.CurrentState):shouldEqual(ROUND_PREP)
end

local function a_round_can_be_started()
  //Create a round
  local round = nz.Round.Create()

  //Start the round
  round:start()

  //Assert that the round is in the 'inprogress' state
  GUnit.assert(round.CurrentState):shouldEqual(ROUND_PROG)
end

local function a_round_can_be_finished()
  //Create a round
  local round = nz.Round.Create()

  //Finish the round
  round:finish()

  //Assert that the round is in the finished state
  GUnit.assert(round.CurrentState):shouldEqual(ROUND_FINISHED)
end

roundTest:addSpec("a round can be created", a_round_can_be_created)
roundTest:addSpec("a round can be prepared", a_round_can_be_prepared)
roundTest:addSpec("a round can be started", a_round_can_be_started)
roundTest:addSpec("a round can be finished", a_round_can_be_finished)
