% function labels = netDeformationCost(mask, nodes, model, contextSates)
function labels = netDeformationCost(nodes, model)



%% the track input is organized into a matrix with each row representing one player. If a
%% track id is not present in any frame, the corresponding row is all
%% zeros. 

numNodes = sum(nodes(:,3)~=0);
% nodeMean = mean(nodes);
if numNodes > 0 & numNodes < 11
    
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
    subModel(combos(i,:),:) = 1; % make all rows with the players in combos(i,:) 1, leave others zero
    subModel = subModel.*model; % remove all rows with players not in current combo
    [distMat, munMat, meanDist, indMat] = computeCost(nodes, subModel);
    % compute cost makes all non-relevant rows from subModel Inf.
    % distMat has distances between points in nodes and subModel, Its value
    % is 0 for those indices (i,j) where either i does not exist in nodes
    % or j does not exist in subModel or both.
    % meanDist has the distance between centres of nodes and subModel
    % indMat is 1 where distMat should have a value, 0 otherwise.
    
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
    
    temp = frameGraphCosts{i} + frameDistCosts{i};
%     temp = frameDistCosts{i};
%     temp = frameGraphCosts{i};
    [a,b] = munkresMinMat(temp);
    temp(temp == Inf) = 0;
    frameCombMunMat{i} = a;
    C(i) = sum(sum(a.*temp)) + frameMeanCosts(i).*0.1;
end


[a,b] = min(C);
nodeInds = find(nodes(:,end)~=0);
labels = zeros(10,1);
FinalMunMat = frameCombMunMat{b};
for i = 1:10
    temp = find(FinalMunMat(i,:) == 1);
    if ~isempty(temp)
        labels(i) = temp;
    end
end
else
    labels = zeros(10,1);
end
        


