outPath = 'C:\Users\Amir\Desktop\ACM\testMatsClean';
path = 'C:\Users\Amir\Desktop\ACM\testMats';

for i = 1:length(list)
    
    load([path '\' list(i).name]);
    tP = removeDuplicatePoints(temp);
    str = [outPath '\' list(i).name(25:end)];
    save(str,'tP');
    i
    
end
    