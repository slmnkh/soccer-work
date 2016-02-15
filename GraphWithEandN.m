
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [X Z] = GraphWithEandN(Trans1, Trans2)


%%%%%%%%%%%%%%%%% find the lie representations of transformations that
%%%%%%%%%%%%%%%%% exist between the patterns of one play 1.
G1 = [];
for i = 1:length(Trans1.from)
    for j = 1:length(Trans1.from)
      G1(i,j,:) = Trans1.from{i}.to{j};
    end
end
weights = [1 1 0.1 0.2];
weightMat = ones(size(G1));
weightMat(:,:,1) = weightMat(:,:,1).*1;
weightMat(:,:,2) = weightMat(:,:,2).*1;
weightMat(:,:,3) = weightMat(:,:,3).*0.1;
weightMat(:,:,4) = weightMat(:,:,4).*0.2;
G1 = G1.*weightMat;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%% find the lie representations of transformations that
%%%%%%%%%%%%%%%%% exist between the patterns of one play 2.

G2 = [];
for i = 1:length(Trans2.from)
    for j = 1:length(Trans2.from)
      G2(i,j,:) = Trans2.from{i}.to{j};
    end
end

% weighting
weights = [1 1 0.1 0.2];
weightMat = ones(size(G2));
weightMat(:,:,1) = weightMat(:,:,1).*1;
weightMat(:,:,2) = weightMat(:,:,2).*1;
weightMat(:,:,3) = weightMat(:,:,3).*0.1;
weightMat(:,:,4) = weightMat(:,:,4).*0.2;
G2 = G2.*weightMat;

%

%% original code
sigma = 1;
numberOfMatches = min(length(Trans1.from), length(Trans2.from));
n1 = size(G1,1);
n2 = size(G2,1);
G2t = [];
for i = 1:size(G2,3)
    G2t(:,:,i) = G2(:,:,i)';
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%    
    Y = zeros(n1,n2);
    
    for i = 1 : n1
        for j = 1 : n2
            
            %%%%%%%%%%%%%%%% added by salman
            A = repmat(G1(:,i,:),1,n2) - repmat(G2t(j,:,:),n1,1);
            A = A.*A;
            d = sum(A,3);
            d = sqrt(d);
            d = d./max(d(:));
            Y = Y + exp((-d.*d) ./ sigma);
        
        end
    end

    % Do hypergraph matching over Y:

    [X,Z] = hypergraphMatching (Y, numberOfMatches);
    
%     match = munkres(1-Z);
%     ind = 1:size(Z,1);
%     ind = [ind; match];
%     prob = 0;
%     for i = 1:size(ind,2)
%         prob = prob + Z(ind(1,i), ind(2,i));
%     end
% %     prob = sum(Z(ind(1,:),ind(2,:)));
% prob