hook.Add("OnSpawnMenuOpen", "SpawnMenuWhitelist", function()
  gel.fw:getInterface("CreateMenu"):Open()
end)

hook.Add("OnSpawnMenuClose", "bfdb", function()
  gel.fw:getInterface("CreateMenu"):Close()
end)

-- populate
hook.Add("nz.Interface.populateToolMenu", "ggudhc", function()
  local interface = gel.fw:getInterface("CreateMenu")
  interface.panel.rightSheet.sheets["Tools"]:populate()
end)
