[szx szy szz] = size(I)

for i = 1:szx
    
    for j = 1:szy
        
        if squeeze(I(i,j,:)) == [0; 0; 0];
            I(i,j,:) = [255; 255; 255];
        end
        
        if squeeze(I(i,j,:)) == [255; 255; 255];
            I(i,j,:) = [0; 0; 0];
        end
        
    end
    
end
        