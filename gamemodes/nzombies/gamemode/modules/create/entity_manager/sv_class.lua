-- Get the entity manager model
local entityManagerModel = gel.fw:getModel("EntityManager")

local entityManagerClass = {}

function entityManagerClass:new(managerId)
  -- Create a new entityManager object
  local newEntityManager = entityManagerModel:create(managerId)

  -- Create a magic method for getting all entitys of this entityManager
  function newEntityManager:all()
    return ents.FindByClass(self.id)
  end

  -- Create a magic method for creating the entity
  function newEntityManager:create(position, angle, model)
    local ent = ents.Create(self.id)
    if model then
      ent:SetModel(model)
    end
    -- Move the position up
    position.z = position.z + ent:OBBMaxs().z
    ent:SetPos(position)
    ent:SetAngles(angle)
    ent:Spawn()

    Log(LOG_INFO, "Created entity: " .. ent:GetClass(), "EntityManager:" .. self.id)
    return ent
  end

  -- Create a magic method for editing the entity
  function newEntityManager:edit(ent, newData)

  end

  -- Create a magic method for deleting the entity
  function newEntityManager:delete(ent)
    if ent:GetClass() == self.id then
      ent:Remove()
    else
      Log(LOG_ERROR, "Can't remove entity: " .. ent:GetClass(), "EntityManager:" .. self.id)
    end
  end

  -- Create a magic method for spawning the entity
  function newEntityManager:spawn(...)
    return self:create(...)
  end

  -- Since we added the magic methods, we should update our entityManager in the database
  entityManagerModel:update(managerId, newEntityManager)
  -- Notify
  Log(LOG_INFO, "Successfully created EntityManager: " .. managerId, "EntityManager")
  -- Return the finished entityManager object from the database
  return self:get(managerId)
end

function entityManagerClass:get(id)
  -- Find the entityManager
  local entityManager = entityManagerModel:find(id)
  if entityManager then
    return entityManager
  end

  Log(LOG_ERROR, "Could not get EntityManager: " .. id, "EntityManager")
end

-- Assign this class to the global nz table
nz.entityManager = entityManagerClass
