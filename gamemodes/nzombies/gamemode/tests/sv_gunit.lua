hook.Add("GUnitReady", "TestLoadHookNameHere", function()
    GUnit.load()
end)

if GUnit then
  GUnit.load()
  GUnit.kickAllBots = function()
    -- Kick all bots
    for _, bot in pairs(player.GetBots()) do
      if bot:IsValid() then
        bot:Kick()
      end
    end
  end
end
