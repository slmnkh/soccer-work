function TracksTeam1 = correctTracksFnKT_Team2(fieldModelGTTracks)
imageWidth = 820;
imageHeight = 544;
for i = 1:length(fieldModelGTTracks)
    
    temp = fieldModelGTTracks{i};
    temp = temp(temp(:,3) == 1,:);
    tempNew = zeros(11,4);
    for j = 1:size(temp,1)
        ind = temp(j,end);
        tempNew(ind,:) = temp(j,:);
    end
    tempNew(:,1) = imageWidth - tempNew(:,1);
    tempNew(:,2) = imageHeight - tempNew(:,2);
    TracksTeam1{i} = tempNew;
end