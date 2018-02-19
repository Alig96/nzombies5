include("shared.lua")
-- Framework
include("gel/init.lua")

AddCSLuaFile("shared.lua")
-- Framework
AddCSLuaFile("gel/cl_init.lua")

-- Load the gamemode's languages
gel.fw:loadDirectory("nzombies/gamemode/client")

-- Load the gamemode modules
gel.fw:loadDirectory("nzombies/gamemode/modules")

-- Load tests
include("nzombies/gamemode/tests/sv_gunit.lua")
