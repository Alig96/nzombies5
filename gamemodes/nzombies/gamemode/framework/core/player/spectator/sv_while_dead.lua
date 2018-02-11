local function whileDead(killedPlayer)
  if killedPlayer:isSpectator() then
    if killedPlayer:KeyPressed(IN_ATTACK) then
      killedPlayer:cycleSpectatePlayer()
    elseif killedPlayer:KeyPressed(IN_ATTACK2) then
      killedPlayer:cycleSpectateMode()
    end
  end
end

hook.Add( "PlayerDeathThink", "nz.Framework.Player.Spectator.WhileDead", whileDead)
