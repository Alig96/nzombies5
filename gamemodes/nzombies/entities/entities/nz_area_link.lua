AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "nz_editable_entity"
ENT.PrintName = "Area Link"

ENT.model = "models/hunter/blocks/cube05x05x05.mdl"
ENT.category = "Areas"

ENT.editableProperties = {
	["AreaName"] = {
		category = "Area",
		name = "Name",
		type = "String",
		default = "Generic Area"
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
