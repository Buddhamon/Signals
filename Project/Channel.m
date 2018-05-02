function [channel] = Channel(t, modulation, noise)

% t - If true, low pass, if false, high pass
% modulation - the modulated message
% noisey Signa

channel = modulation + noise;
% channel = modulation;

end