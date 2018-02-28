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
[t, m] = MessageSignal();