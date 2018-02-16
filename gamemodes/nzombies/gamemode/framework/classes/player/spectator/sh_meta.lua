-- Get the player meta table
playerMeta = FindMetaTable("Player")

-- Check if the player is a spectator
function playerMeta:isSpectator()
  if !self:Alive() then
    return true
  end

  return false
end

-- Check if the player is a perm spectator
function playerMeta:isPermSpectator()
  if self:Team() == TEAM_UNASSIGNED or self:Team() == TEAM_SPECS then
    return true
  end

  return false
end
