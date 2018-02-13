local headerRow = {
	Init = function( self )
		self.Name = self:Add( "DLabel" )
		self.Name:Dock( FILL )
		self.Name:SetFont( "ScoreboardDefault" )
		self.Name:SetTextColor( nz.Colours["white"] )
		self.Name:DockMargin( 8, 0, 0, 0 )
		self.Name:SetText("Untitled Mapping Config")

		self.Mute = self:Add( "DImage" )
		self.Mute:SetSize( 32, 32 )
		self.Mute:Dock( RIGHT )
		self.Mute:SetImage( "icon32/unmuted.png" )

		self.Ping = self:Add( "DLabel" )
		self.Ping:Dock( RIGHT )
		self.Ping:SetWidth( 50 )
		self.Ping:SetFont( "ScoreboardDefault" )
		self.Ping:SetTextColor( nz.Colours["grey"] )
		self.Ping:SetContentAlignment( 5 )
		self.Ping:SetText("")

		self.Headshots = self:Add( "DLabel" )
		self.Headshots:Dock( RIGHT )
		self.Headshots:SetWidth( 100 )
		self.Headshots:SetFont( "ScoreboardDefault" )
		self.Headshots:SetTextColor( nz.Colours["grey"] )
		self.Headshots:SetContentAlignment( 5 )
		self.Headshots:SetText("Headshots")

		self.Revives = self:Add( "DLabel" )
		self.Revives:Dock( RIGHT )
		self.Revives:SetWidth( 100 )
		self.Revives:SetFont( "ScoreboardDefault" )
		self.Revives:SetTextColor( nz.Colours["grey"] )
		self.Revives:SetContentAlignment( 5 )
		self.Revives:SetText("Revives")

		self.Downs = self:Add( "DLabel" )
		self.Downs:Dock( RIGHT )
		self.Downs:SetWidth( 100 )
		self.Downs:SetFont( "ScoreboardDefault" )
		self.Downs:SetTextColor( nz.Colours["grey"] )
		self.Downs:SetContentAlignment( 5 )
		self.Downs:SetText("Downs")

		self.Kills = self:Add( "DLabel" )
		self.Kills:Dock( RIGHT )
		self.Kills:SetWidth( 100 )
		self.Kills:SetFont( "ScoreboardDefault" )
		self.Kills:SetTextColor( nz.Colours["grey"] )
		self.Kills:SetContentAlignment( 5 )
		self.Kills:SetText("Kills")

		self.Score = self:Add( "DLabel" )
		self.Score:Dock( RIGHT )
		self.Score:SetWidth( 100 )
		self.Score:SetFont( "ScoreboardDefault" )
		self.Score:SetTextColor( nz.Colours["grey"] )
		self.Score:SetContentAlignment( 5 )
		self.Score:SetText("Score")

		self:Dock( TOP )
		self:DockPadding( 3, 3, 3, 3 )
		self:SetHeight( 32 + 3 * 2 )
		self:DockMargin( 2, 0, 2, 2 )

		-- Always at the top
		self:SetZPos( -32767 )

	end,

	Paint = function( self, w, h )
		-- background
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
	end
}

nz.Scoreboards.Play.scoreboardHeaderRowPanel = vgui.RegisterTable(headerRow, "EditablePanel")
