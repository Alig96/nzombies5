function nz.Framework.registerModel(modelPrototype, modelPrototypeId, overrideParamaters)
  -- Create a magic method
  local magicMethod = function(...)
    local arguments = {...}
    -- Create the model
    local newModel = table.Copy(modelPrototype)

    -- Override the override the paramaters of the new model with the given ones from the magic method
    for funcParamNumber, funcParamName in ipairs(overrideParamaters) do
      if arguments[funcParamNumber] then
        newModel[funcParamName] = arguments[funcParamNumber]
      end
    end

    -- Return an instance of the new model
    return newModel
  end

  -- Register the magic method to the global namespace
  local nameOfFunction = "new" .. modelPrototypeId
  nz.Framework[nameOfFunction] = magicMethod

  print("Registered Model: " .. nameOfFunction)
end
