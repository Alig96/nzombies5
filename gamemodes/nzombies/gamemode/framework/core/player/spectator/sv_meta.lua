-- Player Meta Assigning
playerMeta = FindMetaTable( "Player" )

-- Set the player as a regular spectator
function playerMeta:setAsSpectator()
  -- If they're alive, then kill them
  if self:Alive() then
    self:KillSilent()
  end

  -- Set them to be able to roam
  self.specType = OBS_MODE_ROAMING
  self:Spectate(self.specType)

  Log(LOG_INFO, self:Nick() .. " has been set as a Spectator.", "Framework:Player")
end

-- Check if the player is a spectator
function playerMeta:isSpectator()
  if !self:Alive() then
    return true
  end

  return false
end

-- Set the player as a perm spectator
function playerMeta:setAsPermSpectator()
  -- Set them on to the perm spectator team
  self:SetTeam(TEAM_SPECS)
  -- Now set them as a spectator
  self:setAsSpectator()
end

-- Check if the player is a perm spectator
function playerMeta:isPermSpectator()
  if self:Team() == TEAM_UNASSIGNED or self:Team() == TEAM_SPECS then
    return true
  end

  return false
end

-- Cycle through each Spectate mode
function playerMeta:cycleSpectateMode()
  local alivePlayers = {}

  -- Put all the players that alive into the table
  for k, ply in pairs (team.GetPlayers(TEAM_PLAYERS)) do
    if ply:Alive() then
      table.insert(alivePlayers, ply)
    end
  end

  self.specType = self.specType + 1
  if self.specType > 6 then self.specType = 4 end

  if #alivePlayers == 0 then
    self.specType = OBS_MODE_ROAMING
  end

  self:Spectate(self.specType)
end

-- Cycle through each player
function playerMeta:cycleSpectatePlayer()
  if self.specType != OBS_MODE_ROAMING then
    local alivePlayers = {}

    -- Put all the players that alive into the table
    for k, ply in pairs (team.GetPlayers(TEAM_PLAYERS)) do
      if ply:Alive() then
        table.insert(alivePlayers, ply)
      end
    end

    -- Go to the next player
    if !self.SpecID then self.SpecID = 1 end
    self.SpecID = self.SpecID + 1
    if self.SpecID > #alivePlayers then self.SpecID = 1 end
    self:SpectateEntity(alivePlayers[self.SpecID])
  end
end
