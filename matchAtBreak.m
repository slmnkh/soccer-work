A = TRend13only(:,1:2);
B = TRstart23only(:,1:2);
A = A([1 2 3 4],:)

nA = size(A,1);
nB = size(B,1);

combos = combntns(1:nB,nA);
scores = zeros(size(combos,1),1);
GA = makeGraphFromPoints(A);


for i = 1:size(combos,1)
    
    temp = B(combos(i,:),:);
    
    GB = makeGraphFromPoints(temp);
    
    figure; hold on;
    
    plot(temp(:,1),temp(:,2),'r.');
    plot(A(:,1),A(:,2),'b.');
    
%     [X,Z] = graphMatchingVectEdges(GA,GB);
    [X,Z] = munkresPlayerPosMatching(A,temp);
    
    scores(i) = sum(sum(X.*Z));
    
end


