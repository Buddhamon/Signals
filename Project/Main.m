clc;
clear;
close all;
%% Flow diagram

% msg -> MODULATOR -> TRANSMISSION CHANNEL -> DEMODULATOR -> LPF -> ???
%           ^                                     ^
%           |                                     |
%       sin(at)                              sin(bt+phi)

%% Message Signal

messageType = 7; % determines what signal to retrieve from MessageSignal
fs = 10000; % sampling frequency of the signal from MessageSignal
carrierFrequency = 2000; % carrier frequency for the modulation and demodulation
                        % carrier frequency shouldnt be more than 1/4 the sampling frequency

[t,y,fs] = MessageSignal(messageType, fs); % Gets t and y(t) for a message given an index and sampling frequency
length(y)
length(t)
Graphing(t, y, fs, 'Original Signal');
sound(y, fs);
pause(3)

%% Transmitter

modulation = Transmitter(t, y, carrierFrequency); 

Graphing(t, modulation, fs, 'Modulated Signal');
% sound(mod, fs);

%% Channel

noiseStrength = carrierFrequency/10;
noiseySignal = t;
for i = 1:length(noiseySignal)
    noiseySignal(i) = rand*noiseStrength;
end

Graphing(t, noiseySignal, fs, 'Noisey Signal');

channel = Channel(t, modulation, noiseySignal); 

Graphing(t, channel, fs, 'Channel Signal');

%% Receiver

demodulation = Reciever(t, channel, fs, carrierFrequency, noiseySignal); 
Graphing(t, demodulation, fs, 'Demodulated Signal');

% sound(demod, fs);

% freqz(Hd);

% Remove Carrier Frequency with a low pass filter
cf = carrierFrequency;
[filtered] = FilterFunction(true, cf, demodulation, fs);

Graphing(t, filtered, fs, 'Filtered Signal');
sound(filtered, fs);
% pause(3);


%% Final Message







