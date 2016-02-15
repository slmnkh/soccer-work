function ret = removeDuplicatePoints(tP)

szOpT = [640 352];
szOpTby2 = round(szOpT/2);

ind1 = find(tP(1,:) <  -szOpTby2(1) | tP(1,:) > szOpTby2(1));
ind2 = find(tP(2,:) < -szOpTby2(2)  | tP(2,:) > szOpTby2(2));
ind = union(ind1,ind2);
 
tP(:,ind) = [];

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

ind = sub2ind(szOp, tP(:,1), tP(:,2));
ind = unique(ind);

[a,b] = ind2sub(szOp, ind);

ret = [a b];