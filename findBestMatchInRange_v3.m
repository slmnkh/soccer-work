%% search in bounds only

function params = findBestMatchInRange_v3(list, I, params, paramMat)


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


%%

vect1 = abs(paramMat(:,1) - cCen1Mean) < cCen1Range;
vect2 = abs(paramMat(:,2) - cCen2Mean) < cCen2Range;
vect3 = abs(paramMat(:,3) - fMean) < fRange;
vect = vect1.*vect2.*vect3;
ind = find(vect == 1);

%%



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
indT = sub2ind(round(size(I)/2), a, b);
% ind = sub2ind(size(opI), tP(2,:), tP(1,:));
indT = unique(indT);
temp = zeros(size(I)./2);
temp(indT) = 255;
[a,b] = find(temp == 255);
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