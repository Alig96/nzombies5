local prototypeColor = {}

prototypeColor.id = "BaseColor"
prototypeColor.color = Color(255,255,255)

-- Register this prototype as a model
gel.fw:newModel("Color", prototypeColor, {"id", "color"})
