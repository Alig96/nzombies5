local function onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = nz.Controller.handleChangeMode(requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

nz.Framework.createRequest("ChangeMode", onReceive)
-- nz.Framework.Request["ChangeMode"]:sendRequest({requestedMode = MODE_PLAY})
