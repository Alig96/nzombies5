local modelClass = {}
modelClass.models = {}

function modelClass:validate(modelId, prototypeClass, editableProperites)
  if modelId == nil then
    Log(LOG_ERROR, "Cannot create a model without an ID", "Framework:Model")
    return false
  end

  if prototypeClass == nil then
    Log(LOG_ERROR, "Cannot create a model without a prototype class", "Framework:Model")
    return false
  end

  return true
end

function modelClass:get(modelId)
  local requestedModel = self.models[modelId]

  if requestedModel then
    return requestedModel
  else
    Log(LOG_ERROR, "Could not find a model with ID: " .. modelId, "Framework:Model")
  end

  return false
end

function modelClass:new(modelId, prototypeClass, editableProperites)
  if self:validate(modelId, prototypeClass) then
    -- Create a new model
    local newModel = {
      modelId = modelId,
      prototypeClass = prototypeClass,
      editableProperites = editableProperites,
      -- Register a database table for the model
      tableId = gel.Internal.Database:newTable(string.pluralize(modelId), prototypeClass.id)
    }

    function newModel:make(...)
      local arguments = {...}
      -- Get a copy of the base item
      local newItem = table.Copy(self.prototypeClass)

      -- Override the override the paramaters of the new item with the given ones from model's editableProperites
      for funcParamNumber, funcParamName in ipairs(self.editableProperites) do
        if arguments[funcParamNumber] then
          newItem[funcParamName] = arguments[funcParamNumber]
        end
      end

      -- Return the new item
      return newItem
    end

    function newModel:create(...)
      -- Create the item
      local newItem = self:make(...)
      -- Get the id
      local id = newItem.id or gel.Internal.Database:getNextUniqueId(self.tableId)
      -- Save the id of the item onto the created item
      newItem.id = id
      -- Store it in the database
      gel.Internal.Database:createRow(self.tableId, newItem, id)
      return newItem
    end

    function newModel:all()
      -- Get all of the results
      return gel.Internal.Database:selectAllRows(self.tableId)
    end

    function newModel:find(findModelId)
      -- Find it by Id in the database
      return gel.Internal.Database:selectRow(self.tableId, findModelId)
    end

    function newModel:update(findModelId, updatedItem)
      -- Update it in the database
      gel.Internal.Database:updateRow(self.tableId, findModelId, updatedItem)
      -- Return a fresh copy of the model item
      return self:find(findModelId)
    end

    function newModel:delete(findModelId)
      -- Delete the row in the database
      gel.Internal.Database:deleteRow(self.tableId, findModelId)
      -- Return a null value to show we removed it
      return nil
    end

    -- Register the model
    self:register(modelId, newModel)

    -- Return the new model
    return self:get(modelId)
  end

  return false
end

function modelClass:register(modelId, modelObject)
  self.models[modelId] = modelObject
  Log(LOG_INFO, "Registered Model: " .. modelId, "Framework:Model")
end

function modelClass:delete(modelId)
  local model = self:get(modelId)
  if model then
    -- Remove the database table for the model
    gel.Internal.Database:deleteTable(model.tableId)
    -- Unregister the model
    self.models[modelId] = nil
    -- Notify
    Log(LOG_WARN, "Un-Registered  & Deleted Model: " .. modelId, "Framework:Model")
  end
end

-- Assign the class table to the gel global
gel.Internal.Model = modelClass

-- Create shortcut
function gel.fw:newModel(...)
  return gel.Internal.Model:new(...)
end
