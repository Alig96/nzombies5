Round = {}
Round.__index = Round

Round.MaxEnemies = 1
Round.MaxHealth = 100
Round.MaxSpeed = 100

//Create a new Round
function Round:new(roundNumber, curves)
  //Create a new round
  local newRound = table.Copy( Round )
  //Remove the meta data
  newRound.new = null
  newRound.__index = null

  //Calculate this rounds data
  if curves then
    newRound.MaxEnemies = curves.MaxEnemies:calculatePointOnCurve(roundNumber)
    newRound.MaxHealth = curves.MaxHealth:calculatePointOnCurve(roundNumber)
    newRound.MaxSpeed = curves.MaxSpeed:calculatePointOnCurve(roundNumber)
  end

  return newRound
end

//Assign the meta table to the nz global
nz.Round.Create = setmetatable( Round, { __call = Round.new } )
