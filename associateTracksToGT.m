playerId = [];
for i = 1:size(assocMat,2)
    if find(assocMat(:,i)==1)
    playerId(i) = find(assocMat(:,i)==1);
    end
end
playerId(playerId == 0) = Inf;
team1id = find(playerId < 15);
team1 = [team1id; playerId(team1id)]