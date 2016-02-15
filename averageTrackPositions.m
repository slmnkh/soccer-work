% function [averageTracks] = averageTrackPositions(startingFrame, numOfFrames, plotAvgPositions,teamNum,videoName)
%% Plot Track Average on Field Model
% cd(['F:\MyStuff\Research\Dataset\Vid1\Results\Mat Files\' videoName])
% load([videoName '_fieldModelGTTracks'])
fieldModelTracks = fieldModelGTTracks;

%%

startingFrame = 1;
numOfFrames = 939;
plotAvgPositions = 1;
teamNum = 2;


averageTracks = [];

maxTeam1TrackNum = 0;
minTeam1TrackNum = 100;
maxTeam2TrackNum = 0;
minTeam2TrackNum = 100;

% startingFrame = 1;
% numOfFrames = size(fieldModelTracks,2);

for frameNum = startingFrame:(startingFrame + numOfFrames - 1)%size(fieldModelTracks,2)
    for trackNum=1:size(fieldModelTracks{frameNum},1)
        trackCenterX = fieldModelTracks{frameNum}(trackNum,1);
        trackCenterY = fieldModelTracks{frameNum}(trackNum,2);

%         if A(2) > 106 && A(2) < 629 && A(1) > 238 && A(1) < 969           
            trackNumber = fieldModelTracks{frameNum}(trackNum,4);

            teamID = fieldModelTracks{frameNum}(trackNum,3);
            
            if isempty(averageTracks) || (trackNumber > size(averageTracks,2)) ||  isempty(averageTracks{trackNumber})
                averageTracks{trackNumber}.Counter = 1;
                averageTracks{trackNumber}.FrameNum(averageTracks{trackNumber}.Counter) = frameNum;
                averageTracks{trackNumber}.X = trackCenterX;
                averageTracks{trackNumber}.Y = trackCenterY;
                averageTracks{trackNumber}.TeamID = teamID;
                averageTracks{trackNumber}.TrackNumber = trackNumber;
%                 averageTracks{trackNumber}.XHistory(averageTracks{trackNumber}.Counter) = trackCenterX;
%                 averageTracks{trackNumber}.YHistory(averageTracks{trackNumber}.Counter) = trackCenterY;   
                averageTracks{trackNumber}.XHistory(frameNum) = trackCenterX;
                averageTracks{trackNumber}.YHistory(frameNum) = trackCenterY;
            else
                averageTracks{trackNumber}.Counter = averageTracks{trackNumber}.Counter + 1;
                averageTracks{trackNumber}.FrameNum(averageTracks{trackNumber}.Counter) = frameNum;
                averageTracks{trackNumber}.X = ((averageTracks{trackNumber}.X)*(averageTracks{trackNumber}.Counter-1) + trackCenterX)/averageTracks{trackNumber}.Counter;
                averageTracks{trackNumber}.Y = ((averageTracks{trackNumber}.Y)*(averageTracks{trackNumber}.Counter-1) + trackCenterY)/averageTracks{trackNumber}.Counter;
                averageTracks{trackNumber}.TeamID = teamID;
                averageTracks{trackNumber}.TrackNumber = trackNumber;
%                 averageTracks{trackNumber}.XHistory(averageTracks{trackNumber}.Counter) = trackCenterX;
%                 averageTracks{trackNumber}.YHistory(averageTracks{trackNumber}.Counter) = trackCenterY;   
                averageTracks{trackNumber}.XHistory(frameNum) = trackCenterX;
                averageTracks{trackNumber}.YHistory(frameNum) = trackCenterY;
            end
%         end
    end
    
    if  max(fieldModelTracks{frameNum}((fieldModelTracks{frameNum}(:,3) == 1),4)) > maxTeam1TrackNum
        maxTeam1TrackNum = max(fieldModelTracks{frameNum}((fieldModelTracks{frameNum}(:,3) == 1),4));
    end
    if  max(fieldModelTracks{frameNum}((fieldModelTracks{frameNum}(:,3) == 3),4)) > maxTeam2TrackNum
        maxTeam2TrackNum = max(fieldModelTracks{frameNum}((fieldModelTracks{frameNum}(:,3) == 3),4));
    end
    
    if  min(fieldModelTracks{frameNum}((fieldModelTracks{frameNum}(:,3) == 1),4)) < minTeam1TrackNum
        minTeam1TrackNum = min(fieldModelTracks{frameNum}((fieldModelTracks{frameNum}(:,3) == 1),4));
    end
    if  min(fieldModelTracks{frameNum}((fieldModelTracks{frameNum}(:,3) == 3),4)) < minTeam2TrackNum
        minTeam2TrackNum = min(fieldModelTracks{frameNum}((fieldModelTracks{frameNum}(:,3) == 3),4));
    end
end

if teamNum == 1
    maxTeamTrackNum = maxTeam1TrackNum;
    minTeamTrackNum = minTeam1TrackNum;
elseif teamNum == 2
    maxTeamTrackNum = maxTeam2TrackNum;
    minTeamTrackNum = minTeam2TrackNum;
end

%% Plot Average Position on Field
%     footballField = imread('C:\Studies\UCF\FootballResearch\Dataset\Vid1\football field.jpg','jpg');

% footballField = imread('C:\Studies\UCF\FootballResearch\Dataset\Vid1\FootballField.jpg','jpg');
footballField = imread('LinesSalman.jpg');

if plotAvgPositions
    figure,imshow(footballField);
    hold on

    for i=minTeamTrackNum:maxTeamTrackNum%size(averageTracks,2)
        if ~isempty(averageTracks{i})
            if averageTracks{i}.TeamID == 1
                plot(averageTracks{i}.X,averageTracks{i}.Y,'s','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',15);
                text(averageTracks{i}.X-8,averageTracks{i}.Y,num2str(averageTracks{i}.TrackNumber),'Color','k','FontWeight','bold');
            elseif averageTracks{i}.TeamID == 3
                plot(averageTracks{i}.X,averageTracks{i}.Y,'s','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',15);
                text(averageTracks{i}.X-8,averageTracks{i}.Y,num2str(averageTracks{i}.TrackNumber),'Color','k','FontWeight','bold');
            end
        end
    end
end

% end