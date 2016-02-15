TracksTeam1 = {};
%fieldModelGTTracks = fieldModelTracks; % comment this line when using actual GT tracks
for i = 1:length(fieldModelGTTracks)
    
    temp = fieldModelGTTracks{i};
    temp = temp(temp(:,3) == 3,:);
    tempNew = zeros(11,4);
    for j = 1:size(tempNew,1)
        ind = find(temp(:,4) == j);
        if ind
            tempNew(j,:) = temp(ind,:);
        end
    end
    TracksTeam1{i} = tempNew;
end