%% search in bounds only

function params = findBestMatchInRange(frame, list, I)


ind = [];
cCen1Mean = 300;
cCen2Mean = 190;
fMean = 1800;
cCen1Range = 50;
cCen2Range = 50;
fRange = 100;

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
    
    i;
        
end



%%%%

scores = [];
path = 'C:\Users\Amir\Desktop\ACM\testMatsClean';
% imPath = 'C:\Users\Amir\Desktop\test\lines';
% imgList = dir([imPath '\*.bmp']);
% list = dir([path '\[cPos1_0880][cPos3_0140]*.mat');
[a,b] = find(I == 1);
testPs = [a b];

for i = 1:length(ind)
    tic
    load([path '\' list(ind(i)).name]);
    scores(i) = watanabefitness(tP, testPs);
    i;
    toc 
end

[ta tb] = max(scores);

cCen1 = str2num(list(ind(tb)).name(8:11));
cCen2 = str2num(list(ind(tb)).name(20:23));
f = str2num(list(ind(tb)).name(31:34));

params = [cCen1 cCen2 f];