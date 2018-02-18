include("shared.lua")
-- Framework
include("gel/init.lua")

AddCSLuaFile("shared.lua")
-- Framework
AddCSLuaFile("gel/cl_init.lua")

-- Check the nz folder exists
if !file.Exists("nz/", "DATA") then
	file.CreateDir("nz")
end

-- Load the gamemode's languages
gel.fw:loadDirectory("nzombies/gamemode/client")

-- Load the gamemode modules
gel.fw:loadDirectory("nzombies/gamemode/modules")

-- Load tests
include("nzombies/gamemode/tests/sv_gunit.lua")
