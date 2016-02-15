Iout = zeros(size(I,1),size(I,2));

for i = 1:size(I,1)
    
    for j = 1:size(I,2)
        
        temp = double(I(i,j,:));
%         if temp(2) > temp(1) && temp(2) > temp(3)
        if temp(2)/temp(1) > 1.1 && temp(2)/temp(3) > 2
            
            Iout(i,j) = 1;
            
        end
        
    end
    
end