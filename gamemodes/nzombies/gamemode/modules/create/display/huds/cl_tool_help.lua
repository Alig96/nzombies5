-- Get and edit the font
local helvetica = gel.fw:getFont("Helvetica")
 -- Tool Title
helvetica.size = 54
helvetica.weight = 900
local toolTitle = helvetica:generate()

helvetica.size = 28
helvetica.weight = 900
local toolDescription = helvetica:generate()


-- Use the color libary
local white = gel.fw:getColor("primary")

gel.fw:newHUD("ToolHelp", function()
  local toolMeta = nz.Tool:get()
  -- Starting positions
  local x = ScrW() * 0.05
  local y = ScrH() * 0.1

  draw.SimpleText(gel.fw:translate(toolMeta.name), toolTitle, x, y, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
  y = y + 50
  draw.SimpleText(gel.fw:translate(toolMeta.description), toolDescription, x, y, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

  local toolData = nz.Tool:getToolData()
  y = y + 50
  if toolMeta.id == "tool_entity_creator" then
    if toolData.entity then
      local entityType = "Entity"
      if toolData.entity == "nz_prop" then
        entityType = "Prop"
      end
      draw.SimpleText("Current " .. entityType .. ": " .. toolData.data.name, toolDescription, x, y, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    else
      draw.SimpleText("Select an entity from the Q menu...", toolDescription, x, y, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    end
  elseif toolMeta.id == "tool_area_linker" then
    if toolData.entity then
      draw.SimpleText("Current Link: " .. toolData.entity:GetAreaName(), toolDescription, x, y, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    end
  end
end, function()
  if nz.Mode:isCreate() and LocalPlayer():GetActiveWeapon():GetClass() == "nz_multi_tool" and nz.Tool:get() then
    return true
  end
end)
