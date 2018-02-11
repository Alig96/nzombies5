Game = {}
Game.__index = Game

-- Data
Game.InitialPlayers = {}
Game.CurrentPlayers = {}
Game.Rounds = {}
Game.Curves = {
  MaxEnemies = nz.Curve.Create(5, 1.01),
  MaxHealth = nz.Curve.Create(75, 0.4),
  MaxSpeed = nz.Curve.Create(60, 0.55),
}

-- Defaults
Game.CurrentState = GAME_INIT
Game.CurrentRound = {}
Game.CurrentRoundCounter = 0

local logModuleName = "Game"

-- Check we can create a game
function Game:checkPrerequisites()
  -- Check that there were enough given players to the Initial players
  if #self.InitialPlayers < 1 then
    Log(LOG_ERROR, "There was not initial players to create a game.", logModuleName)
    return false
  end

  Log(LOG_INFO, "Game passed all prerequisites.", logModuleName)
  return true
end

-- Setup the game ready for play
function Game:setup()
  -- Add all the initial players to the current players game
  local players = self.InitialPlayers

  for _, player in pairs(players) do
      self:addPlayer(player)
  end

  -- Set the game to in progress
  self.CurrentState = GAME_READY
  Log(LOG_INFO, "Game was setup & set to READY state.", logModuleName)
end

-- Start the game
function Game:start()
  -- Set the game to finished
  self.CurrentState = GAME_PROG
  Log(LOG_INFO, "Game was started & set to IN PROGRESS state.", logModuleName)
  -- Advance to the first round
  self:advanceRound()
end

-- Advance the round
function Game:advanceRound()
  -- Arhive the previous round
  self.Rounds[self.CurrentRoundCounter] = self.CurrentRound

  -- Increase the round counter
  self.CurrentRoundCounter = self.CurrentRoundCounter + 1

  -- Generate this round
  self:generateRound(self.CurrentRoundCounter)

  -- Load the round data of the current round
  self.CurrentRound = self.Rounds[self.CurrentRoundCounter]

  Log(LOG_INFO, "Game has advanced to round: " .. self.CurrentRoundCounter, logModuleName)

  -- Run the prepare function on the round
  self.CurrentRound:prepare()
  Log(LOG_INFO, "Game has triggered the round's prepare function.", logModuleName)
end

-- Finish the game
function Game:finish()
  -- Set the game to finished
  self.CurrentState = GAME_FINISHED
  Log(LOG_INFO, "Game has finished & set to FINISHED state.", logModuleName)
  Log(LOG_INFO, "This game is finished and safe to destroy its game handler.", logModuleName)
end

-- The game handler that should be run every second the game is running
function Game:handler()
  local currentTime = CurTime()

  -- If the game is ready
  if self.CurrentState == GAME_READY then
    Log(LOG_INFO, "Game is ready and waiting for all current players to ready up.", logModuleName)
    -- Check all the players are ready
    if true then
      -- Start the game
      self:start()
    end
  end

  -- If the game is in progress
  if self.CurrentState == GAME_PROG then
    -- If all current players are dead or non existant, then end the game
    if false then
      self:finish()
    end

    -- If the round is preparing
    if self.CurrentRound.CurrentState == ROUND_PREP then
      Log(LOG_INFO, "Game is waiting for the current round to start.", logModuleName)
      -- Check that the current time is more than the round starting timer
      if currentTime > self.CurrentRound.StartingTime then
        -- Start the round
        self.CurrentRound:start()
      end
    elseif self.CurrentRound.CurrentState == ROUND_PROG then
      Log(LOG_INFO, "Game is waiting for the current round's victory condition to be met.", logModuleName)
      -- Check the victory condition of the round
      if self.CurrentRound:victoryCondition() then
        -- Finish the round
        self.CurrentRound:finish()
        -- Advance the game to the next round
        self:advanceRound()
      end
    end
  end
end

-- Add this player to the game
function Game:addPlayer( player )
  if player:IsValid() and !table.HasValue(self.CurrentPlayers, player) then
    table.insert(self.CurrentPlayers, player)
  end
end

-- Generate a round
function Game:generateRound(roundNumber)
  -- Generate a specific round, and put it into the game's round table
  self.Rounds[roundNumber] = nz.Round.Create(roundNumber, self.Curves)
end

-- Create a new game
function Game:new( players )
  -- Create a new game with the initial players
  local newGame = table.Copy( Game )
  newGame.InitialPlayers = players
  -- Remove the meta data
  newGame.new = null
  newGame.__index = null

  -- Check the new game has the checkPrerequisites, if not destroy the game
  local prerequisites = newGame:checkPrerequisites()

  if prerequisites then
    -- Setup the game
    newGame:setup()
    return newGame
  end

  return false
end

-- Assign the meta table to the nz global
nz.Game.Create = setmetatable( Game, { __call = Game.new } )
