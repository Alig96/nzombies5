AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "nz_editable_entity"
ENT.PrintName = "Player Spawner"

ENT.model = "models/player/odessa.mdl"
ENT.category = "Spawners"

ENT.editableProperties = {
	["Order"] = {
		category = "General",
		name = "Player ID Spawning",
		type = "Int",
		default = 1,
		min = 1,
		max = 64
	}
}

function ENT:Precache()
	util.PrecacheModel(self.model)
end

function ENT:Initialize()
	self:Precache()

	self:SetModel(self.model)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetColor(0, 255, 0, 255)
	self:DrawShadow(false)
end

if CLIENT then
	function ENT:Draw()
		if nz.Mode:isCreate() then
			self:DrawModel()
		end
	end
end
