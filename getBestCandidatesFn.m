% function labels = netDeformationCost(mask, nodes, model, contextSates)
function [A Amat] = getBestCandidatesFn(nodes, model, numBest)



%% the track input is organized into a matrix with each row representing one player. If a
%% track id is not present in any frame, the corresponding row is all
%% zeros. 

numNodes = sum(nodes(:,3)~=0);
% nodeMean = mean(nodes);
if numNodes > 0 && numNodes < 11
    
% make a list of possible combinations having a number of nodes equal to
% those present in current frame from a total of ten from the model

combos = combntns(1:10,numNodes);


numModel = 10;

costs = [];

% get cost or distance of all nodes from the model nodes

distCosts = ipdm(nodes(:,1:2),model);


frameDistCosts = {};
frameGraphCosts = {};
frameIndMats = {};
frameMunMats = {};
frameMeanCosts = [];

% test combination added to first row of list of combinations
% combos = [1 2 3 4; combos];

% loop over all combinations possible and find the scores for each with the
% present frame's nodes

for i = 1:size(combos,1)
    
    subModel = zeros(size(model));
    subModel(combos(i,:),:) = 1;
    subModel = subModel.*model;
    [distMat, munMat, meanDist, indMat] = computeCost(nodes, subModel);
    distCostsTemp = distCosts.*indMat;
    distCostsTemp(distCostsTemp == 0) = Inf;
    frameMeanCosts(i) = meanDist;
    frameIndMats{i} = indMat;
    frameDistCosts{i} = distCostsTemp;
    frameGraphCosts{i} = distMat;
    frameMunMats{i} = munMat;
    
end

frameCombMunMat = {};

for i = 1:size(combos,1)
    
    temp = frameDistCosts{i} + frameGraphCosts{i};
    [a,b] = munkresMinMat(temp);
    temp(temp == Inf) = 0;
    frameCombMunMat{i} = a;
    C(i) = sum(sum(a.*temp)) + frameMeanCosts(i).*0.1;

end

for j = 1:numBest
[a,b] = min(C);
labels = zeros(10,1);
FinalMunMat = frameCombMunMat{b};
for i = 1:10
    temp = find(FinalMunMat(i,:) == 1);
    if ~isempty(temp)
        labels(i) = temp;
    end
end
A{j} = labels;
Amat(j,1) = a;
C(b) = Inf;
end

Amat = repmat(Amat,1,numBest);

else
    for i = 1:numBest
        A{i} = zeros(10,1);
    end
    Amat = zeros(numBest);
end
