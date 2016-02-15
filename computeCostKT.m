function [distMat, munMat, meanDist, indMat] = computeCostKT(F1, M)

F1ind = F1(:,end)~=0;
Mind = M(:,end)~=0;

F1mean = mean(F1(F1ind,1:2),1);
Mmean = mean(M(Mind,:),1);

F1(:,1:2) = F1(:,1:2)-repmat(F1mean,size(F1,1),1);
M = M - repmat(Mmean,10,1);

indMat = repmat(F1ind,1,10).*repmat(Mind',10,1);

distMat = ipdm(F1(:,1:2),M);
distMat = distMat.*indMat;
distMat(distMat == 0) = Inf;

[munMat,~] = munkresMinMat(distMat);

meanDist = sqrt(sum(F1mean-Mmean).^2);