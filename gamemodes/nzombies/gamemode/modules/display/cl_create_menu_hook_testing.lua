hook.Add("OnSpawnMenuOpen", "SpawnMenuWhitelist", function()
  gel.fw:getInterface("CreateMenu"):Open()
end)


hook.Add("OnSpawnMenuClose", "bfdb", function()
  gel.fw:getInterface("CreateMenu"):Close()
end)