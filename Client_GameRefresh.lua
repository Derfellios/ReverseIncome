function Client_GameRefresh(game)

	if game.Us == nil or (not Mod.PlayerGameData.InitialPopupDisplayed and not (game.Game.TurnNumber > 1 or (game.Game.TurnNumber == 1 and not game.Settings.AutomaticTerritoryDistribution))) then

		UI.Alert("This game includes the Reverse Income mod. If you are in a team of two, your incomes are swapped!")
		local payload = {};
		payload.Message = "InitialPopupDisplayed";
		game.SendGameCustomMessage("Please wait... ", payload, function(reply)end);
	end
end