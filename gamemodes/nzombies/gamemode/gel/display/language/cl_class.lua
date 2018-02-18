local languageClass = {}
languageClass.current = nil
languageClass.fallback = nil

local languageModel = gel.fw:getModel("Language")

function languageClass:new(id, name, isFallbackLanguage)
  -- Create a new language using the model
  local newLanguage = languageModel:create(id, name)

  function newLanguage:translate(stringId, stringTranslation)
    self.strings[stringId] = stringTranslation
    -- Update ourself in the database
    languageModel:update(self.id, self)
  end

  -- Since we added the magic methods, we should update our language in the database
  languageModel:update(newLanguage.id, newLanguage)
  -- Notify
  Log(LOG_INFO, "Successfully created Language: " .. newLanguage.id, "Framework:Language")

  -- Set the fallback language
  if isFallbackLanguage then
    self.fallback = newLanguage.id
    -- Notify
    Log(LOG_INFO, "Set the fallback language to " .. newLanguage.id, "Framework:Language")
  end

  -- Return the finished language object from the database
  return languageModel:find(newLanguage.id)
end

function languageClass:set(id)
  -- Find the font
  local language = languageModel:find(id)
  if language then
    self.current = id
  end

  Log(LOG_INFO, "Could not find Language: " .. id, "Framework:Language")
end

function languageClass:translate(stringId, languageId)
  -- If the language is set
  if languageId == nil then
    -- Set it to the current language
    languageId = self.current
  end

  local language = languageModel:find(languageId)

  -- If we have a translation for the string
  local translationText = language.strings[stringId]
  if translationText then
    return translationText
  end

  -- Looks like we don't have the translation
  Log(LOG_WARN, "Language: " .. language.name .. " doesn't have a translation for: " .. stringId, "Framework:Language")

  -- If our current language is not the fallback, then try getting the translation from the fallback language
  if self.fallback then
    if languageId != self.fallback then
      return self:translate(stringId, self.fallback)
    end

    -- Looks like even our fallback language has the the translation
    Log(LOG_WARN, "The fall back language doesn't have a translation for: '" .. stringId .. "'. Check translations.", "Framework:Language")
  else
    -- We don't have a back up language
    Log(LOG_WARN, "There is no fallback language :(", "Framework:Language")
  end

  return "Translate: " .. stringId
end

-- Assign the class table to the gel global
gel.Internal.Language = languageClass

-- Make a shortcut to using this library
function gel.fw:newLanguage(...)
  return gel.Internal.Language:new(...)
end

-- Make a shortcut to using this library
function gel.fw:setLanguage(...)
  return gel.Internal.Language:set(...)
end

-- Make a shortcut to using this library
function gel.fw:translate(...)
  return gel.Internal.Language:translate(...)
end
