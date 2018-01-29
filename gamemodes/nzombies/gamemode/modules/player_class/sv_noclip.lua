function GM:PlayerNoClip( ply, desiredState )
  if ply:Alive() and nz.Mode:isCreative() then
    return true
  end
end
