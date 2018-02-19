local exampleRequest = {}

exampleRequest.id = "exampleRequest"

function exampleRequest:onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = gel.fw:handleController("NewController", requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

gel.fw:newRequest(exampleRequest)
-- gel.fw:sendRequest("exampleRequest", {"hey"})
