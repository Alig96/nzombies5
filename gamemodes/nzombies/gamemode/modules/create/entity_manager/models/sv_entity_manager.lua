local prototypeEntityManager = {}

prototypeEntityManager.id = "BaseEntityManager"

-- Register this prototype as a model
gel.fw:newModel("EntityManager", prototypeEntityManager, {"id"})
