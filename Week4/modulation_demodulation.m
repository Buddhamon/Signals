% Why modulation/demodulation?

% Antenna must be roughly 1/4 wavelength, so higher frequencies allow
% smaller antenna.
% Breaking up the RF spectrum across different providers


%% Flow diagram
% msg -> MODULATOR -> TRANSMISSION CHANNEL -> DEMODULATOR -> LPF -> ???
%           ^                                     ^
%           |                                     |
%       cos(at)                              cos(bt+phi)

% Model system with a = b and phi = 0
% Plot in both time domain and frequency domain.

fsampling = 1000;
t = 0:1/fsampling:4;
msg = cos(3*2*pi*t) + cos(5*2*pi*t)+cos(7*2*pi*t);
a = 60;
b = 60;

carrier = cos(a*2*pi*t);
modulated = carrier.*msg;
demodulated = modulated.*cos(b*2*pi*t);

Hd = lowpass(); 
freqz(Hd);
clean = filter(Hd,demodulated);

fig = figure
set(fig, 'Position', [0 0 1366 768]); % sets size of figure; 1366x768
set(fig, 'Name', 'Time Domain');

subplot(4,1,1);
hold on;
plot(t, msg);
title('Signal');
xlabel('t');
ylabel('Signal (V)');
hold off;


subplot(4,1,2);
hold on;
plot(t, modulated, 'DisplayName', 'Modulated Signal');
plot(t, msg, 'DisplayName', 'Signal');
legend('show');
title('Modulated Signal');
hold off;

subplot(4,1,3);
hold on;
plot(t, demodulated, 'DisplayName', 'Demodulated Signal');
plot(t, msg, 'DisplayName', 'Signal');
legend('show');
title('Demodulated Signal');
hold off;

subplot(4,1,4);
hold on;
plot(t, clean, 'DisplayName', 'Filtered Signal');
plot(t, msg, 'DisplayName', 'Signal');
legend('show');
title('Output Signal');
hold off;

% Recover the original message...

%% Frequency Domain
fig = figure
set(fig, 'Position', [0 0 1366 768]); % sets size of figure; 1366x768
set(fig, 'Name', 'Frequency Domain');

subplot(4,1,1)
MSG = fft(msg);
omega = ((0:length(MSG) - 1)/length(MSG))*fsampling;
hold on
plot(omega, abs(MSG));
[pks, locs] = findpeaks(abs(MSG), omega);
ylimits = get(gca, 'ylim');
for p=locs
   line([p p], ylimits, 'Color', [0.7 0.7 0.7], 'Linestyle', ':');
end
xlim([0,150]);
xticks(unique([locs get(gca, 'Xtick')]));
xtickformat('%,.1f');
xtickangle(90)
title('Signal(\omega)');
hold off

subplot(4,1,2);
hold on
Modulated = fft(modulated);
plot(omega, abs(Modulated));
[pks, locs] = findpeaks(abs(Modulated), omega);
ylimits = get(gca, 'ylim');
for p=locs
   line([p p], ylimits, 'Color', [0.7 0.7 0.7], 'Linestyle', ':');
end
xlim([0,150]);
xticks(unique([a locs get(gca, 'Xtick')]));
xtickformat('%,.1f');
xtickangle(90)
title('Modulated Signal');
hold off

subplot(4,1,3);
hold on
Demodulated = fft(demodulated);
plot(omega, abs(Demodulated));
[pks, locs] = findpeaks(abs(Demodulated), omega);
ylimits = get(gca, 'ylim');
for p=locs
   line([p p], ylimits, 'Color', [0.7 0.7 0.7], 'Linestyle', ':');
end
xlim([0,150]);
xticks(unique([a a+ b locs get(gca, 'Xtick')]));
xtickformat('%,.1f');
xtickangle(90)
title('Demodulated Signal')
hold off

subplot(4,1,4);
% Plot the filtered wave here...
hold on
Clean = fft(clean);
plot(omega, abs(Clean));
[pks, locs] = findpeaks(abs(Clean), omega);
ylimits = get(gca, 'ylim');
for p=locs
   line([p p], ylimits, 'Color', [0.7 0.7 0.7], 'Linestyle', ':');
end
xlim([0,150]);
xticks(unique([a a+ b locs get(gca, 'Xtick')]));
xtickformat('%,.1f');
xtickangle(90)
title('Clean Signal')
hold off


% This is the ideal case, but not easy to sync up between two distant locations
% What happens if there's a phase shift?

% Model system with a = b but phi != 0. What happens when
% phi = pi/2?

% Bonus: It's not always easy to predict how much delay you'll see (ie, not always possible to
% know what phi is). Given that $\cos^2\theta + \sin^2\theta = 1$, how can you always be sure you can recover the 
% original signal?

% Model system with a != b. What is the minimum tau = abs(a-b)
% s.t. you can send two signals w/o interference?

% Bonus: Look at the system with a = b and phi = pi/2 mathematically. 
% ie - what do you get when you multiply cos(at)cos(at + pi/2)?