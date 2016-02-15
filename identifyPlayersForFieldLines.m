function [allFrameBB,avgBB] = identifyPlayersForFieldLines(ImgBlobs,Imrgb,frameNum,thArea,thBottomPlayerPixels,thTotalPlayerPixels,thJerseyColorDiff,lengthTopPercent,jerseyColorPixels,avgBB,bottomPercent,showOutput)

    allFrameBB = 0;
    
    %% Get Bounding Boxes on Player Blobs...
    ImRPP = regionprops(bwlabel(ImgBlobs),'BoundingBox');      %BoundingBox: [Col Row ColLength RowLength]    %ImRPP: Region props for players

    %% Player and Referee Classification and then draw rectangle (select box, traverse half of it and find its mean and std then find
    %% difference from values in jerseyColorPixels)

    if showOutput
        imshow(Imrgb);            % Apply on the original frame to see the player bounding boxes.
        hold on
        for i=1:size(ImRPP,1)   
            rectangle('Position',[ImRPP(i).BoundingBox],'EdgeColor','r');
        end
        hold off

    %     imshow(Imrgb);
        title(sprintf('Frame Number:%d',frameNum));
    end
    
    frameBBCounter = 0;    % Counter to get the number of BB having players in a particular frame.
    
    for k=1:size(ImRPP,1)
        %% Flooring the bounding box values and then checking for boundary conditions.
        rectBox = floor([ImRPP(k).BoundingBox]);                            

        boxWidth = rectBox(3);
        boxLength = rectBox(4);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Apply multiple outlier rejection criteria%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %% Filter irregular boxes i.e. due to area, shape (having colLength > rowLength) and size.
        
        %% Length should be greater or equal to Width
        if (boxWidth<=boxLength)
            %% Length Shouldn't be too larger than width
            if ((5*boxWidth)>boxLength)
                %% Bounding Boxes Area Shouldn't be too small
                if ((boxWidth*boxLength)>thArea)
                    
                    %% Build a histogram of BB sizes and find out the majority
                    

                    %% Bounding Box Correction and update Average BB
                    ImgSize = size(Imrgb);
                    ImgSize = ImgSize(1:2);
                    [origRectBox,rectBox] = BBCorrection(rectBox,avgBB,ImgSize,lengthTopPercent);
                    
                    %% Extracting player bounding box to get Player Color Dist.
                    ImPlayerBk = Imrgb(origRectBox(2):(origRectBox(2)+origRectBox(4)),origRectBox(1):(origRectBox(1)+origRectBox(3)),:);
                    %figure,imshow(ImPlayerBk);
                    
                    [ImPlayerRedValues,ImPlayerGreenValues,ImPlayerBlueValues] = getPlayerColorDist(ImPlayerBk,Imrgb);
                    
                    %% Extracting player bounding box to get Bottom Player Pixels
                    ImPlayerBk = Imrgb(rectBox(2):(rectBox(2)+rectBox(4)),rectBox(1):(rectBox(1)+rectBox(3)),:);
                    %figure,imshow(ImPlayerBk);

                    [bottomFieldGreenCounter,fieldGreenCounter] = getPlayerPixelDist(ImPlayerBk,Imrgb,bottomPercent);
                    
                    totalPixels = size(ImPlayerBk,1)*size(ImPlayerBk,2);
                    totalBottomPixels = (bottomPercent/100) * totalPixels;
                    playerBottomPixels = totalBottomPixels - bottomFieldGreenCounter;
                    
                    if ((playerBottomPixels/totalBottomPixels) * 100 > thBottomPlayerPixels) && ((fieldGreenCounter/totalPixels)*100 > thTotalPlayerPixels)

                        %% Taking distance b/w the RGB values of JerseyColor and Top half of Player BB
                        for i=1:5
                            teamDistances(i) = sqrt((jerseyColorPixels(i,1)-mean(ImPlayerRedValues))^2+(jerseyColorPixels(i,2)-mean(ImPlayerGreenValues))^2+(jerseyColorPixels(i,3)-mean(ImPlayerBlueValues))^2);
                        end

                        if showOutput 
                            hold on
                        end
                        
                        if(min(teamDistances) == teamDistances(1)) && (min(teamDistances)<thJerseyColorDiff)           
                            if showOutput
                                rectangle('Position',rectBox,'EdgeColor',jerseyColorPixels(1,:)/255,'LineWidth',2);
                                text(rectBox(1)+rectBox(3)/2,rectBox(2),num2str(frameBBCounter));
                            end
                            
                            frameBBCounter = frameBBCounter + 1;

                            allFrameBB(frameBBCounter,1:4) = rectBox;
                            allFrameBB(frameBBCounter,5) = 1;
                        elseif(min(teamDistances) == teamDistances(2)) && (min(teamDistances)<thJerseyColorDiff)
                            if showOutput
                                rectangle('Position',rectBox,'EdgeColor',jerseyColorPixels(2,:)/255,'LineWidth',2);
                                text(rectBox(1)+rectBox(3)/2,rectBox(2),num2str(frameBBCounter));
                            end

                            frameBBCounter = frameBBCounter + 1;

                            allFrameBB(frameBBCounter,1:4) = rectBox;
                            allFrameBB(frameBBCounter,5) = 2;
                        elseif(min(teamDistances) == teamDistances(3)) && (min(teamDistances)<thJerseyColorDiff)
                            if showOutput
                                rectangle('Position',rectBox,'EdgeColor',jerseyColorPixels(3,:)/255,'LineWidth',2);
                                text(rectBox(1)+rectBox(3)/2,rectBox(2),num2str(frameBBCounter));
                            end

                            frameBBCounter = frameBBCounter + 1;

                            allFrameBB(frameBBCounter,1:4) = rectBox;
                            allFrameBB(frameBBCounter,5) = 3;
                        elseif(min(teamDistances) == teamDistances(4)) && (min(teamDistances)<thJerseyColorDiff)
                            if showOutput
                                rectangle('Position',rectBox,'EdgeColor',jerseyColorPixels(4,:)/255,'LineWidth',2);
                                text(rectBox(1)+rectBox(3)/2,rectBox(2),num2str(frameBBCounter));
                            end

                            frameBBCounter = frameBBCounter + 1;

                            allFrameBB(frameBBCounter,1:4) = rectBox;
                            allFrameBB(frameBBCounter,5) = 4;
                        else
                            %% Not coloring Referee at the moment
                            if showOutput
                                rectangle('Position',rectBox,'EdgeColor',[0 0 0],'LineWidth',2);
                            end
                            
                            frameBBCounter = frameBBCounter + 1;

                            allFrameBB(frameBBCounter,1:4) = rectBox;
                            allFrameBB(frameBBCounter,5) = 5;
                        end
                        if showOutput 
                            hold off
                        end
                    end
                end
            end  
        end
    end
end

%% Note: Either decide based on the original rectBox from ImgBlobs and take top half OR
%% maybe take 1/3rd of the new BBox.