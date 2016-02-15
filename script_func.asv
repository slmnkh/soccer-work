
function script_func(mypath);

close all;
% load('C:\Users\Student\Desktop\IARPaSeedlingDatasets\footBallDataSet\dsp_reg_dataset-game_1\dsp_reg_dataset\game_1\images\play_02_copy_90_220\trans.mat')
% clear;
path = mypath;
% path='C:\Users\UCF_VISION\Desktop\CLIFF06_sequence_log\Cam0\Seq2b';
inFmt='bmp'; outFmt='bmp';

imPath=[path '\Original'];
alignedPath=[path '\Aligned'];
maskPath=[path '\AlignedMasks'];

files=dir([imPath '\*.' inFmt]);
nFiles=size(files,1);
referenceFrame=1;floor(nFiles/2);

if ~exist(alignedPath, 'dir')
    mkdir(alignedPath);
end
if ~exist(maskPath, 'dir')
    mkdir(maskPath);
end
startTime=clock;

%% alignment
im1=double(rgb2gray(imread([imPath '\' files(1).name])));
%im1=double(rgb2gray(imread([imPath '\' files(1).name])));
[F1,D1]=im2features(im1);
[szY szX szZ]=size(im1);

trans{1}=eye(3); transAcc{1}=eye(3);
for iFiles=2:nFiles
    disp(sprintf('\n*** processing image: %d of %d', iFiles, nFiles ));
    
    im2=double(rgb2gray(imread([imPath '\' files(iFiles).name])));
    %im2=double(rgb2gray(imread([imPath '\' files(iFiles).name])));
    tic; [F2,D2]=im2features(im2);
    disp(sprintf('[T] im2features: %2.4f sec', toc));
    
    tic; [H,im1XY,im2XY,inliers]=imAlign(F1,D1,F2,D2);
    disp(sprintf('[D] ransac inliers: %d / %d', size(inliers,2), size(im1XY,2)));
    disp(sprintf('[T] alignment: %2.4f sec', toc));
    
    trans{iFiles}=H; transAcc{iFiles}=transAcc{iFiles-1}*H;                % x1=H12*x2; x2=H23*x3 => x1=H12*H23*x3
    F1=F2; D1=D2;    
end

transAccM{1}=eye(3);
for iFiles=1: nFiles
    transAccM{iFiles}=inv(transAcc{referenceFrame})*transAcc{iFiles};
end
transAcc=transAccM;
save([path '\trans.mat'], 'trans', 'transAcc');

%% limits
xMin=1; xMax=szX;
yMin=1; yMax=szY;

imTL=[1 1 1];   imTR=[szX 1 1];
imBL=[1 szY 1]; imBR=[szX szY 1];

disp(' ');
for iFiles=1:nFiles
    disp(sprintf('computing limits: %d of %d', iFiles, nFiles ));
    
    H=transAcc{iFiles};
    imTLw=H*imTL'; imTRw=H*imTR';
    imBLw=H*imBL'; imBRw=H*imBR';
    
    imTLw=imTLw./imTLw(3); imTRw=imTRw./imTRw(3);
    imBLw=imBLw./imBLw(3); imBRw=imBRw./imBRw(3);

    xMin=min([xMin imTLw(1) imTRw(1) imBLw(1) imBRw(1)]);
    xMax=max([xMax imTLw(1) imTRw(1) imBLw(1) imBRw(1)]);
    yMin=min([yMin imTLw(2) imTRw(2) imBLw(2) imBRw(2)]);
    yMax=max([yMax imTLw(2) imTRw(2) imBLw(2) imBRw(2)]);
end

%% warping
disp(' ');
for iFiles=1:nFiles
    disp(sprintf('warping image: %d of %d', iFiles, nFiles ));
    im=(imread([imPath '\' files(iFiles).name]));
    %im=double(rgb2gray(imread([imPath '\' files(iFiles).name])));
    
    [imWarped, imMask]=imWarp((im), transAcc{iFiles}, [yMin xMin yMax xMax]);
    imwrite(uint8(imWarped), [alignedPath '\Aligned-' files(iFiles).name(1:end-4) '.' outFmt], outFmt); 
    imwrite(uint8(imMask*255), [maskPath '\AlignedMask-' files(iFiles).name(1:end-4) '.' outFmt], outFmt); 
end

%%
% [d h m s]=sec2dhms(etime(clock,startTime));
% disp(sprintf('\nTotal Time: %d days, %d hrs, %d min, %2.4f sec', d,h,m,s));