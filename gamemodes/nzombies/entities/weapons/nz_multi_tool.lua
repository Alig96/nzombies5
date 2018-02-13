SWEP.PrintName = "nZombies Multi Tool"
SWEP.Author = "Zet0rz, Alig96"
SWEP.Instructions = "Hold Q to change tools."

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

-- nZ
SWEP.nextShot = 0
SWEP.currentTool = nil


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
  if CurTime() >= self.nextShot and self.currentTool != "none" then
    local tr = util.GetPlayerTrace( self.Owner )
    tr.mask = bit.bor( CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_MONSTER, CONTENTS_WINDOW, CONTENTS_DEBRIS, CONTENTS_GRATE, CONTENTS_AUX )
    local trace = util.TraceLine( tr )
    if (!trace.Hit) then return end

    -- Do the effcts
    self:DoShootEffect( trace.HitPos, trace.HitNormal, trace.Entity, trace.PhysicsBone, IsFirstTimePredicted() )

    if CLIENT and !game.SinglePlayer() and !IsFirstTimePredicted() then return end

    -- Do logic for the tool
    if CLIENT then
      if self.currentTool then
        Log(LOG_DEBUG, "Requesting to trigger: " .. self.currentTool.name .. "'s Left Click Function.", "Weapon:Multi-Tool")
        self.currentTool:onLeftClick(trace)
      end
    end

    self.nextShot = CurTime() + 0.5

    if ( game.SinglePlayer() ) then self:CallOnClient( "PrimaryAttack" ) end
  end
end

function SWEP:SecondaryAttack()
  if CurTime() >= self.nextShot and self.currentTool != "none" then
    local tr = util.GetPlayerTrace( self.Owner )
    tr.mask = bit.bor( CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_MONSTER, CONTENTS_WINDOW, CONTENTS_DEBRIS, CONTENTS_GRATE, CONTENTS_AUX )
    local trace = util.TraceLine( tr )
    if (!trace.Hit) then return end

    -- Do the effcts
    self:DoShootEffect( trace.HitPos, trace.HitNormal, trace.Entity, trace.PhysicsBone, IsFirstTimePredicted() )

    if CLIENT and !game.SinglePlayer() and !IsFirstTimePredicted() then return end

    -- Do logic for the tool
    if CLIENT then
      if self.currentTool then
        Log(LOG_DEBUG, "Requesting to trigger: " .. self.currentTool.name .. "'s Right Click Function.", "Weapon:Multi-Tool")
        self.currentTool:onRightClick(trace)
      end
    end

    self.nextShot = CurTime() + 0.5

    if ( game.SinglePlayer() ) then self:CallOnClient( "SecondaryAttack" ) end
  end
end


if CLIENT then
  function SWEP:setCurrentTool(idOfTool)
    local toolData = nz.Create.Tool:getTool(idOfTool)
    if toolData then
      Log(LOG_INFO, "Changed tool to: " .. toolData.name .. ".", "Weapon:Multi-Tool")
      self.currentTool = toolData
    end
  end

  -- https://raw.githubusercontent.com/Facepunch/garrysmod/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/cl_viewscreen.lua
  local matScreen = Material( "models/weapons/v_toolgun/screen" )
  local txBackground = surface.GetTextureID( "models/weapons/v_toolgun/screen_bg" )

  -- GetRenderTarget returns the texture if it exists, or creates it if it doesn't
  local RTTexture = GetRenderTarget( "GModToolgunScreen", 256, 256 )

  surface.CreateFont( "GModToolScreen", {
  	font	= "Helvetica",
  	size	= 60,
  	weight	= 900
  } )

  local function DrawScrollingText( text, y, texwide )

  	local w, h = surface.GetTextSize( text )
  	w = w + 64

  	y = y - h / 2 -- Center text to y position

  	local x = RealTime() * 250 % w * -1

  	while ( x < texwide ) do

  		surface.SetTextColor( 0, 0, 0, 255 )
  		surface.SetTextPos( x + 3, y + 3 )
  		surface.DrawText( text )

  		surface.SetTextColor( 255, 255, 255, 255 )
  		surface.SetTextPos( x, y )
  		surface.DrawText( text )

  		x = x + w

  	end

  end

  --[[---------------------------------------------------------
  	We use this opportunity to draw to the toolmode
  		screen's rendertarget texture.
  -----------------------------------------------------------]]
  function SWEP:RenderScreen()

  	local TEX_SIZE = 256
  	local oldW = ScrW()
  	local oldH = ScrH()
    local text = "Hold Q to select a tool..."

    if self.currentTool then
      text = self.currentTool.name .. " Tool"
    end

  	-- Set the material of the screen to our render target
  	matScreen:SetTexture( "$basetexture", RTTexture )

  	local OldRT = render.GetRenderTarget()

  	-- Set up our view for drawing to the texture
  	render.SetRenderTarget( RTTexture )
  	render.SetViewPort( 0, 0, TEX_SIZE, TEX_SIZE )

  	cam.Start2D()
    	-- Background
    	surface.SetDrawColor( 255, 255, 255, 255 )
    	surface.SetTexture( txBackground )
    	surface.DrawTexturedRect( 0, 0, TEX_SIZE, TEX_SIZE )

      surface.SetFont( "GModToolScreen" )
      DrawScrollingText( text, 104, TEX_SIZE )
  	cam.End2D()

  	render.SetRenderTarget( OldRT )
  	render.SetViewPort( 0, 0, oldW, oldH )

  end
end
