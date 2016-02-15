%% search in bounds only

function params = findBestMatchInRange_v2(list, I, params)


ind = [];
% cCen1Mean = 300;
% cCen2Mean = 190;
% fMean = 1800;
cCen1Mean = params(1);
cCen2Mean = params(2);
fMean = params(3);

cCen1Range = 25;
cCen2Range = 25;
fRange = 65;

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
% I = imresize(I,0.5);
% I = bwmorph(I, 'thin');
% I = bwmorph(I, 'thin');
[a,b] = find(I == 1);
a = round(a./2);
b = round(b./2);
ind = sub2ind(round(size(I)/2), a, b);
% ind = sub2ind(size(opI), tP(2,:), tP(1,:));
ind = unique(ind);
temp = zeros(size(I)./2);
temp(ind) = 255;
[a,b] = find(I == 255);
testPs = [a b];

for i = 1:length(ind)
%     tic
    load([path '\' list(ind(i)).name]);
    tP = round(tP/2);
    scores(i) = watanabefitness(tP, testPs);
    i;
%     toc 
end

[ta tb] = max(scores);

cCen1 = str2num(list(ind(tb)).name(8:11));
cCen2 = str2num(list(ind(tb)).name(20:23));
f = str2num(list(ind(tb)).name(31:34));

params = [cCen1 cCen2 f];