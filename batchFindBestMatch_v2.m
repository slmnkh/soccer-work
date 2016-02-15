function batchFindBestMatch_v2(imgPath, list)
% imgPath = 'C:\Users\Amir\Desktop\test\lines';
imgList = dir([imgPath '\LinesSalman_newThinParam\*.bmp']);
outPath = [imgPath '\extractedLines_newParams'];
if ~isdir(outPath)
    mkdir(outPath)
end
load FieldPts.mat;
paramList = [];
I = imread([imgPath '\LinesSalman_newThinParam\' imgList(1).name]);
param = findBestMatchInRange_v2(list, I, [300 190 1800]);
paramList(1,:) = param;

for i = 2:length(imgList)
    tic
    
    i
    I = imread([imgPath '\LinesSalman_newThinParam\' imgList(i).name]);
    param = findBestMatchInRange_v2(list, I, paramList(i-1,:));
    paramList(i,:) = param;
    
    tP = wireFrameWatanabeFnFinal(880, 140, param(1), param(2), param(3), FieldPts);
    opI = disPlayWarpedPts(tP);
    imwrite(opI, [outPath '\' sprintf('im_%.04d.bmp',i)],'bmp');
     
    save seq02Newparams paramList;
    
    toc
end

end
