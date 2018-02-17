local interfaceClass = {}

local interfaceModel = gel.fw:getModel("Interface")

function interfaceClass:new(id, panelId)
  -- Create a new interface using the model
  local newInterface = interfaceModel:create(id, panelId)
  -- Create the panel
  newInterface.panel = vgui.Create(newInterface.panelId)
  -- Close the new interface
  newInterface:Close()

  -- Since we added the panel, we should update our interface in the database
  interfaceModel:update(newInterface.id, newInterface)
  -- Notify
  Log(LOG_INFO, "Successfully created Interface: " .. newInterface.id, "Framework:Interface")
  -- Return the finished interface object from the database
  return interfaceModel:find(newInterface.id)
end

function interfaceClass:get(id)
  -- Find the color
  local interface = interfaceModel:find(id)
  if interface then
    return interface
  end

  Log(LOG_INFO, "Could not get Interface: " .. id, "Framework:Interface")
end

-- Assign the class table to the gel global
gel.Internal.Interface = interfaceClass

-- Make a shortcut to using this library
function gel.fw:newInterface(...)
  return gel.Internal.Interface:new(...)
end

-- Make a shortcut to using this library
function gel.fw:getInterface(...)
  return gel.Internal.Interface:get(...)
end
