local prototypeFont = {}

-- Required
prototypeFont.id = "BaseFont"
prototypeFont.size = 12
-- Optional
prototypeFont.weight = 500
prototypeFont.antialias = true
prototypeFont.shadow = false
-- We don't need them yet
prototypeFont.extended = false
prototypeFont.blursize = 0
prototypeFont.scanlines = 0
prototypeFont.underline = false
prototypeFont.strikeout = false
prototypeFont.symbol = false
prototypeFont.rotary = false
prototypeFont.additive = false
prototypeFont.outline = false

-- Register this prototype as a model
gel.fw:newModel("Font", prototypeFont, {"id"})
