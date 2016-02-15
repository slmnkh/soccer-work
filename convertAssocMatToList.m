

for i = 1:size(assocMat,2)
    if find(assocMat(:,i)==1)
        ind(i) = find(assocMat(:,i)==1);
    end
end

ind(ind==0) = Inf;
team1ind = find(ind < 12);
team2ind = find(ind > 20);
av1t = [team1ind; ind(team1ind)];
av2t = [team2ind; ind(team2ind)];


av1 = correctOrder(av1t);
av2 = correctOrder(av2t);


