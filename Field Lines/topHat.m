Ig = rgb2gray(I);
se = strel('square',7);
It = imtophat(Ig, se);