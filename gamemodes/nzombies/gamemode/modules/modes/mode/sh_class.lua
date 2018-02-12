-- Mode Constants
MODE_PLAY = 0
MODE_CREATE = 1

local mode = {}
mode.__index = mode
mode.current = MODE_PLAY
mode.available = {
  [MODE_PLAY] = nz.Framework.newMode(MODE_PLAY, "Play"),
  [MODE_CREATE] = nz.Framework.newMode(MODE_CREATE, "Create"),
}

function mode:validate(modeConstant)
  if modeConstant != self:get() and self.available[modeConstant] then
    return true
  end
  return false
end

function mode:get()
  return self.current
end

function mode:toString(modeConstant)
  if modeConstant then
    return self.available[modeConstant].name
  end

  return self.available[self:get()].name
end

function mode:set(modeConstant)
  if self:validate(modeConstant) then
    self.current = modeConstant
    Log(LOG_INFO, "Mode set to: '" .. self:toString(modeConstant) .. "' Mode", "Modes:Mode")
    if SERVER then
      self:sync()

      -- Kill all players to reset them
      for _, ply in pairs(player.GetAll()) do
        ply:KillSilent()
      end
    end
  end
end

if SERVER then
  function mode:sync()
    -- Broadcast to all players
    nz.Framework.Sync["Mode"]:broadcast()
  end
end

-- Semantic Functions
function mode:isPlay()
  return self:get() == MODE_PLAY
end

function mode:isCreative()
  return self:get() == MODE_CREATE
end

-- Assign the meta table to the nz global
nz.Mode = setmetatable({}, mode)
