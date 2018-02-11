Round = {}
Round.__index = Round

Round.RoundId = 0
Round.CurrentState = ROUND_INIT
Round.PrepareTime = 5

Round.StartingTime = 0

Round.EnemiesKilled = 0
Round.EnemiesSpawned = 0

Round.MaxEnemies = 1
Round.MaxHealth = 100
Round.MaxSpeed = 100

-- Prepare the round
function Round:prepare()
  -- Set the round state to preparing
  self.CurrentState = ROUND_PREP

  -- Set the ready timer to the current time + delay
  self.StartingTime = CurTime() + self.PrepareTime

  Log(LOG_INFO, "Round has been prepared & its state has been set to PREP.", "Game:Round")
end

-- Start the round
function Round:start()
  -- Set the round state to in progress
  self.CurrentState = ROUND_PROG

  Log(LOG_INFO, "Round has been started & its state has been set to PROG.", "Game:Round")
end

-- Finish the round
function Round:finish()
  -- Set the round state to finished
  self.CurrentState = ROUND_FINISHED

  Log(LOG_INFO, "Round has finished & its state has been set to FINISHED.", "Game:Round")
end

-- This is the victory condition of the round, when this returns true, end the round
function Round:victoryCondition()
  if self.EnemiesKilled >= self.MaxEnemies then
    Log(LOG_INFO, "The round's victory condition has been met", "Game:Round")
    return true
  end

  return false
end

-- Create a new Round
function Round:new(roundNumber, curves)
  -- Create a new round
  local newRound = table.Copy( Round )
  -- Remove the meta data
  newRound.new = null
  newRound.__index = null

  -- Set the round Id
  newRound.RoundId = roundNumber

  -- Calculate this rounds data
  if curves then
    newRound.MaxEnemies = curves.MaxEnemies:calculatePointOnCurve(roundNumber)
    newRound.MaxHealth = curves.MaxHealth:calculatePointOnCurve(roundNumber)
    newRound.MaxSpeed = curves.MaxSpeed:calculatePointOnCurve(roundNumber)
  end

  return newRound
end

-- Assign the meta table to the nz global
nz.Round.Create = setmetatable( Round, { __call = Round.new } )
