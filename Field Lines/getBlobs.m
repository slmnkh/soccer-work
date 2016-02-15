function [I2] = getBlobs(ImRevBin)

    %
    % Play Area
    %
    ImBB = regionprops(bwlabel(ImRevBin),'BoundingBox');
    ImBBA = regionprops(bwlabel(ImRevBin),'Area');
    
%     figure,imshow(ImRevBin);
% 
%     hold on
%     for i=1:size(ImBB,1)
%         rectangle('Position',[ImBB(i).BoundingBox],'EdgeColor','r');
%         text(ImBB(i).BoundingBox(1)+ImBB(i).BoundingBox(3)/2,ImBB(i).BoundingBox(2),num2str(i),'Color','b');
%     end
%     hold off
    
    Ic=canny(ImRevBin,1);
    
    Ican = bwmorph(ImRevBin,'thin');      %We do thinning so that the field lines get thin enuf to eliminate    
    
    %%
%     Ican(1,:) = 0;
%     Ican(:,1) = 0;
%     Ican(size(Ican,1),:) = 0;
%     Ican(:,size(Ican,2)) = 0;
    %%
    Ican = imcomplement(Ican);
%     Ican = bwmorph(Ican,'majority',10);
    Ican = bwmorph(Ican,'majority',Inf); %This morphing operation eliminates 0 pixels having majority '1's around them
    %Ican = bwmorph(Ican,'thin',Inf); %This would lead to thinning the players and would get eliminated in the end
    Ican = imcomplement(Ican);
    Ican = canny(Ican,1);                %We do canny edge operation so that region outside the field which is white could be removed by forming a boundary at its outside
    
    %% Remove first and last column+row            %We do this so that
    %% fill operation doesnt fill the region outside the field again...
    Ican(1,:) = 0;
    Ican(:,1) = 0;
    Ican(size(Ican,1),:) = 0;
    Ican(:,size(Ican,2)) = 0;
    
    %% Threshold the image so that low intensity values get eliminated.
    Ican = im2bw(Ican,0.2);
    Ican = imfill(Ican,'holes');          %To fill in the player bots
    Ican = bwmorph(Ican,'thin');
    Ican = imcomplement(Ican);
    Ican = bwmorph(Ican,'majority',Inf);  %This time we eliminate the boundary line of the field
    Ican = imcomplement(Ican);
    Ican = bwareaopen(Ican,20,8);
    %Imbin = canny(Imbin,1);

    %
    % Play Area Ends
    %
    I2=Ican;

    %% Trying to identify just the players and then apply PersonDetector, but its not working...
%     Img = getColorImg(I2,Imrgb);
%     detectPerson(Img,-3)
%     

end