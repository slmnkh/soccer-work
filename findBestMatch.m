
scores = [];
path = 'C:\Users\Amir\Desktop\ACM\testMatsClean';
% imPath = 'C:\Users\Amir\Desktop\test\lines';
% imgList = dir([imPath '\*.bmp']);
% list = dir([path '\[cPos1_0880][cPos3_0140]*.mat');
[a,b] = find(I == 1);
testPs = [a b];

for i = 1:length(list)
    tic
    load([path '\' list(i).name]);
    scores(i) = watanabefitness(tP, testPs);
    i
    toc 
end


