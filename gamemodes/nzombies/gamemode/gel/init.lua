-- Framework
gel = {}
-- Internal
gel.Internal = {}
-- External
gel.fw = {}

-- Load the directory loader
include("critical/loader/sh_realm_loader.lua")
AddCSLuaFile("critical/loader/sh_realm_loader.lua")
-- Load the rest of the framework
include("shared.lua")
AddCSLuaFile("shared.lua")
