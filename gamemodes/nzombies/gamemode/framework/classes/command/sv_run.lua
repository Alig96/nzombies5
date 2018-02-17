-- Register framwork specific commands

-- Quickly reloads the level
gel.fw:newCommand("Console", "qr", function(ply)
  if ply:IsValid() then return end
  RunConsoleCommand("changelevel", game.GetMap())
end)
