function BW = getFieldLinesSalman(Imrgb, jerseyColorPixels)

bboxRatio = 1/100;

[redMean,redStd,greenMean,greenStd,blueMean,blueStd] = getColorDist(Imrgb);
    
ImBk = Imrgb;

for i=1:size(ImBk,1)
   for j=1:size(ImBk,2)
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

I = imcomplement(ImBkBinary);
I = bwareaopen(I,50,8);

Ithin2 = bwmorph(I,'thin', 4);
% Ithin2 = bwmorph(Ithin1,'thin');
% Ithin2 = imfill(Ithin2,'holes');

m1 = [-1;4;-1];m2 = [-1 4 -1]; m3 = [2 -1; -1 2]; m4 = [-1 2; 2 -1];
m3 = m3(:);
m4 = m4(:);

Iout = zeros(size(Ithin2));
for i = 5:size(Ithin2,1)-4
    for j = 5:size(Ithin2,2)-4
        
        
        
        patch = Ithin2(i:i+1,j:j+1);
        patch = patch(:);
        
        fr1 = sum(Ithin2(i-1:i+1,j).*m1);
        fr2 = sum(Ithin2(i,j-1:j+1).*m2);
        fr3 = sum(patch.*m3);
        fr4 = sum(patch.*m4);
        
%         if i == 205 && j == 535
%             fr1
%             fr2
%             fr3
%             fr4
%             pause
%         end
        fr1 = fr1 == 4;
        fr2 = fr2 == 4;
        fr3 = fr3 == 4;
        fr4 = fr4 == 4;
        
        if abs(fr1-fr2) == 1
            Iout(i,j) = 1;
        end
        if fr3 == 1
            Iout(i,j)=1;
            Iout(i+1,j+1)=1;
        end
        if fr4 == 1
            Iout(i+1,j)=1;
            Iout(i,j+1)=1;
        end
            
    end
end

BW = Iout;
% [H,T,R] = hough(BW);
% P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% % Find lines and plot them
% lines = houghlines(BW,T,R,P,'FillGap',50,'MinLength',7);

% figure, imshow(BW), hold on

% %%
% max_len = 0;
% for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% 
%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% 
%    % Determine the endpoints of the longest line segment
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > max_len)
%       max_len = len;
%       xy_long = xy;
%    end
% end
% 
% % highlight the longest line segment
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');
% 

%%


% for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    if abs(xy(1,2)-xy(2,2))  < abs(xy(1,1)-xy(2,1))
%        [smallx xpos] = min([xy(1,1),xy(2,1)]);
%        xpos2 = setdiff([1 2], xpos);
%        xmap = linspace(xy(xpos,1),xy(xpos2,1),xy(xpos2,1)-xy(xpos,1)+1);
%        ymap = round(interp1(xy(:,1),xy(:,2),xmap));
%        ind = sub2ind(size(BW), ymap, xmap);
%        BW(ind) = 1;
%    end
% end

BW = bwmorph(BW,'bridge');
BW = bwareaopen(BW,50,8);

ImBB = detectPlayersOnAnImage(Imrgb,jerseyColorPixels);

for i=1:size(ImBB,1)
   BW(ImBB(i,2):(ImBB(i,2)+ImBB(i,4)),ImBB(i,1):(ImBB(i,1)+ImBB(i,3))) = 0;
end

