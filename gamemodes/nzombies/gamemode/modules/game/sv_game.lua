Game = {}
Game.__index = Game
Game.InitialPlayers = {}
Game.Curves = {}

//Defaults
Game.CurrentRound = 0

function Game:new( players )
  return setmetatable( {
    InitialPlayers = players or {},
    Curves = {
      ['spawnFrequencey'] = nz.Curve(5, 1.01, 100)
    },

  }, Game )
end

//Assign the meta table to the nz global
nz.Game = setmetatable( Game, { __call = Game.new } )
