local entityEditorTool = {}

entityEditorTool.id = "tool_entity_editor"
entityEditorTool.name = "#tool_entity_editor"
entityEditorTool.description = "#tool_entity_editor_description"
entityEditorTool.instructions = {
  leftClick = "#tool_entity_editor_instructions_left",
  rightClick = "tool_entity_editor_instructions_right",
}

function entityEditorTool:onLeftClick(trace)
  local entity = trace.Entity
  if entity and entity.editableProperties then
    local editPanel = vgui.Create("DFrame")
    editPanel:SetSize(gel.fw:resoloutionScale(300, 200))
    editPanel:Center()
    editPanel:SetTitle("Editing: " .. entity.PrintName)
    editPanel:SetDraggable(false)
    editPanel:MakePopup()
    -- Make a form on the panel
    editPanel.Form = gel.fw:newForm(editPanel, entity:getEditableProperties())
    function editPanel:OnClose()
      -- Send an update
      gel.fw:sendRequest("UpdateEntity", {requestedEntity = entity, formData = editPanel.Form:getData()})
    end
  end
end

function entityEditorTool:onRightClick(trace)

end

-- Register this tool
nz.Tool:new(entityEditorTool)
