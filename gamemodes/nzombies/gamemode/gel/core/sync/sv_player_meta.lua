-- Get the player meta table
playerMeta = FindMetaTable("Player")

-- Sync the player
function playerMeta:sync()
  gel.Internal.Sync:syncPlayer(self)
end
