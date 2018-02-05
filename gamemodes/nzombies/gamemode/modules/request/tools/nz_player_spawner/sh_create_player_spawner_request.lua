if CLIENT then
	--  Client to Server (Client)
	function nz.Request.sendCreatePlayerSpawner(createPosition)
		nz.Debug.Print("info", "[Request:Tools] Requesting to 'Create Player Spawner' at: " .. tostring(createPosition))

		net.Start("nz.Request.createPlayerSpawner")
			net.WriteVector(createPosition)
		net.SendToServer()
	end
end

if SERVER then
	-- Client to Server (Server)
	util.AddNetworkString("nz.Request.createPlayerSpawner")

	function nz.Request.recieveCreatePlayerSpawner(length, requestingPlayer)
		if requestingPlayer:IsValid() then
			nz.Debug.Print("info", "[Sync] Received 'Create Player Spawner' request from: " .. requestingPlayer:Nick() .. ". Length: " .. length)
			local createPosition = net.ReadVector()

			-- Send the requst to the controller
			local status = nz.Controller.handleCreatePlayerSpawner(requestingPlayer, {
				["createPosition"] = createPosition,
			})

			-- Notify the requesting player if the status of their request passed or not
		end
	end

	-- Receivers
	net.Receive("nz.Request.createPlayerSpawner", nz.Request.recieveCreatePlayerSpawner)
end
