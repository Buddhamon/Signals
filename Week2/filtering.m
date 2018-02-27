%% Filtering in matlab.
clc;
close all;
clear;

%% Frequency Space -> Time Space

% Last time, we took time signals and moved them to the frequency space
% Today, let's go the other way around.

% Lets say I have a signal composed of two sinusoids. How can I separate
% out these two sinusoids from each other?

% We'll plot the signal first, just so we can see what's going on

% set up my time vector
fsampling = 100;
t = 0:1/fsampling:2*pi;

f1 = 2;
f2 = 5;
x1 = sin(2*pi*f1*t);
x2 = sin(2*pi*f2*t);
x = x1 + x2;

fig = figure;
set(fig, 'Position', [100 100 1366 768]); % sets size of figure; 1366x768

subplot(4,1,1);
plot(t, x);
xlim([0,2*pi]);
xticks([0:pi/2:2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
ylim([-2.5,2.5]);
xlabel('t');
ylabel('x(t)');
title('Signal x(t) in the time domain')

% Well, that looks clear as mud.

%% Maybe it'll be clearer in the frequency space?

subplot(4,1,2);

L = length(x);
X = fft(x);
omega = ((0:length(X)-1)/length(X))*fsampling;

plot(omega, abs(X));

% Frequency plot here
% [peaks, locs] = findpeaks(-abs(X), omega);

xlabel('\omega');
ylabel('X(\omega)');
title('Signal X(\omega) in the frequency domain');

%% Filtering

% Well, what if I just cut off the peak I don't want?
% For simplicity, we'll just multiply by a rectangularPulse of the right
% size and shape

subplot(4,1,3);
cutoff = 3.1; %How would you find the right cutoff?

H = rectangularPulse(cutoff, fsampling-cutoff, omega);
filteredX = X.*H;
hold on
yyaxis left;
p1 = plot(omega, H, '--', 'DisplayName', 'Filter');
% Draw vertical lines
line([cutoff cutoff], [-0.5 1.5], 'Color',[0.5 0.5 0.5],'LineStyle','--');
line([fsampling-cutoff fsampling-cutoff], [-0.5,1.5], 'Color',[0.5 0.5 0.5] ,'LineStyle','--');
ylim([0, 1.25]);
xticks([cutoff, fsampling-cutoff]);
xlabel('\omega');
ylabel('X(\omega)');
yyaxis right;
ylabel('X(\omega)');
p2 = plot(omega, abs(filteredX), 'DisplayName', 'New X(\Omega)');
ylim([0 350]);
hold off
legend([p1 p2])
legend('show');
title('Filter and New Signal X(\Omega)')

%% Convert back to time domain.
% use the ifft function -> inverse fourier transform
% How does the ifft differ from fft?
subplot(4,1,4);
filtered_x = ifft(X.*H);
hold on
plot(t, x, 'DisplayName', 'x(t)', 'Color', [0.5 0.5 0.5], 'LineStyle', '--');
plot(t, filtered_x, 'DisplayName', 'Filtered x(t)');
hold off
xlim([0,pi]);
xticks([0:pi/2:2*pi])
xticklabels({'0','0.5\pi','\pi','1.5\pi','2\pi'})
ylim([-2.5,2.5]);
xlabel('t');
ylabel('x(t)');
title('Filtered signal x(t) in Time Domain');
legend('show');

saveas(fig, 'filtering', 'png')

% Your turn: Is this a high-pass filter or a low-pass filter?
% What happens when we alter the other peaks?
% What happens when we alter the phase of the frequency signal without changing the magnitude?
% How would you demostrate a band-pass filter?
% How realistic is this filter? (Take a look at matlab's filter function?)

%% Bonus: Let's introduce an element of noise

% use the function immse to compare the rms difference between two vectors

x_noisy = x1 + x2 + 0.5*randn(size(t));

%% Double Bonus:
% Other ways to get rid of noise?

