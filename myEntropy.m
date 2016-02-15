function en = myEntropy(A)
A(A < 5) = 1;
A(A == 6 | A == 7) = 2;
A(A > 7 & A < 10) = 3;
A(A == 10) = 4;
entries = unique(A);
p = hist(A,entries);
p(p==0) = [];
p = p ./ sum(p);
en = -sum(p.*log2(p));
