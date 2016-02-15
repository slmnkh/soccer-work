
path = 'K:\Soccer Transcounts\Vid1Seq6';
% load([path '\Transcounts.txt'])
load([path '\' path(end-7:end) '_homography.mat']);
transAcc = footballField.H;
TransPath = [path '\Masks\FieldHomo'];
if ~isdir(TransPath)
    mkdir(TransPath);
end
% list = dir([path '\Masks\AlignedMasks\*.bmp']);
list = dir([path '\Masks\Trans\*.bmp']);


%% compute limits

szY = 352;
szX = 640;

xMin = 1;
yMin = 1;
xMax = 1024;
yMax = 647;

%% 


for i = 1:length(list)
    
    I = imread([path '\Masks\Trans\' list(i).name]);
    [temp, imMask]=imWarp((I), (transAcc), [yMin xMin yMax xMax]);
    imwrite(uint8(temp), [TransPath '\Masks_' list(i).name(1:end-4) '.bmp'], 'bmp'); 
    i
end