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

hook.Add("nz.Interface.populatePropMenu", "ffewfwf", function()
  local interface = gel.fw:getInterface("CreateMenu")
  interface.panel.leftSheet.sheets["Props"]:populate()
end)

hook.Add("InitPostEntity", "dasda", function()
  local interface = gel.fw:getInterface("CreateMenu")
  interface.panel.leftSheet.sheets["Entities"]:populate()
end)
