%% Plotting Sierpinski's Triangle

% animated example of pretty things you can do with matlab.
% follows algorithm here: http://math.bu.edu/DYSYS/arcadia/sect2.html

close;
clear all;

fig = figure; % acquire figure handle

set(fig, 'Name', 'Sierpinski''s Triangle'); % change title text
set(fig, 'Position', [200 0 1000 800]); % sets size of figure

% initial point
x = 0;
y = 0;

% in order to color in the different points different colors, use
% three seperate animated lines
r = animatedline(x,y,'LineStyle','none','Marker','.', 'Color', 'r');
g = animatedline(0.5,sqrt(3)/2,'LineStyle', 'none', 'Marker', '.', 'Color', 'g');
b = animatedline(1,0, 'Linestyle', 'none', 'Marker', '.', 'Color', 'b');

% highlight the point last added with a little cross.
last = animatedline(x,y,'LineStyle', 'none', 'Marker', '+', 'MaximumNumPoints', 1);

%plot metadata
title('Sierpinski''s Triangle')
set(gca, 'xtick', [])
set(gca, 'ytick', [])
axis([0,1,0, 1])

% and begin!
for k = 1:10000
    c = randi([0 2]);
    switch c
        case 0
            x = 0.5*x;
            y = 0.5*y;
            addpoints(r, x, y);
        case 1
            x = 0.5*x + 0.25;
            y = 0.5*y + sqrt(3)/4;
            addpoints(g, x, y);
        case 2
            x = 0.5*x + 0.5;
            y = 0.5*y;
            addpoints(b, x, y);
    end
    addpoints(last, x, y)
    drawnow
end

clearpoints(last)

% draw in some lines for clarity.
hold on
plot([0 0.5 1 0], [0 sqrt(3)/2 0 0], 'Color', 'black');
plot([0.25 0.5 0.75 0.25], [sqrt(3)/4 0 sqrt(3)/4 sqrt(3)/4], 'Color', 'black');
hold off
