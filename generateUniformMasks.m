path = 'K:\Soccer Transcounts\Vid1Seq7\Masks';
if ~isdir([path '\AlignedMasks']);
    mkdir([path '\AlignedMasks']);
end
inPath = 'C:\Football Videos\Vid1\Segmented Image Sequence\Vid1Seq7';
list = dir([inPath '\*.bmp']);
% I = imread([path '\' list(1).name]);
szx = 352;
szy = 640;

for i = 1:length(list)
    
    temp = ones(szx,szy).*255;
    imwrite(temp,[path '\AlignedMasks\' sprintf('mask_%.06d.bmp',str2num(list(i).name(end-9:end-4)))]);
    i
    
end