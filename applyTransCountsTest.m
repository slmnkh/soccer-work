
path = 'K:\Soccer Transcounts\Vid1Seq2';
folder = path(end-7:end);
% load([path '\Transcounts.txt'])
% transAcc = readTranscounts([path '\Transcounts.txt']);
transAcc = transSegC;
TransPath = [path '\Masks\TestSeg'];
if ~isdir(TransPath)
    mkdir(TransPath);
end
% list = dir([path '\Masks\AlignedMasks\*.bmp']);
list = dir([path '\Masks\' folder '\*.bmp']);


%% compute limits

szY = 352;
szX = 640;

xMin=1; xMax=szX;
yMin=1; yMax=szY;

imTL=[1 1 1];   imTR=[szX 1 1];
imBL=[1 szY 1]; imBR=[szX szY 1];

disp(' ');

% for iFiles=1:length(list)
for iFiles=1:length(transAcc)
%     disp(sprintf('computing limits: %d of %d', iFiles, nFiles ));
    
%     H=(transAcc{iFiles});
    H=inv(transAcc{iFiles});
%     H = eye(3);
    imTLw=H*imTL'; imTRw=H*imTR';
    imBLw=H*imBL'; imBRw=H*imBR';
    
    imTLw=imTLw./imTLw(3); imTRw=imTRw./imTRw(3);
    imBLw=imBLw./imBLw(3); imBRw=imBRw./imBRw(3);

    xMin=min([xMin imTLw(1) imTRw(1) imBLw(1) imBRw(1)]);
    xMax=max([xMax imTLw(1) imTRw(1) imBLw(1) imBRw(1)]);
    yMin=min([yMin imTLw(2) imTRw(2) imBLw(2) imBRw(2)]);
    yMax=max([yMax imTLw(2) imTRw(2) imBLw(2) imBRw(2)]);
%     [xMin xMax yMin yMax]
%     iFiles
%     pause
end
 

%% 


for i = 1:length(list)
    
    I = imread([path '\Masks\' folder '\' list(i).name]);
%     [temp, imMask]=imWarp((I), (transAcc{i}), [yMin xMin yMax xMax]);
    [temp, imMask]=imWarp((I), inv(transAcc{i}), [yMin xMin yMax xMax]);
    imwrite(uint8(temp), [TransPath '\Masks_' list(i).name(1:end-4) '.bmp'], 'bmp'); 
    i
end