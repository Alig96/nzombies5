-- Mode Constants
MODE_PLAY = 0
MODE_CREATE = 1

-- Get the Controller Model
local modeModel = gel.fw:getModel("Mode")

local modeClass = {}
modeClass.current = MODE_PLAY

function modeClass:constructor()
  if #modeModel:all() == 0 then
    modeModel:create(MODE_PLAY, "Play")
    modeModel:create(MODE_CREATE, "Create")
  end
end

function modeClass:get(modeId)
  if !modeId then modeId = self.current end
  return modeModel:find(modeId)
end

function modeClass:set(modeConstant)
  local mode = self:get(modeConstant)
  if mode and modeConstant != self.current then
    self.current = mode.id
    Log(LOG_INFO, "Mode set to: '" .. mode.name .. "' Mode", "Mode")

    if SERVER then
      -- Broadcast the current mode
      gel.fw:broadcastSync("Mode")

      -- Kill all players to reset them
      for _, ply in pairs(player.GetAll()) do
        ply:KillSilent()
      end
    end
  end
end

-- Semantic Functions
function modeClass:isPlay()
  return modeClass.current == MODE_PLAY
end

function modeClass:isCreate()
  return modeClass.current == MODE_CREATE
end

-- Assign this class to the global nz table
nz.Mode = modeClass
-- Run the constructor
nz.Mode:constructor()
