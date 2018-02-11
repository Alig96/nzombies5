local requestTest = GUnit.Test:new("[Framework] Models > Request")

local function a_request_can_be_created()
  -- Create a request
  local newRequest = nz.Framework.createRequest("TestRequest")

  -- Assert the chat command has been created
  GUnit.assert(newRequest.id):shouldEqual("TestRequest")
end

requestTest:addSpec("can be created", a_request_can_be_created)
