local modeSwitcherTest = GUnit.Test:new("ModeSwitcher")

local function can_set_mode()
  nz.Mode:set(MODE_CREATIVE)
  GUnit.assert(nz.Mode:get()):shouldEqual(MODE_CREATIVE)
end

local function can_check_if_in_play_mode()
  nz.Mode:set(MODE_PLAY)
  GUnit.assert(nz.Mode:isPlay()):shouldEqual(true)
end

local function can_check_if_in_creative_mode()
  nz.Mode:set(MODE_CREATIVE)
  GUnit.assert(nz.Mode:isCreative()):shouldEqual(true)
end

modeSwitcherTest:addSpec("can set mode", can_set_mode)
modeSwitcherTest:addSpec("can check if in play mode", can_check_if_in_play_mode)
modeSwitcherTest:addSpec("can check if in creative mode", can_check_if_in_creative_mode)
