clc;
clear;
close all;
%% Flow diagram
% msg -> MODULATOR -> TRANSMISSION CHANNEL -> DEMODULATOR -> LPF -> ???
%           ^                                     ^
%           |                                     |
%       cos(at)                              cos(bt+phi)
%%

% Message Signal
[t,y] = MessageSignal(6);
% Graphing(t,y);


% \/ \/ \/ \/ \/ Hello World's Code \/ \/ \/ \/ \/

x = y;
fsampling = 10000; %sampling rate

L = length(x);
X = fft(x);
X = X/L;
omega = ((0:length(X)-1)/length(X))*fsampling; %define frequency axis

figure;
hold on;
subplot(2,1,1) % let's you put multiple plots on the same figure
plot(t,x);
title('signal x(t) in the time domain');
xlabel(sprintf('t, sampled at the rate of %d', fsampling));
ylabel('y(t)');

subplot(2,1,2)
plot(omega, abs(X));
title('signal X(\omega), magnitude')




