AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "Player Spawner"
ENT.Author			= "Alig96"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""


function ENT:Initialize()
	self:SetModel( "models/player/odessa.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetColor(0, 255, 0, 255)
	self:DrawShadow( false )
end

if CLIENT then
	function ENT:Draw()
		if nz.Mode:isCreative() then
			self:DrawModel()
		end
	end
end
