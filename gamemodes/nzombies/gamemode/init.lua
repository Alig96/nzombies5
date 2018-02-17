include("shared.lua")
-- Framework
include("framework/init.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("framework/cl_init.lua")

-- Check the nz folder exists
if !file.Exists("nz/", "DATA") then
	file.CreateDir("nz")
end

-- Load the gamemode modules
gel.fw:loadDirectory("nzombies/gamemode/modules")

-- Load tests
include("nzombies/gamemode/tests/sv_gunit.lua")
