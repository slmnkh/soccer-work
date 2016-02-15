function P = WatanabefieldToImage(Pt, theta, phi, cPos,f)

Y = Pt(1);
X = Pt(2);
R = [cos(phi)*cos(theta) -cos(phi)*sin(theta) -sin(phi);
    f 0 X;
    0 f Y];

intP = inv(R)*[-cPos(3);0;0];
% intP = intP./intP(3);
P = [-sin(theta) cos(theta) 0;
    -sin(phi)*cos(theta) -sin(phi)*sin(theta) cos(phi)]*intP;
% + [cPos(1); cPos(2)];

P = P';

