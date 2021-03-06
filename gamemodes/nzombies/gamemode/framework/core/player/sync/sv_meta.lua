-- Player Meta Assigning
playerMeta = FindMetaTable("Player")

-- Set the player as a regular spectator
function playerMeta:fullSync()
  Log(LOG_DEBUG, "Sending a full sync to: " .. self:Nick(), "Player:Sync")
  for syncFunctionKey, v in pairs(nz.Framework.Sync) do
    nz.Framework.Sync[syncFunctionKey]:sendSync(self)
  end
  Log(LOG_DEBUG, "Finished sending a full sync to: " .. self:Nick(), "Player:Sync")
end
