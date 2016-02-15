function [a, chosenInds] = munkresMaxMat(b)

bP = max(b(:))-b;
% bP = b;
c = munkres(bP);

ind = 1:size(b,1);

chosenInds = [ind' c'];

ch2rem = find(chosenInds(:,2) == 0);

chosenInds(ch2rem,:) = [];

a = zeros(size(b));

for i = 1:size(chosenInds)
    
    a(chosenInds(i,1),chosenInds(i,2)) = 1;
    
end