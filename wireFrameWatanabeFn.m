% I = imread('LinesSalman.jpg');
load testI2
[a,b] = find(I == 255);
FieldPts = [a b ones(size(a,1),1)]

[szX, szY, szZ] = size(I);
%% params;
cCen = [round(szX/2), round(szY/2), 0];
% cCen = [100, 100, 1];
f = 1500;
cPos = [szX+200, round(szY/2), 200];
%%
warpPts = [cCen+[-30 -10 0];
           cCen+[-20 40 0];
           cCen+[50 60 0];
           cCen+[70 -80 0];];
%        warpPts = [50 50 1;
%            50 403 1;
%            158 139 1;
%            117 49 1];
% temp = warpPts;
% warpPts(:,1) = temp(:,2);
% warpPts(:,2) = temp(:,1);
FieldPts = [FieldPts; warpPts];
       %%
       % cPos = [-200, 400,2]

%%
% FieldPts = [];

theta = atan2((cPos(2) - cCen(2)),((cPos(1) - cCen(1))));
phi = atan2((cPos(3)-cCen(3)),(sqrt(sum((cPos(2)-cCen(2)).^2 + (cPos(1)-cCen(1)).^2))));

R = [-sin(theta) cos(theta) 0 ;
    
    -sin(phi)*cos(theta) -sin(phi)*sin(theta) cos(phi);
    
    cos(phi)*cos(theta) cos(phi)*sin(theta) sin(phi)];


% P = [550,350,0;
%     230,120,0];
P = FieldPts;
% P = [612,325,1];
% P = [350,550,0];

tP = R*(repmat(cPos,size(P,1),1) - P)';

tP(1,:) = -tP(1,:)./tP(3,:);
tP(2,:) = -tP(2,:)./tP(3,:);
tP(3,:) = -tP(3,:)./tP(3,:);

tP = round(tP.*f);
warpedPts = tP(:,end-3:end);
tP = tP(:,1:end-4);
%%      ``

%%

% szOpT = [342 640];
szOpT = [640 352];
szOpTby2 = round(szOpT/2);

ind1 = find(tP(1,:) <  -szOpTby2(1) | tP(1,:) > szOpTby2(1));
ind2 = find(tP(2,:) < -szOpTby2(2)  | tP(2,:) > szOpTby2(2));
ind = union(ind1,ind2);
 
tP(:,ind) = [];

%%

% minX = min(tP(1,:));
% maxX = max(tP(1,:));
% 
% minY = min(tP(2,:));
% maxY = max(tP(2,:));
minX = -szOpTby2(1);
maxX = szOpTby2(1);

minY = -szOpTby2(2);
maxY = szOpTby2(2);

tP(1,:) = tP(1,:) - minX + 1;
tP(2,:) = tP(2,:) - minY + 1;

%%

warpedPts(1,:) = warpedPts(1,:) - minX + 1;
warpedPts(2,:) = warpedPts(2,:) - minY + 1;

warpedPts = warpedPts';

temp = warpedPts;
warpedPts(:,1) = temp(:,2);
warpedPts(:,2) = temp(:,1);
warpedPts = warpedPts(:,1:2);


% szOp = [343 641];
szOp = [641 353];
% szOp = [maxX-minX+1 maxY-minY+1];
% szOpby2 = round(szOp/2);
% 
% tP(1,:) = tP(1,:) + szOpby2(1);
% tP(1,:) = tP(2,:) + szOpby2(2);

% ind1 = find(tP(1,:) < 1 | tP(1,:) > szOp(1));
% ind2 = find(tP(2,:) < 1 | tP(2,:) > szOp(2));
% ind = union(ind1,ind2);
% 
% tP(:,ind) = [];

opI = zeros(szOp);
ind = sub2ind(size(opI), tP(1,:), tP(2,:));
opI(ind) = 255;


% opI = opI(:,size(opI,2):-1:1);
% warpedPts(:,1) = size(opI,2) + 1 - warpedPts(:,1);
% opI = opI';
% temp = warpedPts;
% warpedPts(:,1) = temp(:,2);
% warpedPts(:,2) = temp(:,1);
figure; imshow(opI);

% 
% 
% 
% orthoRecPts = [1 1 1; 1 szOp(2)-1 1; szOp(1)-1 1 1; szOp(1)-1 szOp(2)-1 1];
% % orthoPts = orthoRecPts;
% % 
% orthoPts = zeros(size(orthoRecPts,1),2);
% for i = 1:size(orthoRecPts,1)
%     orthoPts(i,:) = WatanabefieldToImage(orthoRecPts(i,1:2), theta, phi, cPos,f);
% end
% 
%  
% H = ransacfithomography(orthoRecPts(:,1:2)',orthoPts(:,1:2)',10);
H = ransacfithomography(warpedPts(:,1:2)',warpPts(:,1:2)',10);
% 
temp = ones(size(opI)).*255;
warpedMask = imWarp(temp,H,[1 1 544 820]);
% 
% hold on
% plot(orthoRecPts(:,1),orthoRecPts(:,2),'r.')
% 


