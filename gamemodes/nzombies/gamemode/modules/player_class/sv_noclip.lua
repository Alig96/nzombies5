function GM:PlayerNoClip( ply, desiredState )
  if ply:Alive() and nz.Mode:isCreative() then
    nz.Debug.Print("info", "Toggling noclip for: " .. ply:Nick())
    return true
  end
end
