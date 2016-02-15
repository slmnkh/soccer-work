function [imOut, imOutMask]=imWarp(im, H, mosaicScope, imMosaic, imMosaicMask)
% im should be grayscale
% mosaicScope=[xMin, xMax, yMin, yMax]

% Version 1.0 [-]: Original Version
% Version 2.0 [2009-09-28]: Added code for mosaic and alpha-blending

imWarped=[]; imMask=[];

yMin=mosaicScope(1); yMax=mosaicScope(3);
xMin=mosaicScope(2); xMax=mosaicScope(4);
tform=maketform('projective',[
    [H(1) H(2) H(3)]
    [H(4) H(5) H(6)]    
    [H(7) H(8) H(9)] ]);

imWarped=imtransform(double(im), tform, 'bicubic', 'XData', [xMin xMax], 'YData', [yMin yMax], 'FillValues', NaN);
imMask=~isnan(imWarped);
imOut=imWarped; imOutMask=imMask;

if nargin == 5
    imMaskOL=imMosaicMask&imMask;
    imMosaicOut=imMosaic;
    imMosaicOut(imMask)=imWarped(imMask);
    imMosaicMask(imMask)=imMask(imMask);
%     imMosaicOut(imMaskOL)=.5*imMosaic(imMaskOL)+.5*imWarped(imMaskOL);
    imOut=imMosaicOut; imOutMask=imMosaicMask;
end