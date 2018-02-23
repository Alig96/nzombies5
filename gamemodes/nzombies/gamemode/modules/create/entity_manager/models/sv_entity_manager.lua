local prototypeEntityManager = {}

prototypeEntityManager.id = "BaseEntityManager"
prototypeEntityManager.entityName = "prop_physics"

function prototypeEntityManager:onCreate(newEntity, entityData)

end

-- Register this prototype as a model
gel.fw:newModel("EntityManager", prototypeEntityManager, {"id", "entityName", "onCreate"})
