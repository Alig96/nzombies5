local function onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = nz.Mode.updateController(requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

nz.Framework.createRequest("UpdateMode", onReceive)
-- nz.Framework.Request["UpdateMode"]:sendRequest({requestedMode = 1})
