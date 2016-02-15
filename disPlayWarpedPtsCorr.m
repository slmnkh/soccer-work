function opI = disPlayWarpedPtsCorr(tP);



szOp = [353 641];
opI = zeros(szOp);
ind = sub2ind(size(opI), tP(:,1), tP(:,2));
opI(ind) = 255;

figure; imshow(opI); hold on

% opI = opI(:,end:-1:1);
% opI = opI';