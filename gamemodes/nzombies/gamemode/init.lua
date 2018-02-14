include("shared.lua")
AddCSLuaFile("shared.lua")

-- Framework
include("framework/init.lua")
AddCSLuaFile("framework/init.lua")

-- Load the gamemode modules
gel.fw:loadDirectory("nzombies/gamemode/modules")

-- Load tests
include("nzombies/gamemode/tests/sv_gunit.lua")
