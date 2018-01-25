if SERVER then
	-- Server to Client (Server)
	util.AddNetworkString("nz.Mode.Sync")

	function nz.Sync.sendMode(ply)
		if ply:IsValid() then
			nz.Debug.Print("info", "[Sync] Sending Mode Sync to: " .. ply:Nick())
			net.Start("nz.Mode.Sync")
				net.WriteUInt(nz.Mode.CurrentState, 2)
			net.Send(ply)
		end
	end

end

if CLIENT then
	-- Server to Client (Client)
	function nz.Sync.receiveMode(length)
		nz.Debug.Print("info", "[Sync] Received Mode Sync. Length: " .. length)
		local currentMode = net.ReadUInt(2)

		-- Set the local version of the environment
		nz.Mode(currentMode)
	end

	-- Receivers
	net.Receive("nz.Mode.Sync", nz.Sync.receiveMode)
end