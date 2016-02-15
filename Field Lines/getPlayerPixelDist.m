function [bottomFieldGreenCounter,fieldGreenCounter] = getPlayerPixelDist(ImPlayerBk,Imrgb,bottomPercent)

numOfStd = 1;

[redMean,redStd,greenMean,greenStd,blueMean,blueStd] = getColorDist(Imrgb);

%% Eliminating green area in the box and retaining
%% non-green area.
fieldGreenCounter = 1;
notFieldGreenCounter = 1;
bottomFieldGreenCounter = 0;
ImPlayerRedValues = 0;
ImPlayerGreenValues = 0;
ImPlayerBlueValues = 0;

for i=1:size(ImPlayerBk,1)
   for j=1:size(ImPlayerBk,2)
       %% Eliminate Field-Green RGB Values
       if ImPlayerBk(i,j,1)<(redMean+numOfStd*redStd) && ImPlayerBk(i,j,2)>(greenMean-numOfStd*greenStd) && ImPlayerBk(i,j,3)<(blueMean+numOfStd*blueStd)
            ImPlayerBk(i,j,1) = 0;
            ImPlayerBk(i,j,2) = 0;
            ImPlayerBk(i,j,3) = 0;

            fieldGreen(fieldGreenCounter,1) = i;
            fieldGreen(fieldGreenCounter,2) = j;
            fieldGreenCounter = fieldGreenCounter + 1;
            
            if i > ((100 - bottomPercent) * size(ImPlayerBk,1)/100)
                bottomFieldGreenCounter = bottomFieldGreenCounter + 1;
            end
       else
            %% Get the Non-Field-Green RGB values
            if (i<=floor(size(ImPlayerBk,1)/2))
                ImPlayerRedValues(notFieldGreenCounter,1) = ImPlayerBk(i,j,1);
                ImPlayerGreenValues(notFieldGreenCounter,1) = ImPlayerBk(i,j,2);
                ImPlayerBlueValues(notFieldGreenCounter,1) = ImPlayerBk(i,j,3);
                notFieldGreenCounter = notFieldGreenCounter + 1;
            end
       end
   end
end

ImgSize = size(ImPlayerBk);
ImgSize = ImgSize(1:2);
ImPlayerMask = zeros(ImgSize);

for i=1:size(fieldGreen,1)
   ImPlayerMask(fieldGreen(i,1),fieldGreen(i,2)) = 255;
end


%%
ImPlayer = ImPlayerBk;

for i=1:size(fieldGreen,1)
   ImPlayer(fieldGreen(i,1),fieldGreen(i,2),1) = 0;
   ImPlayer(fieldGreen(i,1),fieldGreen(i,2),2) = 0;
   ImPlayer(fieldGreen(i,1),fieldGreen(i,2),3) = 0;
end
% 
% 
% figure,imshow(ImPlayerMask);
% figure,imshow(ImPlayer);

end