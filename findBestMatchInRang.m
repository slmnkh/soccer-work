%% search in bounds only

ind = [];
cCen1Mean = ;
cCen2Mean = ;
fMean = ;
cCen1Range = ;
cCen2Range = ;
fRange = ;
for i = 1:length(list)
    
    cCen1 = str2num(list(i).name(8:11));
    cCen2 = str2num(list(i).name(20:23));
    f = str2num(list(i).name(31:34));
    
    cCen1D = abs(cCen1-cCen1Mean);
    cCen2D = abs(cCen2-cCen2Mean);
    fD = abs(f-fMean);
    
    if cCen1D < cCen1Range & cCen2D < cCen2Range & fD < fRange
        ind = [ind i];
    end
        
end

