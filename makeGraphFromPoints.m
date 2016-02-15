function G = makeGraphFromPoints(A);

G = zeros(size(A,1),size(A,1),2);

for i = 1:size(A,1)
    
    for j = 1:size(A,1)
        
        G(i,j,:) = A(i,:) - A(j,:);
        
    end
    
end