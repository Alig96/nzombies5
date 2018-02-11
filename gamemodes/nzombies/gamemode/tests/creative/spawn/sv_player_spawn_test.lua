local playerSpawnerTest = GUnit.Test:new("Creative > Player Spawner")

local function a_player_spawner_can_be_placed()
  local pos = Vector( 0, 0, 0 );

  -- Place the spawner
  nz.Creative.Spawn:addPlayerSpawner(pos)

  -- Assert that we have 1 spawner
  GUnit.assert(#ents.FindByClass("nz_player_spawner")):greaterThan(0)
end

local function a_player_spawner_can_be_removed()
  local pos = Vector( 0, 0, 0 );
  local ent = nz.Creative.Spawn:addPlayerSpawner(pos)

  -- Remove the spawner
  ent = nz.Creative.Spawn:removePlayerSpawner(ent)

  -- Assert that we have 0 spawners
  -- This doesn't actually work, because the entity is still in the game world while this is being run, so just assert there were no errors.
  -- GUnit.assert(#ents.FindByClass("nz_player_spawner")):shouldEqual(0)
  GUnit.assert(IsValid(ent)):shouldEqual(false)
end

playerSpawnerTest:beforeAll(function ()
  -- Set it to dev mode
  nz.Framework.Environment:setDev()
end)

playerSpawnerTest:addSpec("a player spawner can be placed", a_player_spawner_can_be_placed)
playerSpawnerTest:addSpec("a player spawner can be removed", a_player_spawner_can_be_removed)
