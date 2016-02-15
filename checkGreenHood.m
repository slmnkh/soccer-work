



I = tempThin;
Ithin1 = bwmorph(I,'thin');
Ithin2 = bwmorph(Ithin1,'thin');
Ithin2 = imfill(Ithin2,'holes');
m1 = [-1 -1 -1; 2 2 2; -1 -1 -1];
m2 = m1';
m3 = [-1 -1 2; -1 2 -1; 2 -1 -1];
m4 = [2 -1 -1; -1 2 -1; -1 -1 2];
m1 = m1(:);
m2 = m2(:);
m3 = m3(:);
m4 = m4(:);

Iout = zeros(size(Ithin2));
for i = 2:size(Ithin2,1)-1
    for j = 2:size(Ithin2,2)-1
        
        
        
        patch = Ithin2(i-1:i+1,j-1:j+1);
        patch = patch(:);
        fr1 = sum(patch.*m1);
        fr2 = sum(patch.*m2);
        fr3 = sum(patch.*m3);
        fr4 = sum(patch.*m4);
        
        if i == 205 && j == 535
            fr1
            fr2
            fr3
            fr4
            pause
        end
        if max([fr1 fr2 fr3 fr4]) == 6
            Iout(i,j) = 1;
        end
    end
end
% 
BW = Iout;
[H,T,R] = hough(BW);
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
% Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);

figure, imshow(BW), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');