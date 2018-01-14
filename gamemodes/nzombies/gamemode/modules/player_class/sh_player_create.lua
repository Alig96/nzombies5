DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--
PLAYER.WalkSpeed 			= 300
PLAYER.RunSpeed				= 600
PLAYER.CanUseFlashlight     = true

function PLAYER:Loadout()
	-- Creation Tools
	self.Player:Give( "weapon_physgun" )
	self.Player:Give( "nz_multi_tool" )
end

player_manager.RegisterClass( "player_create", PLAYER, "player_default" )
