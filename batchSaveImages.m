% function 

outPath = 'C:\Users\Amir\Desktop\test\Vid1Seq3\ExtractedImages';
load FieldPts.mat;

for i = 1:size(paramList,1)
    
    params = paramList(i,:);
    tP = wireFrameWatanabeFnFinal(880, 140, params(1), params(2), params(3), FieldPts);
    opI = disPlayWarpedPts(tP);
    imwrite(opI, [outPath '\' sprintf('im_%.04d.bmp',i)],'bmp');
 
end 