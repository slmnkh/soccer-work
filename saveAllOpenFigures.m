function saveAllopenFigures(numOfImages,name,path)
% function saveAllopenFigures(numOfImages);

if ~isdir(path)
    mkdir(path)
end
for i = numOfImages:-1:1
    
    saveas(gcf,[path '\' name sprintf('%02d.png',i)]);
%     saveas(gcf,[path '\' name sprintf('%02d.eps',i)]);
    saveas(gcf,[path '\' name sprintf('%02d.fig',i)]);
    saveas(gcf,[path '\' name sprintf('%02d.eps',i)]);
    pause(0.05)
%     saveas(gcf,[path '\' name sprintf('%02d.jpg',i)]);
    close;
    
end