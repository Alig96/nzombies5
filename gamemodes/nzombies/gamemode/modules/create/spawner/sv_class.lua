-- Get the spawner model
local spawnerModel = gel.fw:getModel("Spawner")

local spawnerClass = {}

function spawnerClass:new(id, entityName, defaultProperties)
  -- Create a new spawner object
  local newSpawner = spawnerModel:create(id, entityName, defaultProperties)

  -- Create a magic method for getting all entitys of this spawner
  function newSpawner:all()
    return ents.FindByClass(self.entityName)
  end

  -- Create a magic method for spawning the entity
  function newSpawner:spawn(position, angle)
    local ent = ents.Create(self.entityName)
    position.z = position.z - ent:OBBMaxs().z
    ent:SetPos(position)
    ent:SetAngles(angle)
    ent:Spawn()
  end

  -- Since we added the magic methods, we should update our spawner in the database
  spawnerModel:update(newSpawner.id, newSpawner)
  -- Notify
  Log(LOG_INFO, "Successfully created Spawner: " .. newSpawner.id, "Spawner")
  -- Return the finished spawner object from the database
  return self:get(id)
end

function spawnerClass:get(id)
  -- Find the spawner
  local spawner = spawnerModel:find(id)
  if spawner then
    return spawner
  end

  Log(LOG_ERROR, "Could not get Spawner: " .. id, "Spawner")
end

-- Assign this class to the global nz table
nz.Spawner = spawnerClass
