function score = watanabeFitness(tP,testPs);

threshold = 5;
temp = abs(ipdm(tP, testPs));
temp = temp < threshold;

temp = sum(temp,2);
temp = temp > 0;
score = sum(temp);