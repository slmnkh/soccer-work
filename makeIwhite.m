close all

I = imread('LinesSalman.jpg');
Iw = I;
inds = find(I(:)> 125);
Iw(:,:,3) = 255;
Iw(:,:,2) = 255;
Iw(:,:,1) = 255;
Iw(inds) = 0;


% %% landscape to portrait
% temp = Iw;
% Iw = [];
% Iw(:,:,1) = temp(:,:,1)';
% Iw(:,:,2) = temp(:,:,2)';
% Iw(:,:,3) = temp(:,:,3)';
%%
% figure; imshow(Iw);
%% grayscale Iw
Iw = rgb2gray(Iw);
% figure; imshow(Iw)
%% change black to grey
Iw(Iw == 0) = 0.6*max(Iw(:));
figure; imshow(Iw)