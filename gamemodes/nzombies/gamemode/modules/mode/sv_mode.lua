Mode = {}
Mode.__index = Mode
Mode.CurrentState = MODE_PLAY

function Mode:set( modeConst )
  nz.Mode.CurrentState = modeConst
  return nz.Mode.CurrentState
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

//Assign the meta table to the nz global
nz.Mode = setmetatable( Mode, { __call = Mode.set } )
