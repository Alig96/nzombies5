include("shared.lua")
-- Framework
include("framework/init.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("framework/cl_init.lua")

-- Load the gamemode modules
gel.fw:loadDirectory("nzombies/gamemode/modules")

-- Load tests
include("nzombies/gamemode/tests/sv_gunit.lua")
