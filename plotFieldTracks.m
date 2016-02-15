path = 'K:\Soccer Transcounts\Vid1Seq7';
I = imread('footballField.jpg');
load([path '\' path(end-7:end) '_fieldModelGTTracks.mat'])
outPath = [path '\Tracks'];
if ~isdir(outPath)
    mkdir(outPath);
end
for i = 1:length(fieldModelGTTracks)
    
    close all;
    figure; imshow(I); hold on
    temp = fieldModelGTTracks{i};
    team1 = temp(temp(:,3)==1,:);
    team2 = temp(temp(:,3)==3,:);
    plot(team1(:,1),team1(:,2),'r.','MarkerSize',20);
    plot(team2(:,1),team2(:,2),'b.','MarkerSize',20);
    saveas(gcf,[outPath '\tracks_'  sprintf('%06d.jpg',i)]);
    
end