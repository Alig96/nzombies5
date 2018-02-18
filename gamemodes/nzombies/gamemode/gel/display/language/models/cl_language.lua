local prototypeLanguage = {}

prototypeLanguage.id = "BaseLanguage"
prototypeLanguage.name = "Language"
prototypeLanguage.strings = {}

-- Register this prototype as a model
gel.fw:newModel("Language", prototypeLanguage, {"id", "name"})
