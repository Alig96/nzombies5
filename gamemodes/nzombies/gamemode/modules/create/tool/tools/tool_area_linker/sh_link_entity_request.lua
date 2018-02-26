local linkEntityRequest = {}

linkEntityRequest.id = "LinkEntity"

function linkEntityRequest:onReceive(requestingPlayer, requestData)
	-- Send the requst to the controller
	local status = gel.fw:handleController("LinkEntity", requestingPlayer, requestData)
	-- Notify the requesting player if the status of their request passed or not
end

gel.fw:newRequest(linkEntityRequest)
