clc;
clear;
close all;
%% Flow diagram
%
% msg -> MODULATOR -> TRANSMISSION CHANNEL -> DEMODULATOR -> LPF -> ???
%           ^                                     ^
%           |                                     |
%       cos(at)                              cos(bt+phi)
%%
%
% Message Signal
[t,y] = MessageSignal(6); % Gets t and y(t) for a message given an index
Graphing(t,y);

