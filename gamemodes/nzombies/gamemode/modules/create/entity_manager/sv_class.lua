-- Get the entity manager model
local entityManagerModel = gel.fw:getModel("EntityManager")

local entityManagerClass = {}

function entityManagerClass:new(managerObject)
  -- Create a new entityManager object
  local newEntityManager = entityManagerModel:create(managerObject.id, managerObject.entityClass, managerObject.onCreate)

  -- Create a magic method for getting all entitys of this entityManager
  function newEntityManager:all()
    return ents.FindByClass(self.entityName)
  end

  -- Create a magic method for creating the entity
  function newEntityManager:create(position, angle, entityData)
    local ent = ents.Create(self.entityName)
    if entityData.model then
      ent:SetModel(entityData.model)
    end
    ent:SetPos(position)
    ent:SetAngles(angle)
    ent:Spawn()

    self:onCreate(ent, entityData)

    Log(LOG_INFO, "Created entity: " .. ent:GetClass() .. " in Manager: " .. self.id)
    return ent
  end

  -- Create a magic method for editing the entity
  function newEntityManager:edit(ent, newData)

  end

  -- Create a magic method for deleting the entity
  function newEntityManager:delete(ent)
    if ent:GetClass() == self.entityName then
      ent:Remove()
    else
      Log(LOG_ERROR, "Can't remove entity: " .. ent:GetClass() .. " in Manager: " .. self.id)
    end
  end

  -- Create a magic method for spawning the entity
  function newEntityManager:spawn(...)
    return self:create(...)
  end

  -- Since we added the magic methods, we should update our entityManager in the database
  entityManagerModel:update(newEntityManager.id, newEntityManager)
  -- Notify
  Log(LOG_INFO, "Successfully created EntityManager: " .. newEntityManager.id, "EntityManager")
  -- Return the finished entityManager object from the database
  return self:get(id)
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
