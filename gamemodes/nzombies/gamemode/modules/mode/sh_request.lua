local changeModeRequest = {}

changeModeRequest.id = "ChangeMode"

function changeModeRequest:onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = gel.fw:handleController("ChangeMode", requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

gel.fw:newRequest(changeModeRequest.id, changeModeRequest.onReceive)
