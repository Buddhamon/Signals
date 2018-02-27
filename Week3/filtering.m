clc;
clear;
close all;

fsampling = 100;
t = 0:1/fsampling:2*pi;
x = sin(2*pi*t) + sin(4*pi*t);


Hd = lowpass1(); % call my filtering function
freqz(Hd)

figure
y = filter(Hd,x);
X = fft(y);
hold on

subplot(3,1,1);
plot(t, y, 'r', 'DisplayName', 'Filtered');
legend('show');

subplot(3,1,2);
plot(t, x, 'g', 'DisplayName', 'Original');
legend('show');

subplot(3,1,3);
  hold on;
    plot(t, abs(X), 'DisplayName', 'Noisy Data', 'Color', [0.5 0.5 0.5], 'LineStyle', ':');
    hold off
    xlabel('\omega');
    ylabel('X(\omega)');
    title(sprintf('Medfilt1(Order=%d) vs Clean Signal (Frequency Domain)', order));
    legend('show')
