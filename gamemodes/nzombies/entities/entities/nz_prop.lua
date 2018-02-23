AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "nz_editable_entity"
ENT.PrintName = "Prop"

ENT.editableProperties = {
	["IsInvisible"] = {
		category = "General",
		name = "Set Invisible?",
		type = "Bool",
		default = false
	}
}

function ENT:Initialize()
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetColor(0, 255, 0, 255)
	self:DrawShadow(false)
end
