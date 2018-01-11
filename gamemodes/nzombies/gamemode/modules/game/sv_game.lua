Game = {}
Game.__index = Game

//Data
Game.InitialPlayers = {}
Game.CurrentPlayers = {}
Game.Rounds = {}
Game.Curves = {
  MaxEnemies = nz.Curve.Create(5, 1.01),
  MaxHealth = nz.Curve.Create(75, 0.4),
  MaxSpeed = nz.Curve.Create(60, 0.55),
}

//Defaults
Game.CurrentState = GAME_INIT
Game.CurrentRound = 0

//Check we can create a game
function Game:checkPrerequisites()
  //Check that there were enough given players to the Initial players
  if #self.InitialPlayers < 1 then
    nz.Debug.Print("danger", "There was not initial players to create a game.")
    return false
  end

  return true
end

//Add this player to the game
function Game:addPlayer( player )
  if player:IsValid() and !table.HasValue(self.CurrentPlayers, player) then
    table.insert(self.CurrentPlayers, player)
  end
end

//Generate a round
function Game:generateRound(roundNumber)
  //Generate a specific round, and put it into the game's round table
  self.Rounds[roundNumber] = nz.Round.Create(roundNumber, self.Curves)
end

//Setup the game ready for play
function Game:setup()
  //Generate 100 rounds worth of data
  for i = 1, 100 do
    self:generateRound(i)
  end

  //Add all the initial players to the current players game
  local players = self.InitialPlayers

  for _, player in pairs(players) do
      self:addPlayer(player)
  end
end

//Create a new game
function Game:new( players )
  //Create a new game with the initial players
  local newGame = table.Copy( Game )
  newGame.InitialPlayers = players
  //Remove the meta data
  newGame.new = null
  newGame.__index = null

  //Check the new game has the checkPrerequisites, if not destroy the game
  local prerequisites = newGame:checkPrerequisites()

  if prerequisites then
    //Setup the game
    newGame:setup()
    return newGame
  end

  return false
end

//Assign the meta table to the nz global
nz.Game.Create = setmetatable( Game, { __call = Game.new } )
