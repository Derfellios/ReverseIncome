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
		else
			if not IsInList(Teams, 0) then
				TeamPlayers[0] = {ID}
			else
				TeamPlayers[0][#TeamPlayers[Player.Team] + 1] = ID
			end
		end;
	end;
	
	for _, Team in pairs(TeamPlayers) do
		if #Team == 2 then
			Income1 = game.Game.PlayingPlayers[Team[1]].Income(0, game.ServerGame.LatestTurnStanding, false, false).Total
			Income2 = game.Game.PlayingPlayers[Team[2]].Income(0, game.ServerGame.LatestTurnStanding, false, false).Total
			IncomeMod11 = WL.IncomeMod.Create(Team[1], -Income1, 'You lose your own income');
			IncomeMod22 = WL.IncomeMod.Create(Team[2], -Income2, 'You lose your own income');
			IncomeMod21 = WL.IncomeMod.Create(Team[1], Income2, 'But... you get ' .. game.Game.Players[Team[2]].DisplayName(nil, false) .."'s income in return!");
			IncomeMod12 = WL.IncomeMod.Create(Team[2], Income1, 'But... you get ' .. game.Game.Players[Team[1]].DisplayName(nil, false) .."'s income in return!");
			
			addNewOrder(WL.GameOrderEvent.Create(Team[1], game.Game.Players[Team[1]].DisplayName(nil, false) .. ' swapped income with ' .. game.Game.Players[Team[2]].DisplayName(nil, false), {}, {}, nil, {IncomeMod11, IncomeMod22, IncomeMod21, IncomeMod12}));
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