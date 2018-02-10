include("shared.lua")
include("realm_loader.lua")

-- Main Tables
nz = {}
nz.Framework = {}
nz.Framework.Debug = {}

-- Load the framework's model library
realmLoader("nzombies/gamemode/framework/models")
-- Load the framework's debug library
realmLoader("nzombies/gamemode/framework/debug")
-- Load the framework's environment library
realmLoader("nzombies/gamemode/framework/environment")

-- Load the gamemode modules
realmLoader("nzombies/gamemode/modules")
