function [] = getGTTracksOnFieldModel()

videoName = 'Vid1Seq3';
cd(['F:\MyStuff\Research\Dataset\Vid1\Results\Mat Files\' videoName]);
load([videoName '_alignedTrans']);
% load('Vid1Seq2_myTracks.mat');
load([videoName '_homography.mat']);
load('trackList_team1');
load('trackList_team2');
H = footballField.H;

%% Load Tracks
transPath = ['F:\MyStuff\Research\Dataset\Vid1\Segmented Image Sequence\' videoName '\'];
imgPath = ['F:\MyStuff\Research\Dataset\Vid1\Segmented Image Sequence\' videoName '\'];
alignedImgPath = ['F:\MyStuff\Research\Dataset\Vid1\Segmented Image Sequence\' videoName '\Aligned'];
maskPath = ['F:\MyStuff\Research\Dataset\Vid1\Segmented Image Sequence\' videoName '\Mask\'];
matFilePath = ['F:\MyStuff\Research\Dataset\Vid1\Results\Mat Files\' videoName '\'];
codePath = 'C:\Studies\UCF\FootballResearch\Mac Code\OpticalFlow';

cd(imgPath);
imgFileList = dir('*.bmp');
cd(alignedImgPath);
alignedImgFileList = dir('GAligned-*');
cd(maskPath);
maskFileList = dir('GMask-*');


%% Make myTracks from trackList_team1 and trackList_team2 (for team2
%% teamNumber = 2 and teamID = 3)
% trackList = trackList_team2;
% teamNumber = 2;
% teamID = 3;

trackList = trackList_team1;
teamNumber = 1;
teamID = 1;

for frameNum=1:size(alignedTrans,2)
   trackIndices = find(trackList{frameNum}(:,1)~=0);
   for i = 1:length(trackIndices)
       myTracks{teamNumber,frameNum}(i,1) = trackList{frameNum}(trackIndices(i),5);
       myTracks{teamNumber,frameNum}(i,2) = trackList{frameNum}(trackIndices(i),6);
       myTracks{teamNumber,frameNum}(i,3) = trackList{frameNum}(trackIndices(i),7) - trackList{frameNum}(trackIndices(i),5);
       myTracks{teamNumber,frameNum}(i,4) = trackList{frameNum}(trackIndices(i),8) - trackList{frameNum}(trackIndices(i),6);
       myTracks{teamNumber,frameNum}(i,5) = teamID;
       myTracks{teamNumber,frameNum}(i,9) = trackList{frameNum}(trackIndices(i),1);
   end
end

%% Get Mask and find limits
cd(maskPath);
mask = imread(maskFileList(1).name);

[y,x] = find(mask==255);

xMin = min(x);
xMax = max(x);
yMin = min(y);
yMax = max(y);

cd(imgPath);
orgImg = imread(imgFileList(1).name);

fieldModelTracks = [];

for frameNum = 1:size(alignedTrans,2)

    tracks = [myTracks{1,frameNum};myTracks{2,frameNum}];
    tform = maketform('projective',inv(alignedTrans{frameNum}));
    
    trackCount = 1;
    
%     footballField = imread('C:\Studies\UCF\FootballResearch\Dataset\Vid1\football field.jpg','jpg');
%     imshow(footballField);
%     hold on
            
    for trackNum=1:size(tracks,1)
        trackCenterX = tracks(trackNum,1) + tracks(trackNum,3)/2;
        trackCenterY = tracks(trackNum,2) + tracks(trackNum,4)/2;

        if trackCenterX < size(orgImg,2) && trackCenterY < size(orgImg,1) && trackCenterX > 1 && trackCenterY > 1
            % Using COCOA aligned & manually computed homographies
%             [xT,yT] = tformfwd(tform,trackCenterX,trackCenterY);
% %             A = transformPoints([xT+xMin,yT+yMin],H');
%             A = transformPoints([xT,yT],H');

            %Using Camera Calibration
            A = transformPoints([trackCenterX,trackCenterY],frameH{frameNum}');
            
            %% Plot Tracks on the Original Image
%             cd(imgPath)
%             imshow(imread(imgFileList(frameNum).name));
%             hold on
%             plot(trackCenterX,trackCenterY,'s','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',15);

            %% Plot Tracks on the Aligned Image
%             cd(alignedImgPath)
%             imshow(imread(alignedImgFileList(frameNum).name));
%             hold on
%             plot(xT+xMin,yT+yMin,'s','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',5);
%             
%             if A(2) > 106 && A(2) < 629 && A(1) > 238 && A(1) < 969
                    fieldModelTracks{frameNum}(trackCount,1) = A(1);
                    fieldModelTracks{frameNum}(trackCount,2) = A(2);
                    fieldModelTracks{frameNum}(trackCount,3) = tracks(trackNum,5);  %Team ID
                    fieldModelTracks{frameNum}(trackCount,4) = tracks(trackNum,9);  %Track ID
                    trackCount = trackCount + 1;   
%             end
            
            %% Plot Tracks on the Field Model
%             plot(fieldModelTracks{frameNum}(trackNum,1),fieldModelTracks{frameNum}(trackNum,2),'s','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',15);
        end
    end
%     pause
end


%% Plot Tracks on the Field Model
% footballField = imread('C:\Studies\UCF\FootballResearch\Dataset\Vid1\football field.jpg','jpg');
% footballField = imread('C:\Studies\UCF\FootballResearch\Dataset\Vid1\FootballField.jpg','jpg');
footballField = imread('C:\Studies\UCF\FootballResearch\Dataset\Vid1\FootballField2.jpg','jpg');
imshow(footballField);
hold on

for frameNum=1:size(fieldModelTracks,2)
    disp(frameNum)
    clf
    imshow(footballField)
    hold on
    for i = 1:size(fieldModelTracks{frameNum},1)
        if fieldModelTracks{frameNum}(i,3) == 1
            plot(fieldModelTracks{frameNum}(i,1),fieldModelTracks{frameNum}(i,2),'s','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',15);
            text(fieldModelTracks{frameNum}(i,1)-8,fieldModelTracks{frameNum}(i,2),num2str(fieldModelTracks{frameNum}(i,4)),'Color','k','FontWeight','bold');
        elseif fieldModelTracks{frameNum}(i,3) == 3
            plot(fieldModelTracks{frameNum}(i,1),fieldModelTracks{frameNum}(i,2),'s','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',15);
            text(fieldModelTracks{frameNum}(i,1)-8,fieldModelTracks{frameNum}(i,2),num2str(fieldModelTracks{frameNum}(i,4)),'Color','k','FontWeight','bold');
        end
    end
    pause
end

%% Save the Field Model Tracks
cd(matFilePath);
fieldModelGTTracks = fieldModelTracks;
% saveFile = sprintf([videoName '_fieldModelGTTracks.mat']);
saveFile = sprintf([videoName '_fieldModelGTTracksfromCP.mat']);
save(saveFile,'fieldModelGTTracks');

end