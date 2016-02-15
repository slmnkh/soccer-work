function [ImPlayerRedValues,ImPlayerGreenValues,ImPlayerBlueValues] = getPlayerColorDist(ImPlayerBk,Imrgb)

numOfStd = 2;

[redMean,redStd,greenMean,greenStd,blueMean,blueStd] = getColorDist(Imrgb);

%% Eliminating green area in the box and retaining
%% non-green area.
fieldGreenCounter = 1;
notFieldGreenCounter = 1;
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

end