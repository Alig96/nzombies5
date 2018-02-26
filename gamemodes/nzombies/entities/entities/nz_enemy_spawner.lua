AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "nz_editable_entity"
ENT.PrintName = "Enemy Spawner"

ENT.model = "models/player/charple.mdl"
ENT.category = "Spawners"
ENT.isLinkable = true

ENT.editableProperties = {
	["LinkEntity"] = {
		category = "General",
		name = "Link Area",
		type = "Entity",
		display = "AreaName"
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
	self:SetColor(255, 0, 0, 255)
	self:DrawShadow(false)
end

if CLIENT then
	function ENT:Draw()
		if nz.Mode:isCreate() then
			self:DrawModel()
		end
	end
end
