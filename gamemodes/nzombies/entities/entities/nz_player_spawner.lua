AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Player Spawner"

ENT.viewModel = "models/player/odessa.mdl"

function ENT:Precache()
	util.PrecacheModel(self.viewModel)
end

function ENT:Initialize()
	self:Precache()

	self:SetModel(self.viewModel)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetColor(0, 255, 0, 255)
	self:DrawShadow(false)
end

if CLIENT then
	function ENT:Draw()
		if nz.Mode:isCreative() then
			self:DrawModel()
		end
	end
end
