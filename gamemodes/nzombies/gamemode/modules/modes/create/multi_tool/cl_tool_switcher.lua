function nz.Create.multiTool:setCurrentTool(toolId)
  -- Switch our current weapon to the tool gun
  RunConsoleCommand("use", "nz_multi_tool")
  local multiTool = LocalPlayer():GetWeapon("nz_multi_tool")
  if multiTool then
    -- Set the tool
    multiTool:setCurrentTool(toolId)
  end
end
