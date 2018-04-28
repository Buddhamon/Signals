filename1 = 'AudioFile.wav';
filename2 = 'RecordedVoice.wav';
samples1 = [1000,200000];
samples2 = [1000,200000];

clear y Fs
[y,freq] = audioread(filename1,samples1);

t = 0:1/freq:(length(y) - 1)/freq;

[x,freq2] = audioread(filename2,samples2);

A = y(:,end);
msg1 = A';

B = x(:,end);
msg2 = B';

a = 11000;

carrier1 = sin((a*2*pi*t));
carrier2 = cos(a*2*pi*t);

modulated1 = carrier1.*msg1;
modulated2 = carrier2.*msg2;

channel = modulated1+modulated2;

demodulated1 = channel.*sin((a*2*pi*t));
demodulated2 = channel.*cos(a*2*pi*t);
both = channel.*sin((a*2*pi*t)+(pi/4));

Hd = LowpassFilt(); 
freqz(Hd);

clean1 = filter(Hd,demodulated1);
clean2 = filter(Hd,demodulated2);

% sound(clean1, freq);

fig = figure
set(fig, 'Position', [0 0 1366 768]); % sets size of figure; 1366x768
set(fig, 'Name', 'Time Domain');

subplot(3,1,1);
hold on;
plot(t,msg1);
hold off;

subplot(3,1,2);
hold on;
plot(t,channel);
hold off;

subplot(3,1,3);
hold on;
plot(t,demodulated1);
hold off;

fig = figure
set(fig, 'Position', [0 0 1366 768]); % sets size of figure; 1366x768
set(fig, 'Name', 'Frequency Domain');

subplot(4,1,1)
MSG = fft(msg1);
omega = ((0:length(MSG) - 1)/length(MSG))*freq;
hold on
plot(omega, abs(MSG));
hold off

subplot(4,1,2)
MODULATED = fft(modulated1);
omega = ((0:length(MODULATED) - 1)/length(MODULATED))*freq;
hold on
plot(omega, abs(MODULATED));
hold off

subplot(4,1,3)
DEMODULATED = fft(demodulated2);
omega = ((0:length(DEMODULATED) - 1)/length(DEMODULATED))*freq;
hold on
plot(omega, abs(DEMODULATED));
hold off

subplot(4,1,4)
CLEAN = fft(clean1);
omega = ((0:length(CLEAN) - 1)/length(CLEAN))*freq;
hold on
plot(omega, abs(CLEAN));
hold off
