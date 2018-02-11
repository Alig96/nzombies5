local logModuleName = "Sync"

if SERVER then
	-- Server to Client (Server)
	util.AddNetworkString("nz.Debug.Environment.Sync")

	function nz.Sync.sendDebugEnviroment(ply)
		if ply:IsValid() then
			Log(LOG_INFO, "Sending Debug Sync to: " .. ply:Nick(), logModuleName)
			net.Start("nz.Debug.Environment.Sync")
				net.WriteUInt(nz.Framework.Environment(), 2)
			net.Send(ply)
		end
	end

end

if CLIENT then
	-- Server to Client (Client)
	function nz.Sync.receiveDebugEnviroment(length)
		Log(LOG_INFO, "Received Debug Environment Sync. Length: " .. length, logModuleName)
		local serverEnvironment = net.ReadUInt(2)

		-- Set the local version of the environment
		nz.Framework.Environment:set(serverEnvironment)
	end

	-- Receivers
	net.Receive("nz.Debug.Environment.Sync", nz.Sync.receiveDebugEnviroment)
end
