local prototypeSpawner = {}

prototypeSpawner.id = "BaseSpawner"
prototypeSpawner.entityName = "prop_physics"
prototypeSpawner.properties = {}

-- Register this prototype as a model
gel.fw:newModel("Spawner", prototypeSpawner, {"id", "entityName", "properties"})
