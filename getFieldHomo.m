
function [H, imWarped] = getFieldHomo(params)

offset = 10;
% homoPs = [params(1) params(2);
%     params(1)+5 params(2)+5;
%         params(1)+offset+10 params(2)+offset+10;
%         params(1)+10-20 params(2)+offset-30;
%         params(1)+offset+20 params(2)+offset-10;
%         params(1)+offset-30 params(2)+offset+10];
        
homoPs = repmat(params(1:2),100,1) + round(rand(100,2).*80 + 20);

    P = [homoPs ones(size(homoPs,1),1)];
        
    
%%
cCen = [params(1) params(2) 1];
cPos = [880, 410, 140];
f = params(3);
% %%
% warpPts = [cCen+[-30 -10 0];
%            cCen+[-20 40 0];
%            cCen+[50 60 0];
%            cCen+[70 -80 0];];

% P = [P; warpPts];
theta = atan2((cPos(2) - cCen(2)),((cPos(1) - cCen(1))));
phi = atan2((cPos(3)-cCen(3)),(sqrt(sum((cPos(2)-cCen(2)).^2 + (cPos(1)-cCen(1)).^2))));

R = [-sin(theta) cos(theta) 0 ;
    
    -sin(phi)*cos(theta) -sin(phi)*sin(theta) cos(phi);
    
    cos(phi)*cos(theta) cos(phi)*sin(theta) sin(phi)];

tP = R*(repmat(cPos,size(P,1),1) - P)';

tP(1,:) = -tP(1,:)./tP(3,:);
tP(2,:) = -tP(2,:)./tP(3,:);
tP(3,:) = -tP(3,:)./tP(3,:);

tP = round(tP.*f);

%%

szOpT = [640 352];
szOpTby2 = round(szOpT/2);

ind1 = find(tP(1,:) <  -szOpTby2(1) | tP(1,:) > szOpTby2(1));
ind2 = find(tP(2,:) < -szOpTby2(2)  | tP(2,:) > szOpTby2(2));
ind = union(ind1,ind2);
%  
% tP(:,ind) = [];

minX = -szOpTby2(1);
maxX = szOpTby2(1);

minY = -szOpTby2(2);
maxY = szOpTby2(2);

tP(1,:) = tP(1,:) - minX + 1;
tP(2,:) = tP(2,:) - minY + 1;


szOp = [353 641];
tP(2,:) = 353 - tP(2,:) + 1;
tP = tP';
temp = tP;
tP(:,1) = temp(:,2);
tP(:,2) = temp(:,1);

%%
homoTemp = homoPs;
homoTemp(:,1) = homoPs(:,2);
homoTemp(:,2) = homoPs(:,1);

H = ransacfithomography(temp(:,1:2)', homoTemp(:,1:2)', .1);

tempI = ones(szOp);

[imWarped, imMask]=imWarp((tempI), H, [1 1 544 820]);
H;