local scoreboardPanel = {
	Init = function( self )
		self.Header = self:Add( "Panel" )
		self.Header:Dock( TOP )
		self.Header:SetHeight( 100 )

		self.Name = self.Header:Add( "DLabel" )
		self.Name:SetFont( "ScoreboardDefaultTitle" )
		self.Name:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Name:Dock( TOP )
		self.Name:SetHeight( 40 )
		self.Name:SetContentAlignment( 5 )
		self.Name:SetExpensiveShadow( 2, Color( 0, 0, 0, 200 ) )

		self.Scores = self:Add( "DScrollPanel" )
		self.Scores:Dock( FILL )

		-- Add the heading heading row
		self.HeaderRow = vgui.CreateFromTable( nz.Display.Vgui.SBHeaderRow )
		self.Scores:AddItem( self.HeaderRow )
	end,

	PerformLayout = function( self )
		local w, h = ScrW() / 2, ScrH() / 2

		self:SetSize( w, h )
		self:SetPos( (ScrW() / 2) - (w / 2), (ScrH() / 2) - (h / 2)  )
	end,

	Paint = function( self, w, h )

		-- draw.RoundedBox( 4, 0, 0, w, h, Color(20, 20, 20, 200) )

	end,

	Think = function( self, w, h )

		self.Name:SetText( GetHostName() )

		--
		-- Loop through each player, and if one doesn't have a score entry - create it.
		--
		local plyrs = player.GetAll()
		for id, pl in pairs( plyrs ) do

			if ( IsValid( pl.ScoreEntry ) ) then continue end

			pl.ScoreEntry = vgui.CreateFromTable( nz.Display.Vgui.SBPlayerRow, pl.ScoreEntry )
			pl.ScoreEntry:Setup( pl )

			self.Scores:AddItem( pl.ScoreEntry )

		end

	end
}

nz.Display.Vgui.SBPanel = vgui.RegisterTable( scoreboardPanel, "EditablePanel" )
