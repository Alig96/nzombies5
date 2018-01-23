-- Set the player as a spectator
local function setAsSpectator(ply, isPermanent)
  -- If they're alive, then kill them
  if ply:Alive() then
    ply:KillSilent()
  end

  -- Set them on to the spectator team
  ply:SetTeam( TEAM_SPECS )

  -- Set their spectate perm
  if isPermanent then
    ply.specPerm = isPermanent
    nz.Debug.Print("info", "[GM] Permanent Spectator status set to: " .. tostring(isPermanent))
  end

  -- Set them to be able to roam
  ply.SpecType = OBS_MODE_ROAMING
  ply:Spectate( ply.SpecType )

  nz.Debug.Print("info", "[GM] " .. ply:Nick() .. " has been set as a Spectator.")
end

-- Check if the player is a spectator
local function isSpectator(ply, isPermanent)
  if ply:Team() == TEAM_UNASSIGNED or ply:Team() == TEAM_SPECS  then
    if isPermanent == true then
      if ply.specPerm == true then
        return true
      end
    else
      -- If we only asked if they were a spectator
      return true
    end
  end

  return false
end

-- Cycle
local function cycleSpectateMode(ply)
  local livePlayers = team.GetPlayers( TEAM_PLAYERS )

  ply.SpecType = ply.SpecType + 1
  if ply.SpecType > 6 then ply.SpecType = 4 end

  if #livePlayers == 0 then
    ply.SpecType = OBS_MODE_ROAMING
  end

  ply:Spectate( ply.SpecType )
end

-- Cycle
local function cycleSpectatePlayer(ply)
  if ply.SpecType != OBS_MODE_ROAMING then
    local livePlayers = team.GetPlayers( TEAM_PLAYERS )

    if !ply.SpecID then ply.SpecID = 1 end
    ply.SpecID = ply.SpecID + 1
    if ply.SpecID > #livePlayers then ply.SpecID = 1 end
    ply:SpectateEntity( livePlayers[ ply.SpecID ] )
  end
end

-- Semantic functions
local function isPermSpectator(ply)
  return ply:isSpectator(true)
end

local function setAsPermSpectator(ply)
  return ply:setAsSpectator(true)
end

-- Player Meta Assigning
playerMeta = FindMetaTable( "Player" )
playerMeta.isSpectator = isSpectator
playerMeta.setAsSpectator = setAsSpectator

playerMeta.cycleSpectateMode = cycleSpectateMode
playerMeta.cycleSpectatePlayer = cycleSpectatePlayer

playerMeta.isPermSpectator = isPermSpectator
playerMeta.setAsPermSpectator = setAsPermSpectator
