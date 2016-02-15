I = imread('footballField.jpg');
% cPos = [500,400,30];
[szY, szX, szZ] = size(I);
cPos = [round(szY/2), szX+100, 200];
cCen = [round(szY/2), round(szX/2), 1];



theta = atan2((cPos(2) - cCen(2)),((cPos(1) - cCen(1))));
phi = atan2((cPos(3)-cCen(3)),(sqrt(sum((cPos(2)-cCen(2)).^2 + (cPos(1)-cCen(1)).^2))));
% phi = -phi;

% theta = pi/2;
% phi = 0;

R = [-sin(theta) cos(theta) 0 ;
    
    -sin(phi)*cos(theta) -sin(phi)*sin(theta) cos(phi);
    
    cos(phi)*cos(theta) cos(phi)*sin(theta) sin(phi)];

R2 = [-cos(pi/2-theta) sin(pi/2-theta) 0 ;
    
    -cos(pi/2-phi)*sin(pi/2-theta) -cos(pi/2-phi)*cos(pi/2-theta) sin(pi/2-phi);
    
    sin(pi/2-phi)*sin(pi/2-theta) sin(pi/2-phi)*cos(pi/2-theta) cos(pi/2-phi)];


P = [550,350,1];
% P = [612,325,1];
% P = [350,550,0];

tP = R*(cPos - P)'

Ct = R*cPos';

% M = [R Ct];
% N = M;
% M(:,3) = [];

