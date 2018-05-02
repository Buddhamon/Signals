function [] = Graphing(t, y, fs, figureName)
figure('Name', figureName);
hold on;

%% First Graph, Time
subplot(2,1,1) % let's you put multiple plots on the same figure
plot(t,y);
title('signal y(t) in the time domain');
xlabel(sprintf('t (sec)'));
ylabel('y(t)');

%% Making Second Graph

N = length(t);
Y = fftshift(fft(y));  
dF = fs/N;                          % hertz
omega = -fs/2:dF:fs/2-dF;           % hertz
half_omega = omega(floor(length(omega)/2):floor(length(omega)));
temp = (abs(Y)/N);
half_Y = temp(floor(length(temp)/2):floor(length(temp)));

%% Second Graph, Frequency
subplot(2,1,2)
% plot(omega, Y)
plot(half_omega, half_Y)
title('signal Y(\omega) in the frequency domain')
xlabel(sprintf('t, sampled at the rate of %d', fs));
ylabel('Y(\omega)');
% axis([0 length(Y) 0 max(Y)])

hold off;

end

