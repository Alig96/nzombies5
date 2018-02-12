function nz.Create.multiTool:setCurrentTool(toolId)
  -- Find multi tool
  local multiTool = LocalPlayer():GetWeapon("nz_multi_tool")
  if multiTool then
    -- Set the tool
    multiTool:loadTool(toolId)
  end
end
