hook.Add("GUnitReady", "TestLoadHookNameHere", function()
    GUnit.load()
end)

if GUnit then
  GUnit.load()
end
