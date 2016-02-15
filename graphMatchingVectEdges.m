
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [X Z] = graphMatchingVectEdges(G1, G2)


%

%% original code
sigma = 1;

n1 = size(G1,1);
n2 = size(G2,1);
numberOfMatches = min(n1,n2);
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