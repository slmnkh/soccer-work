function G = makeGraphFromPointsDist(A)

G = zeros(size(A,1),size(A,1));

for i = 1:size(A,1)
    
    for j = 1:size(A,1)
        
        temp = A(i,:) - A(j,:);
        G(i,j) = sqrt(sum(temp.^2));
        
    end
    
end