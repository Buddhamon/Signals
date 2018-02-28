%EE 2170 Signals & Systems

clear;
clc;
close all;

t = (-4*pi):0.01:(4*pi);
y_1 = cos(t); 
y_2 = cos(t.*2);
y_3 = y_1 .* y_2;

figure; 
hold on;

subplot(3,1,1);
plot(t,y_1, 'r', 'LineWidth', 1);
xlabel('t');
ylabel('V(t)');
title('Cos(t)');

subplot(3,1,2);
plot(t,y_2, 'b', 'LineWidth', 1);
xlabel('t');
ylabel('V(t)');
title('Cos(2t)');

subplot(3,1,3);
plot(t,y_3, 'g', 'LineWidth', 1);
xlabel('t');
ylabel('V(t)');
title('Transmitter');

hold off;

figure;
filename = 'RecordedVoice.wav';
[y,freq] = audioread(filename);
sound(y, freq);
t = 0:1/freq:(length(y) - 1)/freq;
plot(t,y);