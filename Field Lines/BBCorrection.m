function [origRectBox,rectBox] = BBCorrection(rectBox,avgBB,ImgSize,lengthTopPercent)

%% Check Boundary Condition because before calling this function rectBox was floored...
if(rectBox(1)==0)
    rectBox(1) = rectBox(1) + 1;
    rectBox(3) = rectBox(3) - 1;
end
if(rectBox(2)==0)
    rectBox(2) = rectBox(2) + 1;
    rectBox(4) = rectBox(4) - 1;
end

origRectBox = rectBox;

avgBBWidth = avgBB(1);
avgBBLength = avgBB(2);

x = rectBox(1);
y = rectBox(2);
w = rectBox(3);
l = rectBox(4);

if w < avgBBWidth
    dw = avgBBWidth - w;
    if (x - floor(dw/2)) < 1
        x = 1;
    else
        x = x - floor(dw/2);
    end
    w = avgBBWidth;
elseif w > avgBBWidth
    %% Let it be as it is
%     dw = w - avgBBWidth;
%     if (x + floor(dw/2)) > ImgSize(2)
%         x = ImgSize(2);
%     else
%         x = x + floor(dw/2);
%     end
%     w = avgBBWidth;
else
    % Do Nothing
end

if l < avgBBLength
    dl = avgBBLength - l;
    if (y - floor(dl*lengthTopPercent/100)) < 1
        y = 1;
    else
        y = y - floor(dl*lengthTopPercent/100);
    end
    l = avgBBLength;
elseif l > avgBBLength
    %% Let it be as it is
%     dl = l - avgBBLength;
%     if (y + floor(dl/2)) > ImgSize(1)
%         y = ImgSize(1);
%     else
%         y = y + floor(dl/2);
%     end
%     l = avgBBLength;
else
    % Do Nothing
end

%% Update everything
rectBox(1) = x;
rectBox(2) = y;
rectBox(3) = w;
rectBox(4) = l;

%% Use Floor to avoid decimal values
 rectBox = floor(rectBox);

%% Check Boundary Condition 
if(rectBox(1)==0)
    rectBox(1) = rectBox(1) + 1;
    rectBox(3) = rectBox(3) - 1;
end
if(rectBox(2)==0)
    rectBox(2) = rectBox(2) + 1;
    rectBox(4) = rectBox(4) - 1;
end
if (rectBox(1)+rectBox(3)>ImgSize(2))
    rectBox(1) = rectBox(1) - ((rectBox(1)+rectBox(3)) - ImgSize(2));
end
if (rectBox(2)+rectBox(4)>ImgSize(1))
    rectBox(2) = rectBox(2) - ((rectBox(2)+rectBox(4)) - ImgSize(1));
end

end
