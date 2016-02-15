%% Make Football Field
% Details
% Length = 120
% Width = 74

length = 120;
width = 74;
magnify = 6;
border = 50;
color = 'k';
color = [150 150 150];
lineWidth = 1.2;
M = zeros((width * magnify)+2*border,(length * magnify)+2*border,3);
% M(:,:,1) = 93; M(:,:,2) = 129; M(:,:,3) = 67;
M(:,:,:) = 255;

% To draw Field Lines on KDE
% I = imread('PlayerCM.png');
% I2 = imresize(I,[544 820]);
% M = I2;

figure,imshow(uint8(M))
hold on

% Draw Rectangle
x = border;
y = border;
l = length * magnify;
w = width * magnify;
rectangle('Position',[x y l w], 'EdgeColor', color, 'LineWidth',lineWidth);

% Draw 18 Yard Box
% Left
x = border;
y = border + magnify * (width - 44)/2;
l = 18 * magnify;
w = 44 * magnify;
rectangle('Position',[x y l w], 'EdgeColor', color, 'LineWidth',lineWidth);

% Right
x = ((length - 18) * magnify) + border;
y = border + magnify * (width - 44)/2;
l = 18 * magnify;
w = 44 * magnify;
rectangle('Position',[x y l w], 'EdgeColor', color, 'LineWidth',lineWidth);

% Draw 6 Yard Box
% Left
x = border;
y = border + magnify * (width - 20)/2;
l = 6 * magnify;
w = 20 * magnify;
rectangle('Position',[x y l w], 'EdgeColor', color, 'LineWidth',lineWidth);

% Right
x = ((length - 6) * magnify) + border;
y = border + magnify * (width - 20)/2;
l = 6 * magnify;
w = 20 * magnify;
rectangle('Position',[x y l w], 'EdgeColor', color, 'LineWidth',lineWidth);

% Draw Goal
% Left
x = border - (8/3) * magnify;
y = border + magnify * (width - (24/3))/2;
l = (8/3) * magnify;
w = (24/3) * magnify;
rectangle('Position',[x y l w], 'EdgeColor', color, 'LineWidth',lineWidth);

% Right
x = (length * magnify) + border;
y = border + magnify * (width - (24/3))/2;
l = (8/3) * magnify;
w = (24/3) * magnify;
rectangle('Position',[x y l w], 'EdgeColor', color, 'LineWidth',lineWidth);

% Plot Semi-Circle
% Left
theta1 = (pi - (acos(6/10)*2))/2;
theta2 = pi - theta1;
t = linspace(theta1,theta2,100);
r = 10 * magnify;

x = r * sin(t);
y = r * cos(t);

x = x + (12 * magnify) + border;
y = y + (width/2) * magnify + border;

plot(x, y, color, 'LineWidth',lineWidth)
axis equal

% Right
theta1 = (pi - (acos(6/10)*2))/2;
theta2 = pi - theta1;

t = linspace(theta1,theta2,100);
r = 10 * magnify;

x = r * sin(t);
y = r * cos(t);

exMax = max(x);
x = (max(x) - min(x)) - (x - min(x));
x = x - min(x);
x = x - exMax;

x = x + ((length - 12) * magnify) + border;
y = y + (width/2) * magnify + border;

plot(x, y, color, 'LineWidth',lineWidth)
axis equal

% Plot Cross
% Left
x = border + (12 * magnify);
y = (width/2) * magnify + border;
plot(x,y,strcat(color,'x'), 'LineWidth',lineWidth);

% Right
x = border + ((length - 12) * magnify);
y = (width/2) * magnify + border;
plot(x,y,strcat(color,'x'), 'LineWidth',lineWidth);

% Cross Field Lines
% for i=1:19
%     plot([(border+(6*magnify*i)),(border+(6*magnify*i))],[border,(border + (width * magnify))], strcat(color,'--'));
% end

% Make Center Line
plot([(border+((length/2)*magnify)),(border+((length/2)*magnify))],[border,(border + (width * magnify))], color, 'LineWidth',lineWidth);

% Make Circle at Center of Pitch
rectangle('Position', [(border + (((length-20)/2) * magnify)) (border + (((width-20)/2) * magnify)) (20 * magnify) (20 * magnify)],'Curvature',[1 1],'EdgeColor', color, 'LineWidth',lineWidth)

% Save Football Field Model
%

