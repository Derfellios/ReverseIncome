function Server_AdvanceTurn_End(game, addNewOrder)
	if game.Settings.LocalDeployments then
		return
	end
	Teams  = {}
	TeamPlayers = {}
	for ID, Player in pairs(game.Game.PlayingPlayers) do
		if Player.Team ~= nil then
			if not IsInList(Teams, Player.Team) then
				Teams[#Teams + 1] = Player.Team;
				TeamPlayers[Player.Team] = {ID}
			else
				TeamPlayers[Player.Team][#TeamPlayers[Player.Team] + 1] = ID
			end
		end;
	end;
	
	for _, Team in pairs(TeamPlayers) do
		if #Team == 2 then
			Income1 = game.Game.PlayingPlayers[Team[1]].Income(0, game.ServerGame.LatestTurnStanding, false, false).Total
			Income2 = game.Game.PlayingPlayers[Team[2]].Income(0, game.ServerGame.LatestTurnStanding, false, false).Total
			Difference = Income1 - Income2
			IncomeMod1 = WL.IncomeMod.Create(Team[1], -Difference, '');
			IncomeMod2 = WL.IncomeMod.Create(Team[2], Difference, '');
			addNewOrder(WL.GameOrderEvent.Create(Team[1], game.Game.Players[Team[1]].DisplayName(nil, false) .. ' swapped income with ' .. game.Game.Players[Team[2]].DisplayName(nil, false), {}, {}, nil, {IncomeMod1, IncomeMod2}));
		end
	end
end

function IsInList(List, Item)
    for _,item in pairs(List) do
         if item == Item then
              return true
         end
    end
    return false
end