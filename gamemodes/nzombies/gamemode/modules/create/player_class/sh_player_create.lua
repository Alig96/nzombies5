DEFINE_BASECLASS("player_default")

local playerClass = {}
playerClass.WalkSpeed = 300
playerClass.RunSpeed = 600
playerClass.CanUseFlashlight = true

function playerClass:Loadout()
	-- Creation Tools
	self.Player:Give("weapon_physgun")
	self.Player:Give("nz_multi_tool")
end

player_manager.RegisterClass("player_create", playerClass, "player_default")
