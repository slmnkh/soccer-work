function acc = collectResultsKTFn(matToLoad)

load matToLoad
if affinityOn
    results = resultsA;
end
concatResults = [];
for i = 1:length(results)
    
    concatResults = [concatResults; results{i} i*ones(size(results{i},1),1)];
    
end

[indA indB] = sort(concatResults(:,1),1); % sort results to group together the same track number
concatResults = concatResults(indB,:); 


[a b] = unique(concatResults(:,1)); % find the total number of tracks

%% find overlap matrix and do bi partite if two or more tracks overlap and all have
%% high score for one formation id
%overlapMat = zeros(size(a,1));
%for i = 1:size(a,1)
 
% *** complete later    ***
 
 %% find the max votes for each track
    
votesMat = zeros(size(a,1),11);
temp = concatResults(1:b(1),2);
[histA histB] = hist(temp,1:11);
votesMat(1,:) = histA./length(temp);
for i = 2:size(a,1)
    temp = concatResults(b(i-1)+1:b(i),2);
    [histA histB] = hist(temp,1:11);
    votesMat(i,:) = histA./length(temp);
end

    
bestMatch = zeros(size(a,1),1);
for i = 1:size(a,1)
    [maxVal maxInd] = max(votesMat(i,:));
    bestMatch(i) = maxInd;
end

trackIdsWithResults = [a bestMatch];

for i = 1:size(a,1)
    if find(gtInds(:,1)==a(i))
        trackIdsWithResults(i,3) = gtInds(find(gtInds(:,1)==a(i)),2);
    end
end

trackIdsWithResults(trackIdsWithResults(:,3)==0,:)=[];
res = trackIdsWithResults(:,2)==trackIdsWithResults(:,3);
acc = sum(res)/length(res)

    
    