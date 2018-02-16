local controllerClass = {}

function controllerClass:new(controllerId, onSuccessFunc, validationFunc, authorizationFunc)
  -- Get the Controller Model
  local controllerModel = gel.Internal.Model:get("Controller")

  -- Create a new controller object
  local newController = controllerModel:create(controllerId, onSuccessFunc, validationFunc, authorizationFunc)

  -- Create a magic method for validating the controller's data
  function newController:validateRequest(requestData)
    if self:validate(requestData) then
      return true
    else
      Log(LOG_ERROR, "Data supplied failed validation", "Controller:" .. self.id)
      return false
    end
  end

  -- Create a magic method for authorising a player
  function newController:authroizePlayer(requestingPlayer)
    if self:authorize(requestingPlayer) then
      return true
    else
      Log(LOG_ERROR, "Player: " .. requestingPlayer:Nick() .. " could not be authroised", "Controller:" .. self.id)
      return false
    end
  end

  -- Create a magic for authorising a player
  function newController:handleRequest(requestingPlayer, requestData)
    if requestingPlayer and requestData then
      if self:validateRequest(requestData) and self:authroizePlayer(requestingPlayer) then
        Log(LOG_DEBUG, requestingPlayer:Nick() ..  " has made a successful request to Controller", "Controller:" .. self.id)
        -- Run the controller's on success function
        self:onSuccess(requestingPlayer, requestData)
        -- Notify the requesting player
        return true
      end
    else
      Log(LOG_ERROR, "No Player or Request data was found. Check function call.", "Controller:" .. self.id)
    end
    return false
  end

  -- Since we added the magic methods, we should update our controller in the database
  controllerModel:update(newController.id, newController)
  -- Return the finished controller object from the database
  return controllerModel:find(newController.id)
end

function controllerClass:delete(controllerId)
  local controlerModel = gel.Internal.Model:get("Controller")
  -- Delete the controller
  controlerModel:delete(controllerId)
end

-- Assign the class table to the gel global
gel.Internal.Controller = controllerClass

-- Make a shortcut to using this library
function gel.fw:newController(...)
  return gel.Internal.Controller:new(...)
end
