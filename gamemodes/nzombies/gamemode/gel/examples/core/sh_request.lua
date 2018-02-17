local newRequest = {}

newRequest.id = "NewRequest"

function newRequest:onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = gel.fw:handleController("NewController", requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

gel.fw:newRequest(newRequest.id, newRequest.onReceive)

-- gel.fw:sendRequest("NewRequest", {"hey"})
