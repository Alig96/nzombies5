include("shared.lua")
include("realm_loader.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("realm_loader.lua")

-- Main Tables
nz = {}
local loader = Loader("nzombies/gamemode/modules/*")

-- Load tests
include("nzombies/gamemode/tests/sv_gunit.lua")
