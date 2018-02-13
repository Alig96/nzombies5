local playerRow = {
	Init = function( self )

		self.AvatarButton = self:Add( "DButton" )
		self.AvatarButton:Dock( LEFT )
		self.AvatarButton:SetSize( 32, 32 )
		self.AvatarButton.DoClick = function() self.Player:ShowProfile() end

		self.Avatar = vgui.Create( "AvatarImage", self.AvatarButton )
		self.Avatar:SetSize( 32, 32 )
		self.Avatar:SetMouseInputEnabled( false )

		self.Name = self:Add( "DLabel" )
		self.Name:Dock( FILL )
		self.Name:SetFont( "ScoreboardDefault" )
		self.Name:SetTextColor( nz.Colours["secondary"] )
		self.Name:DockMargin( 8, 0, 0, 0 )

		self.Mute = self:Add( "DImageButton" )
		self.Mute:SetSize( 32, 32 )
		self.Mute:Dock( RIGHT )

		self.Ping = self:Add( "DLabel" )
		self.Ping:Dock( RIGHT )
		self.Ping:SetWidth( 50 )
		self.Ping:SetFont( "ScoreboardDefault" )
		self.Ping:SetTextColor( nz.Colours["white"] )
		self.Ping:SetContentAlignment( 5 )

		self.Headshots = self:Add( "DLabel" )
		self.Headshots:Dock( RIGHT )
		self.Headshots:SetWidth( 100 )
		self.Headshots:SetFont( "ScoreboardDefault" )
		self.Headshots:SetTextColor( nz.Colours["secondary"] )
		self.Headshots:SetContentAlignment( 5 )
		self.Headshots:SetText( "0" )

		self.Revives = self:Add( "DLabel" )
		self.Revives:Dock( RIGHT )
		self.Revives:SetWidth( 100 )
		self.Revives:SetFont( "ScoreboardDefault" )
		self.Revives:SetTextColor( nz.Colours["secondary"] )
		self.Revives:SetContentAlignment( 5 )
		self.Revives:SetText( "0" )

		self.Downs = self:Add( "DLabel" )
		self.Downs:Dock( RIGHT )
		self.Downs:SetWidth( 100 )
		self.Downs:SetFont( "ScoreboardDefault" )
		self.Downs:SetTextColor( nz.Colours["secondary"] )
		self.Downs:SetContentAlignment( 5 )

		self.Kills = self:Add( "DLabel" )
		self.Kills:Dock( RIGHT )
		self.Kills:SetWidth( 100 )
		self.Kills:SetFont( "ScoreboardDefault" )
		self.Kills:SetTextColor( nz.Colours["secondary"] )
		self.Kills:SetContentAlignment( 5 )

		self.Score = self:Add( "DLabel" )
		self.Score:Dock( RIGHT )
		self.Score:SetWidth( 100 )
		self.Score:SetFont( "ScoreboardDefault" )
		self.Score:SetTextColor( nz.Colours["secondary"] )
		self.Score:SetContentAlignment( 5 )
		self.Score:SetText( "500" )

		self:Dock( TOP )
		self:DockPadding( 3, 3, 3, 3 )
		self:SetHeight( 32 + 3 * 2 )
		self:DockMargin( 2, 0, 2, 2 )

	end,

	Setup = function( self, pl )

		self.Player = pl

		self.Avatar:SetPlayer( pl )

		self:Think( self )

		--local friend = self.Player:GetFriendStatus()
		--MsgN( pl, " Friend: ", friend )

	end,

	Think = function( self )

		if ( !IsValid( self.Player ) ) then
			self:SetZPos( 9999 ) -- Causes a rebuild
			self:Remove()
			return
		end

		if ( self.PName == nil || self.PName != self.Player:Nick() ) then
			self.PName = self.Player:Nick()
			self.Name:SetText( self.PName )
		end

		if ( self.NumKills == nil || self.NumKills != self.Player:Frags() ) then
			self.NumKills = self.Player:Frags()
			self.Kills:SetText( self.NumKills )
		end

		if ( self.NumDeaths == nil || self.NumDeaths != self.Player:Deaths() ) then
			self.NumDeaths = self.Player:Deaths()
			self.Downs:SetText( self.NumDeaths )
		end

		if ( self.NumPing == nil || self.NumPing != self.Player:Ping() ) then
			self.NumPing = self.Player:Ping()
			self.Ping:SetText( self.NumPing )
		end

		--
		-- Change the icon of the mute button based on state
		--
		if ( self.Muted == nil || self.Muted != self.Player:IsMuted() ) then

			self.Muted = self.Player:IsMuted()
			if ( self.Muted ) then
				self.Mute:SetImage( "icon32/muted.png" )
			else
				self.Mute:SetImage( "icon32/unmuted.png" )
			end

			self.Mute.DoClick = function() self.Player:SetMuted( !self.Muted ) end

		end

		--
		-- Connecting players go at the very bottom
		--
		if ( self.Player:Team() == TEAM_CONNECTING ) then
			self:SetZPos( 2000 + self.Player:EntIndex() )
			return
		end

		--
		-- This is what sorts the list. The panels are docked in the z order,
		-- so if we set the z order according to kills they'll be ordered that way!
		-- Careful though, it's a signed short internally, so needs to range between -32,768k and +32,767
		--
		self:SetZPos( ( self.NumKills * -50 ) + self.NumDeaths + self.Player:EntIndex() )

	end,

	Paint = function( self, w, h )

		if ( !IsValid( self.Player ) ) then
			return
		end

		--
		-- We draw our background a different colour based on the status of the player
		--

		if ( self.Player:Team() == TEAM_CONNECTING ) then
			draw.RoundedBox( 4, 0, 0, w, h, Color( 200, 200, 200, 200 ) )
			return
		end

		if ( !self.Player:Alive() ) then
			draw.RoundedBox( 4, 0, 0, w, h, Color( 230, 200, 200, 255 ) )
			return
		end

		if ( self.Player:IsAdmin() ) then
			draw.RoundedBox( 4, 0, 0, w, h, Color( 230, 255, 230, 255 ) )
			return
		end

		-- background
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )

		-- Starting from the right of the score board
		local bgColour = nz.Display.Colours["Dark Green"]
		bgColour.a = 10
		-- Mute
		local muteWidth = 35 -- self.Mute:GetSize()
		local xRight = w - muteWidth
		draw.RoundedBox( 0, xRight, 0, muteWidth, h, Color( 0, 0, 0, 0 ) )
		-- Ping
		local pingWidth = self.Ping:GetSize()
		xRight = xRight - pingWidth
		draw.RoundedBox( 0, xRight, 0, pingWidth, h, Color( 0, 0, 0, 0 ))

		-- Headshots
		local headshotsWidth = self.Headshots:GetSize()
		xRight = xRight - headshotsWidth
		draw.RoundedBox( 0, xRight, 0, headshotsWidth, h, bgColour)
		-- Revives
		local revivesWidth = self.Revives:GetSize()
		xRight = xRight - revivesWidth
		draw.RoundedBox( 0, xRight, 0, revivesWidth, h, Color( 0, 0, 0, 0 ))
		-- Downs
		local downsWidth = self.Downs:GetSize()
		xRight = xRight - downsWidth
		draw.RoundedBox( 0, xRight, 0, downsWidth, h, bgColour)
		-- Kills
		local killsWidth = self.Kills:GetSize()
		xRight = xRight - killsWidth
		draw.RoundedBox( 0, xRight, 0, killsWidth, h, Color( 0, 0, 0, 0 ))
		-- Score
		local scoreWidth = self.Score:GetSize()
		xRight = xRight - scoreWidth
		draw.RoundedBox( 0, xRight, 0, scoreWidth, h, bgColour)
	end
}

nz.Scoreboards.Play.scoreboardPlayerRowPanel = vgui.RegisterTable(playerRow, "EditablePanel")
