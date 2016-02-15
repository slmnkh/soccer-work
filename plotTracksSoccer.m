load('\\visionnas2.cs.ucf.edu\share\graduate_students\Salman_Khokhar\Old_projects\Soccer\code_from_khurram\Code\Code_Salman\MatlabCodes\tracks\Vid1Seq7_fieldModelTracks.mat')
TT1 = correctTracksFnKT(fieldModelTracks);
I = imread('LinesSalman.jpg');
path = '\\visionnas2.cs.ucf.edu\share\graduate_students\Salman_Khokhar\Old_projects\Soccer\code_from_khurram\Code\Code_Salman\temp';
if ~isdir(path)
    mkdir(path);
end
load seq7GTT1
TracksTeamGT = GTT1;
TracksTeam1 = TT1;
for i = 1:length(TracksTeam1)
    
    close
    figure; imshow(I); hold on;
    temp = TracksTeam1{i};
    tempGT = TracksTeamGT{i};
    temp(temp(:,3)==0,:) = [];
    tempGT(tempGT(:,3)==0,:) = [];
    for j = 1:size(temp,1)
        plot(temp(j,1),temp(j,2),'r.');
        text(temp(j,1),temp(j,2),num2str(temp(j,4)),'Color','y');
    end
    for j = 1:size(tempGT,1)
        plot(tempGT(j,1),tempGT(j,2),'b.');
        text(tempGT(j,1),tempGT(j,2),num2str(tempGT(j,4)),'Color','g');
    end
    %     pause(0.1)
    saveas(gcf,[path '\img_' sprintf('%04d.png',i)]);
    j = 0;
    
end