function [acc1, acc2] = getBestCandidatesAddress(filename,indToLoad)

load formation2.mat;
load formation3.mat;
Wa = 1; Wb = 1; Wphi = 1;
bestNum = 3;
load(filename)
TT1 = correctTracksFnKT(fieldModelTracks);
TT2 = correctTracksFnKT_Team2(fieldModelTracks);
TracksTeam1 = TT1;
TracksTeam2 = TT2;
resultsA = {};
resultsB = {};

for i = 1:length(TracksTeam1)
    
    tempA = TracksTeam1{i};
    tempB = TracksTeam2{i};
    tempA(tempA(:,3)==0,:) = [];
    tempA(end+1:10,:) = 0;
    tempB(tempB(:,3)==0,:) = [];
    tempB(end+1:10,:) = 0;
    [A, Amat] = getBestCandidatesFn(tempA, formation2, bestNum);
    [B, Bmat] = getBestCandidatesFn(tempB, formation3, bestNum);
    affMat = [];
    if scheckValidity(Amat) && checkValidity(Bmat)
    for j = 1:length(A)
        for k = 1:length(B)
            affMat(j,k) = myEntropy([A{j}(1:find(A{j}==0,1)-1); B{k}(1:find(B{k}==0,1)-1)]);
        end
    end
    sumMat = (Wa.*Amat + Wb.*Bmat' + Wphi.*affMat);
    [~,bestId] = max(sumMat(:));
    [bestA, bestB] = ind2sub([bestNum bestNum],bestId);
    labelsA = A{bestA};
    labelsB = B{bestB};
    else
        labelsA = A{1};
        labelsB = B{1};
    end
    limA = find(labelsA==0,1);
    limB = find(labelsB==0,1);
    resultsA{i} = [tempA(1:limA-1,4) labelsA(1:limA-1)];
    resultsB{i} = [tempB(1:limB-1,4) labelsB(1:limB-1)];
    
    i;
    
end
affinityOn = 1;
str = ['\\visionnas2.cs.ucf.edu\share\graduate_students\Salman_Khokhar\Old_projects\Soccer\code_from_khurram\Code\Code_Salman\MatlabCodes\assocGT\Vid1Seq' sprintf('%d',indToLoad) '_Team1GTTrackAssoc'];
load(str)
gtInds = team1GTTrackAssoc;
collectResultsKTTeam1B
acc1 = acc;

str = ['\\visionnas2.cs.ucf.edu\share\graduate_students\Salman_Khokhar\Old_projects\Soccer\code_from_khurram\Code\Code_Salman\MatlabCodes\assocGT\Vid1Seq' sprintf('%d',indToLoad) '_Team2GTTrackAssoc'];
load(str)
gtInds = team2GTTrackAssoc;
collectResultsKTTeam2A
acc2 = acc;

%%