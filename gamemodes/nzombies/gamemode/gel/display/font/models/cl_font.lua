local prototypeFont = {}

-- Required
prototypeFont.id = "BaseFont"

prototypeFont.extended = false
prototypeFont.size = 12
prototypeFont.weight = 500
prototypeFont.blursize = 0
prototypeFont.scanlines = 0
prototypeFont.antialias = true
prototypeFont.underline = false
prototypeFont.italic = false
prototypeFont.strikeout = false
prototypeFont.symbol = false
prototypeFont.rotary = false
prototypeFont.shadow = false
prototypeFont.additive = false
prototypeFont.outline = false

-- Register this prototype as a model
gel.fw:newModel("Font", prototypeFont, {"id"})
