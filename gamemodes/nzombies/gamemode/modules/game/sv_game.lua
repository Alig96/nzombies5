Game = {}
Game.__index = Game

//Data
Game.InitialPlayers = {}
Game.CurrentPlayers = {}
Game.Curves = {}

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

//Setup the game ready for play
function Game:setup()
  //Add all the initial players to the current players game
  local players = self.InitialPlayers

  for _, player in pairs(players) do
      self:addPlayer(player)
  end
end

//Create a new game
function Game:new( players )
  //Create a new game with the initial players
  local newGame = setmetatable( {
    InitialPlayers = players or {}
  }, Game )

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
nz.Game = setmetatable( Game, { __call = Game.new } )
