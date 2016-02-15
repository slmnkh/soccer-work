function [ImRevBin] = removeFootballGroundForFieldLines(Imrgb)
% Imrgb = I;
bboxRatio = 1/100;

% [redMean,redStd,greenMean,greenStd,blueMean,blueStd] = getColorDist(Imrgb(188:end,:,:));
[redMean,redStd,greenMean,greenStd,blueMean,blueStd] = getColorDist(Imrgb);
    
ImBk = Imrgb;

for i=1:size(ImBk,1)
   for j=1:size(ImBk,2)
%        if ImBk(i,j,1)<(redMean+2*redStd) && ImBk(i,j,2)>(greenMean-greenStd) && ImBk(i,j,3)<(blueMean+2*blueStd)
       if ImBk(i,j,1)<(redMean+redStd) && ImBk(i,j,2)>(greenMean-greenStd) && ImBk(i,j,3)<(blueMean+blueStd)

       else
           ImBk(i,j,1) = 0;
           ImBk(i,j,2) = 0;
           ImBk(i,j,3) = 0;
       end
   end
end



ImBkGray = rgb2gray(ImBk);
ImBkBinary = im2bw(ImBkGray,0);

%% Form Minimum Bounding Rectangles (MBR) on the binary image and find the
%% maximum area boundary
ImRP = regionprops(bwlabel(ImBkBinary),'BoundingBox');       %BoundingBox: [Col Row ColLength RowLength]
% 


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


ImArea = regionprops(bwlabel(ImBlank),'Area');            %Area: giving area of each region in the image
% ImArea = regionprops(bwlabel(ImBkBinary),'Area');            %Area: giving area of each region in the image
for i=1:size(ImArea,1)
   ImAreas(i)=ImArea(i).Area; 
end

indexOfBk = find(ImAreas>max(ImAreas)-1);

% bkRegion = ImRP(indexOfBk).BoundingBox;
bkRegion = ImRP2(indexOfBk).BoundingBox;

%% Erase area outside the rectangle i.e. audience,etc


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