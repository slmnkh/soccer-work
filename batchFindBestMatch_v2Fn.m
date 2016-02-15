function batchFindBestMatch_v2Fn(imgPath, list, VarParams)
% imgPath = 'C:\Users\Amir\Desktop\test\lines';
imgList = dir([imgPath '\LinesSalman_newThinParam\*.bmp']);
outPath = [imgPath '\extractedLines_newParams'];
if ~isdir(outPath)
    mkdir(outPath)
end
load FieldPts.mat;
load paramMat.mat
paramList = [];
I = imread([imgPath '\LinesSalman_newThinParam\' imgList(1).name]);
% param = findBestMatchInRange_v2(list, I, [VarParams(1), VarParams(2), VarParams(3)]);
param = findBestMatchInRange_v3(list, I, [VarParams(1), VarParams(2), VarParams(3)], paramMat);
paramList(1,:) = param;

tP = wireFrameWatanabeFnFinal(880, 140, param(1), param(2), param(3), FieldPts);
opI = disPlayWarpedPts(tP);
imwrite(opI, [outPath '\' sprintf('im_%.04d.bmp',1)],'bmp');

for i = 2:length(imgList)
    tic
    
    i
    I = imread([imgPath '\LinesSalman_newThinParam\' imgList(i).name]);
%     param = findBestMatchInRange_v2(list, I, paramList(i-1,:));
    param = findBestMatchInRange_v3(list, I, paramList(i-1,:), paramMat);
    paramList(i,:) = param;
    
    tP = wireFrameWatanabeFnFinal(880, 140, param(1), param(2), param(3), FieldPts);
    opI = disPlayWarpedPts(tP);
    imwrite(opI, [outPath '\' sprintf('im_%.04d.bmp',i)],'bmp');
     
%     save seq02Newparams paramList;
    save([imgPath '\paramList.mat'],'paramList');
    
    toc
end
save([imgPath '\paramListFinal.mat'],'paramList');
end
