local nzPlayerSpawnerTool = {}

function nzPlayerSpawnerTool:Init()
  self.toolTitle = vgui.Create( "DLabel", self )
  self.toolTitle:SetPos( 10, 10 )
  self.toolTitle:SetText( "Player Spawner Tool" )
  self.toolTitle:SetFont("DermaLarge")
  self.toolTitle:SizeToContents()
  self.toolTitle:SetTextColor(Color(25, 25, 25, 255))

  self.toolDescription = vgui.Create( "DLabel", self )
  self.toolDescription:SetPos( 10, 50 )
  self.toolDescription:SetText( "Left Click: Add Player Spawner.\nRight Click: Remove Player Spawner." )
  self.toolDescription:SetFont("DermaDefault")
  self.toolDescription:SizeToContents()
  self.toolDescription:SetTextColor(Color(25, 25, 25, 255))
end

vgui.Register("nz.PlayerSpawnerTool", nzPlayerSpawnerTool)
