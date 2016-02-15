function [X,Z] = munkresPlayerPosMatching(A,B)

meanA = mean(A);
meanB = mean(B);

A = A-repmat(meanA,size(A,1),1);
B = B-repmat(meanB,size(B,1),1);

matA = [];

matA(:,:,1) = repmat(A(:,1),1,size(B,1));
matA(:,:,2) = repmat(A(:,2),1,size(B,1));


matB(:,:,1) = repmat(B(:,1)',size(B,1),1);
matB(:,:,2) = repmat(B(:,2)',size(B,1),1);

matC = matA - matB;

matC = matC.^2;

matC = sum(matC,3);

[a,b] = munkresMinMat(matC);
X = a;
Z = matC;


