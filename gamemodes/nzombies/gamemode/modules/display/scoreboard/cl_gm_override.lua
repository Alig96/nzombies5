function GM:ScoreboardShow()

	if ( !IsValid( globalScoreboard ) ) then
		-- lua_run globalScoreboard:Remove()
		globalScoreboard = vgui.CreateFromTable( nz.Display.Vgui.SBPanel )
	end

	if ( IsValid( globalScoreboard ) ) then
		globalScoreboard:Show()
		globalScoreboard:MakePopup()
		globalScoreboard:SetKeyboardInputEnabled( false )
	end

end

function GM:ScoreboardHide()

	if ( IsValid( globalScoreboard ) ) then
		globalScoreboard:Hide()
	end

end

function GM:HUDDrawScoreBoard()
end
