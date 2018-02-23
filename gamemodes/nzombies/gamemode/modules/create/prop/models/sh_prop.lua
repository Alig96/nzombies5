local prototypeProp = {}

prototypeProp.category = "scenery"
prototypeProp.name = "Oil Drum"
prototypeProp.model = "models/props_c17/oildrum001.mdl"

-- Register this prototype as a model
gel.fw:newModel("Prop", prototypeProp, {"name", "model", "category"})
