


Imrgb = imread('seq01orig.bmp');
load tempThin
I = tempThin;
Ithin1 = bwmorph(I,'thin');
Ithin2 = bwmorph(Ithin1,'thin');
Ithin2 = imfill(Ithin2,'holes');

m1 = [-1;4;-1];m2 = [-1 4 -1]; m3 = [2 -1; -1 2]; m4 = [-1 2; 2 -1];
m3 = m3(:);
m4 = m4(:);

Iout = zeros(size(Ithin2));
for i = 2:size(Ithin2,1)-1
    for j = 2:size(Ithin2,2)-1
        
        
        
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

BW = Iout2;
[H,T,R] = hough(BW);
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',50,'MinLength',7);

figure, imshow(BW), hold on

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


for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   if abs(xy(1,2)-xy(2,2))  < abs(xy(1,1)-xy(2,1))
       [smallx xpos] = min([xy(1,1),xy(2,1)]);
       xpos2 = setdiff([1 2], xpos);
       xmap = linspace(xy(xpos,1),xy(xpos2,1),xy(xpos2,1)-xy(xpos,1)+1);
       ymap = interp1(xy(:,1),xy(:,2),xmap);
       ind = sub2ind(size(BW), ymap, xmap);
       BW(ind) = 1;
   end
end

% highlight the longest line segment
figure; imshow(BW)
%%