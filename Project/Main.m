clc;
clear;
close all;
%% Flow diagram
%
% msg -> MODULATOR -> TRANSMISSION CHANNEL -> DEMODULATOR -> LPF -> ???
%           ^                                     ^
%           |                                     |
%       cos(at)                              cos(bt+phi)
%% Message Signal
messageType = 6; % determines what signal to retrieve from MessageSignal
fs = 5000; % sampling frequency of the signal from MessageSignal
cf = 1000; % carrier frequency for the modulation and demodulation
[t,y,fs] = MessageSignal(messageType, fs); % Gets t and y(t) for a message given an index and sampling frequency
Graphing(t, y, fs);
% sound(y, fs);
    % RECORDED VOICE SOMETIMES GENERATES AN ERROR 
%% Transmitter
mod = Modulator(t, y, cf); 
Graphing(t, mod, fs);
% sound(mod);
%% Channel

%% Receiver
demod = Demodulator(t, mod, cf); 
Graphing(t, demod, fs);
Hd = LowpassFilter(fs, 100, 200);
% freqz(Hd);
clean = filter(Hd,demod);
Graphing(t, clean, fs);
% sound(clean);
%% Final Message







