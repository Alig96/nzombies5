if CLIENT then
	--  Client to Server (Client)
	function nz.Request.sendRemovePlayerSpawner(seletedEntity)
		nz.Debug.Print("info", "[Request:Tools] Requesting to 'Remove Player Spawner'")

		net.Start("nz.Request.removePlayerSpawner")
			net.WriteEntity(seletedEntity)
		net.SendToServer()
	end
end

if SERVER then
	-- Client to Server (Server)
	util.AddNetworkString("nz.Request.removePlayerSpawner")

	function nz.Request.recieveRemovePlayerSpawner(length, requestingPlayer)
		if requestingPlayer:IsValid() then
			nz.Debug.Print("info", "[Sync] Received 'Remove Player Spawner' request from: " .. requestingPlayer:Nick() .. ". Length: " .. length)
			local selectedEntity = net.ReadEntity()

			-- Send the requst to the controller
			local status = nz.Controller.handleRemovePlayerSpawner(requestingPlayer, {
				["selectedEntity"] = selectedEntity,
			})

			-- Notify the requesting player if the status of their request passed or not
		end
	end

	-- Receivers
	net.Receive("nz.Request.removePlayerSpawner", nz.Request.recieveRemovePlayerSpawner)
end
