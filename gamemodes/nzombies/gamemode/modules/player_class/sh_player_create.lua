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

	timer.Simple(0.1, function()
		if IsValid(self.Player) and !self.Player:HasWeapon( "weapon_physgun" ) then
			self.Player:Give( "weapon_physgun" )
		end
	end)

end

player_manager.RegisterClass( "player_create", PLAYER, "player_default" )
