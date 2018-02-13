function GM:ScoreboardShow()
	if !IsValid(nz.Scoreboards.playScoreboard) then
		nz.Scoreboards.playScoreboard = vgui.CreateFromTable(nz.Scoreboards.Play.scoreboardPanel)
		nz.Scoreboards.playScoreboard:SetVisible(false)
	end

	if IsValid(nz.Scoreboards.playScoreboard) and nz.Mode:isPlay() then
		nz.Scoreboards.playScoreboard:Show()
		nz.Scoreboards.playScoreboard:MakePopup()
		nz.Scoreboards.playScoreboard:SetKeyboardInputEnabled(false)
	end

end

function GM:ScoreboardHide()
	if IsValid(nz.Scoreboards.playScoreboard) then
		nz.Scoreboards.playScoreboard:Hide()
	end
end

function GM:HUDDrawScoreBoard()
end
