-- Get the prop model
local propModel = gel.fw:getModel("Prop")

local propClass = {}

function propClass:new(name, model, category)
  -- Create a new prop object
  local newProp = propModel:create(name, model, category)

  -- Notify
  Log(LOG_INFO, "Successfully created Prop: " .. newProp.name, "Prop")
  -- Return the finished prop object from the database
  return newProp
end

function propClass:all()
  -- Get all registered props
  return propModel:all()
end

-- Assign this class to the global nz table
nz.Prop = propClass
