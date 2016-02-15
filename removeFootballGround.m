function [ImRevBin] = removeFootballGround(Imrgb,bboxRatio)

[redMean,redStd,greenMean,greenStd,blueMean,blueStd] = getColorDist(Imrgb);
    
ImBk = Imrgb;

for i=1:size(ImBk,1)
   for j=1:size(ImBk,2)
       if ImBk(i,j,1)<(redMean+redStd) && ImBk(i,j,2)>(greenMean-greenStd) && ImBk(i,j,3)<(blueMean+blueStd)
           %ImTh(i,j,1) = 255;
           %ImTh(i,j,2) = 255;
           %ImTh(i,j,3) = 255;
       else
           ImBk(i,j,1) = 0;
           ImBk(i,j,2) = 0;
           ImBk(i,j,3) = 0;
       end
   end
end

%figure,imshow(ImBk);   % View background

%     %% We need to blur the image so that the ground isn't split on field lines
%     %% Also we will use this ImBk2 to find the largest area i.e. field green
% hsize = 25;
% sigma = 5;
% H = fspecial('gaussian', hsize, sigma);
% ImBk2 = imfilter(rgb2gray(ImBk),H,'same','replicate');
% ImBkGray = ImBk2;
% ImBkBinary = (im2bw(ImBkGray, graythresh(ImBkGray)));

ImBkGray = rgb2gray(ImBk);
ImBkBinary = im2bw(ImBkGray,0);

%% Form Minimum Bounding Rectangles (MBR) on the binary image and find the
%% maximum area boundary
ImRP = regionprops(bwlabel(ImBkBinary),'BoundingBox');       %BoundingBox: [Col Row ColLength RowLength]
% 
% figure,imshow(ImBkBinary);
% hold on
% for i=1:size(ImRP,1)
%     rectangle('Position',[ImRP(i).BoundingBox],'EdgeColor','r');
% end
% hold off
% close;

%% Idea is to sum up all the BBox's and get the largest covered area by all
%% the green regions.
ImBlank = zeros(size(Imrgb,1),size(Imrgb,2));

for i=1:size(ImRP,1)
    rectBox = floor(ImRP(i).BoundingBox);
    
    if (rectBox(3) * rectBox(4)) > (bboxRatio * size(Imrgb,1) * size(Imrgb,2))
        %% Check Boundary Condition 
        if(rectBox(1)==0)
            rectBox(1) = rectBox(1) + 1;
            rectBox(3) = rectBox(3) - 1;
        end
        if(rectBox(2)==0)
            rectBox(2) = rectBox(2) + 1;
            rectBox(4) = rectBox(4) - 1;
        end
        if (rectBox(1)+rectBox(3)>size(Imrgb,2))
            rectBox(1) = rectBox(1) - ((rectBox(1)+rectBox(3)) - size(Imrgb,2));
        end
        if (rectBox(2)+rectBox(4)>size(Imrgb,1))
            rectBox(2) = rectBox(2) - ((rectBox(2)+rectBox(4)) - size(Imrgb,1));
        end

        ImBlank(rectBox(2):(rectBox(2)+rectBox(4)),rectBox(1):(rectBox(1)+rectBox(3))) = 255;
    end
end

ImRP2 = regionprops(bwlabel(ImBlank),'BoundingBox');       %BoundingBox: [Col Row ColLength RowLength]
% figure,imshow(ImBkBinary);
% hold on
% for i=1:size(ImRP2,1)
%     rectangle('Position',[ImRP2(i).BoundingBox],'EdgeColor','r');
% end
% hold off

ImArea = regionprops(bwlabel(ImBlank),'Area');            %Area: giving area of each region in the image
% ImArea = regionprops(bwlabel(ImBkBinary),'Area');            %Area: giving area of each region in the image
for i=1:size(ImArea,1)
   ImAreas(i)=ImArea(i).Area; 
end

indexOfBk = find(ImAreas>max(ImAreas)-1);

% bkRegion = ImRP(indexOfBk).BoundingBox;
bkRegion = ImRP2(indexOfBk).BoundingBox;
%ImDet = lineEllipseDetector(bkRegion,Imrgb);


%     %% Over here we bring back the original ImBk and extract background from it
%     ImBkGray = rgb2gray(ImBk);
%     ImBkBinary = im2bw(ImBkGray,0);

%% Erase area outside the rectangle i.e. audience,etc
% (Since we are using blurred image to get largest area, we need to binarise
% original image as well)

% ImBkGray = rgb2gray(ImBk);
% ImBkBinary = im2bw(ImBkGray,0);

for i=1:size(ImBkBinary,1)
   for j=1:size(ImBkBinary,2)
       if(i<floor(bkRegion(2)) || i>(floor(bkRegion(2))+floor(bkRegion(4))))
           ImBkBinary(i,j) = 0;
       end
       if(j<bkRegion(1) || j>(bkRegion(1)+bkRegion(3)))
           ImBkBinary(i,j) = 0;
       end

   end
end

%     figure,imshow(ImBkBinary);

ImRevBin = ImBkBinary;

%% Make reverse negative binary image to make player rectangles
ImRevBin = imcomplement(ImRevBin);
%imshow(ImRevBin);

%% Noise removal for small objects
ImRevBin = bwareaopen(ImRevBin,50,8);
%figure,imshow(ImRevBin);
    
end