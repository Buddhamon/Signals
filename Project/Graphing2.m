function [] = Graphing2(t, y)

figure;
hold on;

Fs = 10000;                    % Sampling frequency
T = 1/Fs;                     % Sampling period
L = length(y);                     % Length of signal
%  t = (0:L-1)*T;                % Time vector

subplot(2,1,1) % let's you put multiple plots on the same figure
plot(t,y);
title('signal y(t) in the time domain');
xlabel(sprintf('t (sec)'));
ylabel('y(t)');

n = 2^nextpow2(L);

dim = 2;

Y = fft(y,n,dim);

P2 = abs(Y/L);
P1 = P2(:,1:n/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);

subplot(2,1,2)
plot(0:(Fs/n):(Fs/2-Fs/n),P1(1:n/2))
title('signal Y(w) in the time domain');

hold off;


% % \/ \/ \/ \/ \/ Hello World's Code \/ \/ \/ \/ \/ 
% % This needs to be updated later, move this code into a function 
% %   maybe to Grapbing(t,y)
% 
% fsampling = 10000; %sampling rate
% 
% L = length(y);
% Y = fft(y);
% Y = Y/L;
% omega = ((0:length(Y)-1)/length(Y))*fsampling; %define frequency axis
% 
% figure;
% hold on;
% subplot(2,1,1) % let's you put multiple plots on the same figure
% plot(t,y);
% title('signal y(t) in the time domain');
% xlabel(sprintf('t (sec)'));
% ylabel('y(t)');
% 
% subplot(2,1,2)
% plot(omega, abs(Y));
% title('signal Y(\omega), magnitude')
% xlabel(sprintf('t, sampled at the rate of %d', fsampling));
% ylabel('Y(\omega)');
% % axis([0 length(Y) 0 max(Y)])

% /\ /\ /\ /\ /\ Hello World's Code /\ /\ /\ /\ /\

end

