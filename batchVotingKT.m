clear
votes = [];


%% loop over all frames, 

% check the deformation cost of each frame with all possible model combinations that have the
% same number of nodes as the current frame.
% The output : "votes" is 10 x number of frames. For each column we get the
% most likely model label for each track
% The structure TracksTeam1 has a set of track locations for each frame for
% each team.
load formation2
load formation3
model = formation2;
load('\\visionnas2.cs.ucf.edu\share\graduate_students\Salman_Khokhar\Old_projects\Soccer\code_from_khurram\Code\Code_Salman\MatlabCodes\tracks\Vid1Seq7_fieldModelTracks.mat')
TT1 = correctTracksFnKT(fieldModelTracks);
TracksTeam1 = TT1;

results = {};
for i = 1:length(TracksTeam1)
    
    temp = TracksTeam1{i};
%     temp = temp(1:10,:);
    temp(temp(:,3)==0,:) = [];
    temp(end+1:10,:) = 0;
    labels = netDeformationCost(temp, model);
    votes(:,i) = labels;
    lim = find(labels==0,1);
    results{i} = [temp(1:lim-1,4) labels(1:lim-1)];
    i
    
end

affinityOn = 0;

%%


% Check the mode for each track and assign a label based on an optimized
% assignmnet using mode ratio

finalClasses = [];

votesInf = votes;
votesInf(votesInf==0)=NaN;
% for i = 1:10
%     
%     finalClasses(i) = mode(votesInf(i,:));
%     
% end

counts = [];
for i = 1:10
    
    
    for j = 1:10
        counts(i,j) = (sum(votesInf(i,:)==j))/sum(~isnan(votesInf(i,:)));
    end
end

cClasses = munkresMaxMat(counts);

%