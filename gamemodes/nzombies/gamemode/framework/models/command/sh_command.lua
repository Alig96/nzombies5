local prototypeCommand = {}

prototypeCommand.triggerSymbol = "/"
prototypeCommand.triggerPhrase = "trigger"

function prototypeCommand:onCalled(callingPlayer, additionalParameters)
  print(callingPlayer:Nick())
end

-- Register this prototype as a model
nz.Framework.registerModel(prototypeCommand, "Command", {"triggerPhrase", "onCalled", "triggerSymbol"})
