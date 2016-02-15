path = 'C:\Users\Amir\Desktop\test\Vid1Seq3';

load([path '\paramListFinal.mat']);
load FieldPts.mat;
outPath = [path '\watanabeMasks'];

if ~isdir(outPath)
    mkdir(outPath);
end

frameH = {};
params = paramList;
for i = 1:size(params,1)
    
    pc = params(i,:);
    [H, opI] = getFieldHomo(pc);
    imwrite(opI, [outPath '\' sprintf('img_%.06d.bmp',i)],'bmp');
    frameH{i} = H;
    
end

save([path '\frameH.mat'],'frameH');