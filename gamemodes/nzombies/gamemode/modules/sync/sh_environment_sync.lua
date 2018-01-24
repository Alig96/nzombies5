if SERVER then
	-- Server to Client (Server)
	util.AddNetworkString("nz.Debug.Environment.Sync")

	function nz.Sync.sendDebugEnviroment(ply)
		if ply:IsValid() then
			nz.Debug.Print("info", "[Sync] Sending Debug Sync to: " .. ply:Nick())
			net.Start("nz.Debug.Environment.Sync")
				net.WriteUInt(nz.Debug.CurrentEnvironment, 2)
			net.Send(ply)
		end
	end

end

if CLIENT then
	-- Server to Client (Client)
	function nz.Sync.receiveDebugEnviroment(length)
		nz.Debug.Print("info", "[Sync] Received Debug Environment Sync. Length: " .. length)
		local serverEnvironment = net.ReadUInt(2)

		-- Set the local version of the environment
		nz.Debug.Environment(serverEnvironment)
	end

	-- Receivers
	net.Receive("nz.Debug.Environment.Sync", nz.Sync.receiveDebugEnviroment)
end
