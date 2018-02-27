clear;
close all;

%% Modeling transmission channel as LTI system

% using convolutions - conv

fig = figure;
set(fig, 'Position', [0 0 1366 768]); % sets size of figure; 1366x768

fsampling = 100;
t = 0:1/fsampling:8;
x1 = cos(5*2*pi*t);
x2 = cos(16*2*pi*t);
msg = x1 + x2;
fprintf('Length of signal: %d\n', length(t))

subplot(4,1,1);
plot(t, msg);
title('Signal')
ylabel('Signal (V)')
xlabel('t')

subplot(4,1,2);
yyaxis left
MSG = fft(msg);
omega = (0:(length(MSG) - 1))*(fsampling/length(MSG));
plot(omega, abs(MSG))
title('Signal and Filter')
ylabel('Signal')
xlabel('\omega')

yyaxis right
cutoff = 10;
H = 1 - rectangularPulse(cutoff, fsampling - cutoff, omega);
plot(omega, H, ':');
ylim([0, 1.2])
ylabel('Filter')

subplot(4,1,3)
w = 4; %What happens if you adjust the length of t2?
t2 = -w:1/fsampling:w; 
h = (sqrt(pi)/cutoff)*sinc(cutoff*t2);
fprintf('Length of h: %d\n', length(h))
l = floor(length(t2)/2); 
plot(t2, h);
title('Impulse Response');
xlabel('t');

subplot(4,1,4)
convolved = conv(msg, h);
fprintf('Length of convolved signal: %d\n\n', length(convolved))
    %how long is a convolution supposed to be?
filtered = ifft(MSG.*H);
hold on
plot(t, convolved(l + 1:l+length(t)), 'DisplayName', 'Convolution');
plot(t, filtered, 'DisplayName', 'Filtered');
plot(t, x1, '--', 'DisplayName', 'Ideal');
title('Filtered Outputs')
legend('show');
hold off