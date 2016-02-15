function [distMat, munMat, meanDist, indMat, optScale] = computeCostScale(F1, M)

F1ind = F1(:,end)~=0;
Mind = M(:,end)~=0;

F1mean = mean(F1(F1ind,1:2),1);
Mmean = mean(M(Mind,:),1);

% F1(:,1:2) = F1(:,1:2)-repmat(F1mean,10,1);
% M = M - repmat(Mmean,10,1);

indMat = repmat(F1ind,1,10).*repmat(Mind',10,1);

% distMat = ipdm(F1(:,1:2),M);
% distMat = distMat.*indMat;
% distMat(distMat == 0) = Inf;

scales = [0.5:0.1:1.3];

distCostScales = {};
munMatScales = {};
costsTemp = [];

for i = 1:length(scales)
    
    [tempa, tempb] = computeCost_v2(F1, round(M.*scales(i)));
    distCostScales{i} = tempa;
    munMatScales{i} = tempb;
    costsTemp(i) = sum(sum(tempa.*tempb));
    
end

[a,b] = min(costsTemp);

munMat = munMatScales{b};
distMat = distCostScales{b};
    
% [munMat,~] = munkresMinMat(distMat);

meanDist = sqrt(sum(F1mean-Mmean).^2);