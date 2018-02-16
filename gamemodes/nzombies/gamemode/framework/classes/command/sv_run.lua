-- Register framwork specific commands
gel.fw:newCommand("Console", "qr", function(ply)
  if ply:IsValid() then return end
  RunConsoleCommand("changelevel", game.GetMap())
end)

-- This should go in the actual gamemode functions
gel.fw:newCommand("Console", "qt", function(ply)
  if ply:IsValid() then return end
  RunConsoleCommand("test-only", "nzombies5")
end)
