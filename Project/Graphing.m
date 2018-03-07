function [] = Graphing(t, y)
% \/ \/ \/ \/ \/ Hello World's Code \/ \/ \/ \/ \/ 
% This needs to be updated later, move this code into a function 
%   maybe to Grapbing(t,y)

fsampling = 10000; %sampling rate

L = length(y);
Y = fft(y);
Y = Y/L;
omega = ((0:length(Y)-1)/length(Y))*fsampling; %define frequency axis

figure;
hold on;
subplot(2,1,1) % let's you put multiple plots on the same figure
plot(t,y);
title('signal y(t) in the time domain');
xlabel(sprintf('t, sampled at the rate of %d', fsampling));
ylabel('y(t)');

subplot(2,1,2)
plot(omega, abs(Y));
title('signal Y(\omega), magnitude')

% /\ /\ /\ /\ /\ Hello World's Code /\ /\ /\ /\ /\

end

