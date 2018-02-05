local Id = "nz_player_spawner_tool"
local Name = "Player Spawner"
local Description = "Left Click: Add Player Spawner.\nRight Click: Remove Player Spawner."

local categoryId = "spawners"
local contentPanelName = "nz.PlayerSpawnerTool"

local function leftClick(trace)
  nz.Request.sendCreatePlayerSpawner(trace.HitPos)
end

local function rightClick(trace)
  -- Only make the request if we have an entity
  if trace.Entity and trace.Entity:GetClass() != "worldspawn" then
    nz.Request.sendRemovePlayerSpawner(trace.Entity)
  end
end

nz.Tool(Id, Name, Description, categoryId, contentPanelName, leftClick, rightClick)
