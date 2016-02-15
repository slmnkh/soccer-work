setA = .. % this is the set of top 3 or 5 best combinations for team 1 for current frame

setB = .. % this is the set of top 3 or 5 best combinations for team 2 for current frame

% loop over all pairs and compute affinity using jaccard distance or
% entropy. setA{1}.formationIds = [1 2 3 5 6]; setA{1}.roles = [1 1 1 2 2],
% where roles = {1: defender, 2: defensive midfielder, 3: attacking
% midfielder, 4: attacker}

for i = 1:length(setA)
    for j = 1:length(setB)
        
        
        enMat(i,j) = myEntropy(setA{i}.roles,setB{j}.roles);
        
    end
end

