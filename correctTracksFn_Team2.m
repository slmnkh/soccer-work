function TracksTeam2 = correctTracksFn_Team2(fieldModelGTTracks)

for i = 1:length(fieldModelGTTracks)
    
    temp = fieldModelGTTracks{i};
    temp = temp(temp(:,3) == 1,:);
    tempNew = zeros(11,4);
    for j = 21:20+size(tempNew,1)
        ind = find(temp(:,4) == j,1);
        if ind
            tempNew(j-20,:) = temp(ind,:)-[0 0 0 20];
        end
    end
    TracksTeam2{i} = tempNew;
end