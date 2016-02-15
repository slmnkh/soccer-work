function TracksTeam1 = correctTracksFnKT(fieldModelGTTracks)

for i = 1:length(fieldModelGTTracks)
    
    temp = fieldModelGTTracks{i};
    temp = temp(temp(:,3) == 3,:);
    tempNew = zeros(11,4);
    for j = 1:size(temp,1)
        ind = temp(j,end);
        tempNew(ind,:) = temp(j,:);
    end
    TracksTeam1{i} = tempNew;
end