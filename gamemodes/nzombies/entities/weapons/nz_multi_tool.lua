SWEP.PrintName = "nZombies Multi Tool"
SWEP.Author = "Zet0rz, Alig96"
SWEP.Instructions = "Left mouse to fire a chair!"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.ViewModel = "models/weapons/c_toolgun.mdl"
SWEP.WorldModel = "models/weapons/w_toolgun.mdl"
SWEP.ShootSound = Sound( "Airboat.FireGunRevDown" )

SWEP.UseHands = true

function SWEP:Precache()
  util.PrecacheModel( SWEP.ViewModel )
  util.PrecacheModel( SWEP.WorldModel )
  util.PrecacheSound( self.ShootSound )
end

function SWEP:DoShootEffect( hitpos, hitnormal, entity, physbone, bFirstTimePredicted )
  self:EmitSound( self.ShootSound	)
  self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

  self.Owner:SetAnimation( PLAYER_ATTACK1 )

  if ( !bFirstTimePredicted ) then return end

  local selectionEffect = EffectData()
  selectionEffect:SetOrigin( hitpos )
  selectionEffect:SetNormal( hitnormal )
  selectionEffect:SetEntity( entity )
  selectionEffect:SetAttachment( physbone )
  util.Effect( "selection_indicator", selectionEffect )

  local tracerEffect = EffectData()
  tracerEffect:SetOrigin( hitpos )
  tracerEffect:SetStart( self.Owner:GetShootPos() )
  tracerEffect:SetAttachment( 1 )
  tracerEffect:SetEntity( self )
  util.Effect( "ToolTracer", tracerEffect )
end

function SWEP:PrimaryAttack()
  local tr = util.GetPlayerTrace( self.Owner )
  tr.mask = bit.bor( CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_MONSTER, CONTENTS_WINDOW, CONTENTS_DEBRIS, CONTENTS_GRATE, CONTENTS_AUX )
  local trace = util.TraceLine( tr )
  if (!trace.Hit) then return end

  -- Do the effcts
  self:DoShootEffect( trace.HitPos, trace.HitNormal, trace.Entity, trace.PhysicsBone, IsFirstTimePredicted() )

  if CLIENT and !game.SinglePlayer() and !IsFirstTimePredicted() then return end

  -- Do logic for the tool
  if SERVER then
    nz.Debug.Print("info", "[Weapon:Tool] " .. self.Owner:Nick() .. " requested to place a Player Spawner")
    nz.Creative.Spawn:addPlayerSpawner(trace.HitPos)
  end

  if ( game.SinglePlayer() ) then self:CallOnClient( "PrimaryAttack" ) end
end

function SWEP:SecondaryAttack()
  local tr = util.GetPlayerTrace( self.Owner )
  tr.mask = bit.bor( CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_MONSTER, CONTENTS_WINDOW, CONTENTS_DEBRIS, CONTENTS_GRATE, CONTENTS_AUX )
  local trace = util.TraceLine( tr )
  if (!trace.Hit) then return end

  -- Do the effcts
  self:DoShootEffect( trace.HitPos, trace.HitNormal, trace.Entity, trace.PhysicsBone, IsFirstTimePredicted() )

  if CLIENT and !game.SinglePlayer() and !IsFirstTimePredicted() then return end

  -- Do logic for the tool
  if SERVER then
    nz.Debug.Print("info", "[Weapon:Tool] " .. self.Owner:Nick() .. " requested to remove a Player Spawner")
    nz.Creative.Spawn:removePlayerSpawner(trace.Entity)
  end

  if ( game.SinglePlayer() ) then self:CallOnClient( "SecondaryAttack" ) end
end
