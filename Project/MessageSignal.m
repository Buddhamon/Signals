function [t,y] = MessageSignal()

Fs = 44100; % Number of sampling points ?

samples = [1,20*Fs]; % (Sampling points) * (number of seconds you'd like
                     % to observe the audio file)
                     
[y, Fs] = audioread('AudioFile.wav',samples);

% sound(y, Fs) % This line plays the audio file

t = 0:1/Fs:(length(y) - 1)/Fs; % Time domain derived from sampling points

end
