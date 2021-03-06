include("shared.lua")
include("realm_loader.lua")

-- Main Tables
nz = {}
nz.Framework = {}
nz.Framework.Debug = {}
nz.Framework.Command = {}
nz.Framework.Request = {}
nz.Framework.Sync = {}

-- Load the framework's model library
realmLoader("nzombies/gamemode/framework/models")
-- Load the framework's debug library
realmLoader("nzombies/gamemode/framework/debug")
-- Load the framework's core library
realmLoader("nzombies/gamemode/framework/core")
-- Load the framework's classes library
realmLoader("nzombies/gamemode/framework/classes")

-- Load the gamemode modules
realmLoader("nzombies/gamemode/modules")
