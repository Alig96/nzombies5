Mode = {}
Mode.__index = Mode
Mode.CurrentState = MODE_PLAY

function Mode:set(modeConst)
  if nz.Mode.CurrentState != modeConst then
    if modeConst == MODE_PLAY then
      nz.Mode.CurrentState = modeConst
      Log(LOG_INFO, "Internal Gamemode set to: Play Mode", "Mode")
    elseif modeConst == MODE_CREATIVE then
      nz.Mode.CurrentState = modeConst
      Log(LOG_INFO, "Internal Gamemode set to: Creative Mode", "Mode")
    end
    if SERVER then
      -- Broadcast it to all players
      nz.Framework.Sync["Mode"]:broadcast()

      -- Kill all players to reset them
      for _, ply in pairs(player.GetAll()) do
        ply:KillSilent()
      end
    end
  end

  return nz.Mode.CurrentState
end

function Mode:syncVariables()
  return {currentMode = self.get()}
end

function Mode:get()
  return nz.Mode.CurrentState
end

function Mode:isPlay()
  return self.get() == MODE_PLAY
end

function Mode:isCreative()
  return self.get() == MODE_CREATIVE
end

-- Assign the meta table to the nz global
nz.Mode = setmetatable( Mode, { __call = Mode.set } )
