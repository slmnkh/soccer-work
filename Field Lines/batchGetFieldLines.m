function batchGetFieldLines(inpath)

% path = 'C:\Users\Amir\Desktop\test\Vid1Seq2\Original';
path = [inpath '\Original'];
outPath = [inpath '\LinesK'];
load Vid1_jerseyColors.mat;
if ~isdir(outPath)
    mkdir(outPath)
end
list = dir([path '\*.bmp']);

for i = 1:length(list)
    
    i
    I = imread([path '\' list(i).name]);
    temp = getFieldLines(I);
%     temp = getFieldLinesSalman(I, jerseyColorPixels);
    imwrite(temp, [outPath '\' sprintf('img_%.06d.bmp',i)],'bmp');
    
end

