local formClass = {}

function formClass:new(parentPanel, attributes)
  local formPanel = {}
  formPanel.Base = "DProperties"

  function formPanel:Init()
    self:Dock(FILL)
    self.formData = {}
    self.attributeRows = {}

    for id, attribute in pairs(attributes) do
      self.formData[id] = attribute.default
      self.attributeRows[id] = self:CreateRow(attribute.category, attribute.name)
      self:setupRow(self.attributeRows[id], attribute)
      if attribute.type == "Entity" then
        local entity = self.formData[id]
        -- Get the entity's display value
        if attribute.display and IsValid(entity) then
          self.attributeRows[id]:SetValue(entity["Get" .. attribute.display](entity))
        else
          self.attributeRows[id]:SetValue(entity:__tostring())
        end
        -- Disable the input of the text box
        -- Wasted too much time trying to work out how to disable this, low priority right now
      else
        self.attributeRows[id]:SetValue(self.formData[id])
      end
      self.attributeRows[id].DataChanged = function(panel, newValue) self.formData[id] = newValue end
    end
  end

  function formPanel:setupRow(rowPanel, attribute)
    if attribute.type == "Bool" then
      rowPanel:Setup("Boolean")
    elseif attribute.type == "Float" or attribute.type == "Int" then
      rowPanel:Setup(attribute.type, {min = attribute.min, max = attribute.max})
    else
      rowPanel:Setup("Generic")
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
