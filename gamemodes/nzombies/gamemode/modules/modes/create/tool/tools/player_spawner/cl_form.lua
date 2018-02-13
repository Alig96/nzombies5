local playerSpawnerToolForm = {}

function playerSpawnerToolForm:Init()
  self.propertiesForm = vgui.Create("DProperties", self)
  self.propertiesForm:Dock(FILL)
  self.formData = {}
  self.attributeRows = {}

  local formAtrributes = {
    {
      categoryId = "Category",
      id = "genericAtrribute",
      name = "Generic Atrribute",
      type = "Generic",
      defaultValue = "Test",
    }
  }

  for _, attribute in pairs(formAtrributes) do
    self.formData[attribute.id] = attribute.defaultValue
    self.attributeRows[attribute.id] = self.propertiesForm:CreateRow(attribute.categoryId, attribute.name)
    self.attributeRows[attribute.id]:Setup(attribute.type)
    self.attributeRows[attribute.id]:SetValue(self.formData[attribute.id])
    self.attributeRows[attribute.id].DataChanged = function(panel, newValue) self.formData[attribute.id] = newValue end
  end
end

function playerSpawnerToolForm:getFormData()
  return self.formData
end

vgui.Register("nz.Forms.playerSpawnerTool", playerSpawnerToolForm, "EditablePanel")
