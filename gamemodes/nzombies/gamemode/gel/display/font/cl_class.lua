local fontClass = {}
fontClass.generatedFonts = {}

local fontModel = gel.fw:getModel("Font")

function fontClass:new(id)
  -- Create a new font using the font model
  local newFont = fontModel:create(id)

  function newFont:getUniqueId()
    -- Get the base font and don't change anything
    local baseFont = fontModel:make()
    -- Generate a unique font name
    local uniqueFontName = ""
    for k, v in pairs(baseFont) do
      -- Go through and check each value, if its not default, append it to the string
      if self[k] != baseFont[k] then
        uniqueFontName = uniqueFontName .. k .. ":" .. tostring(self[k]) .. ","
      end
    end

    return uniqueFontName
  end

  function newFont:generate()
    -- Generate a unique name based on what we've changed from default
    return gel.Internal.Font:generateFont(self:getUniqueId(), self)
  end

  -- Since we added the magic methods, we should update our controller in the database
  fontModel:update(newFont.id, newFont)
  -- Notify
  Log(LOG_INFO, "Successfully created Font: " .. newFont.id, "Framework:Font")
  -- Return the finished font object from the database
  return fontModel:find(newFont.id)
end

function fontClass:get(id)
  -- Find the font
  local font = fontModel:find(id)
  if font then
    return font
  end

  Log(LOG_INFO, "Could not get Font: " .. id, "Framework:Font")
end

function fontClass:check(id)
  if self.generatedFonts[id] then
    return true
  end
  return false
end

function fontClass:register(id)
  -- We don't need to store the full font object, just mark it as "generated" to prevent it being made a million times
  self.generatedFonts[id] = true
end

function fontClass:generateFont(uniqueFontName, fontObject)
  -- To prevent us creating a million of the same font
  if !self:check(uniqueFontName) then
    surface.CreateFont(uniqueFontName, {
      font = fontObject.id,
      extended = fontObject.extended,
      size = fontObject.size,
      weight = fontObject.weight,
      blursize = fontObject.blursize,
      scanlines = fontObject.scanlines,
      antialias = fontObject.antialias,
      underline = fontObject.underline,
      italic = fontObject.italic,
      strikeout = fontObject.strikeout,
      symbol = fontObject.symbol,
      rotary = fontObject.rotary,
      shadow = fontObject.shadow,
      additive = fontObject.additive,
      outline = fontObject.outline,
    })
  -- Register to the class that we've generated a font
  self:register(uniqueFontName)
  end
  -- Return the unique font name so we can use it in our functions without knowing the actual unique name
  return uniqueFontName
end

-- Assign the class table to the gel global
gel.Internal.Font = fontClass

-- Make a shortcut to using this library
function gel.fw:newFont(...)
  return gel.Internal.Font:new(...)
end

-- Make a shortcut to using this library
function gel.fw:getFont(...)
  -- Get a copy of the font so we can manipulate it later without it affecting anything else
  return table.Copy(gel.Internal.Font:get(...))
end
