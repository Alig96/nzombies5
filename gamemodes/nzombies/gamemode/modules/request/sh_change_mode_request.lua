if CLIENT then
	--  Client to Server (Client)
	function nz.Request.sendChangeMode(newMode)
		nz.Debug.Print("info", "[Request] Requesting to change the mode to: " .. newMode)

		net.Start("nz.Request.changeMode")
			net.WriteUInt(newMode, 2)
		net.SendToServer()
	end
end

if SERVER then
	-- Client to Server (Server)
	util.AddNetworkString("nz.Request.changeMode")

	function nz.Request.recieveChangeMode(length, requestingPlayer)
		if requestingPlayer:IsValid() then
			nz.Debug.Print("info", "[Request] Received Change Mode Request from: " .. requestingPlayer:Nick() .. ". Length: " .. length)
			local newMode = net.ReadUInt(2)

			-- Send the requst to the controller
			local status = nz.Controller.handleChangeMode(requestingPlayer, {
				["requestedMode"] = newMode,
			})

			-- Notify the requesting player if the status of their request passed or not
		end
	end

	-- Receivers
	net.Receive("nz.Request.changeMode", nz.Request.recieveChangeMode)
end
