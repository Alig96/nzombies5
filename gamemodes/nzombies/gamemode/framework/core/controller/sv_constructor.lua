function nz.Framework.createController(id, onSuccessFunc, authorizationFunc, validationFunc)
  -- Create a controller model
  local controllerModel = nz.Framework.newController(id, onSuccessFunc, authorizationFunc, validationFunc)

  -- Create a magic method for validating the controller's data
  function controllerModel:validateRequest(requestData)
    if controllerModel:validate(requestData) then
      return true
    else
      Log(LOG_ERROR, "Data supplied failed validation.", "Controller:" .. controllerModel.id)
      return false
    end
  end

  -- Create a magic method for authorising a player
  function controllerModel:authroizePlayer(requestingPlayer)
    if controllerModel:authorize(requestingPlayer) then
      return true
    else
      Log(LOG_ERROR, "Player: " .. requestingPlayer:Nick() .. " could not be authroised.", "Controller:" .. controllerModel.id)
      return false
    end
  end

  -- Create a magic method for handling the request to the controller
  function controllerModel:handleRequest(requestingPlayer, requestData)
    if requestingPlayer and requestData then
      if controllerModel:validateRequest(requestData) and controllerModel:authroizePlayer(requestingPlayer) then
        Log(LOG_INFO, requestingPlayer:Nick() ..  " has made a successful request to Controller.", "Controller:" .. controllerModel.id)
        -- Run the controller's on success function
        controllerModel:onSuccess(requestingPlayer, requestData)
        return true
      else
        return false
      end
    else
      Log(LOG_ERROR, "No Player or Request data was found. Check function call.", "Controller:" .. controllerModel.id)
      return false
    end
  end

  -- Return the finished controller
  return setmetatable(controllerModel, { __call = controllerModel.handleRequest } )
end
