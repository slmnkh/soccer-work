outPath = 'C:\Users\Amir\Desktop\test\autoLines';

for i = 1:size(paramList)
    
    close all
    
    params = paramList(i,:);
    
    load([path '\' sprintf('[cCen1_%.04d][cCen2_%.04d][fInd_%.04d].mat',params(1),params(2),params(3))]);
    
    tP = wireFrameWatanabeFnFinal(880,140,params(1),params(2),params(3));
    
    disPlayWarpedPts(tP);
    
    saveas(gcf,[outPath '\' sprintf('%04d.png',i)]);
    
end
        