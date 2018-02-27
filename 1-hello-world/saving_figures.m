%%How to save figures

close all;
clear;

fig = figure; %give figure a handle

set(fig, 'Visible', 'off'); % avoids showing the figure
set(fig, 'Name', 'Sine Wave'); % change title text
set(fig, 'Position', [100 100 1366 768]); % sets size of figure; 1366x768

fsampling = 100;
x = 0:1/fsampling:2*pi;
y = sin(x);

plot(x,y);
xlabel('x');
ylabel('sin(x)');
title('Sine Function');

saveas(fig, 'sine.png')
saveas(fig, 'sine.fig')

%can re-open .fig files
openfig('sine.fig', 'new', 'visible'); 