include("shared.lua")
include("realm_loader.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("realm_loader.lua")

-- Framework
AddCSLuaFile("framework/init.lua")
include("framework/init.lua")

-- Main Tables
nz = {}

-- Load the gamemode modules
realmLoader("nzombies/gamemode/modules")

-- Load tests
include("nzombies/gamemode/tests/sv_gunit.lua")
