% function 
imgPath = 'C:\Users\Amir\Desktop\test\Vid1Seq4\Lines';
imgList = dir([imgPath '\*.bmp']);

paramList = [];
I = imread([imgPath '\' imgList(1).name]);
param = findBestMatchInRange_v2(i, list, I, [360 400 1700]);
paramList(1,:) = param;

for i = 2:length(imgList)
    tic
    
    i
    I = imread([imgPath '\' imgList(i).name]);
    param = findBestMatchInRange_v2(i, list, I, paramList(i-1,:));
    paramList(i,:) = param;
    
    save Seq04params paramList;
    
    toc
end
