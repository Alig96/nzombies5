local formClass = {}

function formClass:new(parentPanel, attributes)
  local formPanel = {}
  formPanel.Base = "DProperties"

  function formPanel:Init()
    self:Dock(FILL)
    self.formData = {}
    self.attributeRows = {}

    for _, attribute in pairs(attributes) do
      self.formData[attribute.id] = attribute.defaultValue
      self.attributeRows[attribute.id] = self:CreateRow(attribute.categoryId, attribute.name)
      self.attributeRows[attribute.id]:Setup(attribute.type)
      self.attributeRows[attribute.id]:SetValue(self.formData[attribute.id])
      self.attributeRows[attribute.id].DataChanged = function(panel, newValue) self.formData[attribute.id] = newValue end
    end
  end

  function formPanel:getData()
    return self.formData
  end

  return vgui.CreateFromTable(formPanel, parentPanel)
end

-- Assign the class table to the gel global
gel.Internal.Form = formClass

-- Make a shortcut to using this library
function gel.fw:newForm(...)
  return gel.Internal.Form:new(...)
end
