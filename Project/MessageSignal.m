% Returns a signal given a specified message type
    % input
    %   messageType - index of user specified message
    % output
    %   t - time vector that is 10 seconds long
    %   y - y(t)
function [t,y] = MessageSignal(messageType)

t = 0:0.01:10; % 1000 points accross 10 seconds
sign = rand; % determines sign of signal
if(sign > 0.5)
    sign = -1;
else
    sign = 1;
end

if(messageType == 1) % Sine
    freq = 2*rand;
    omega = 2 * pi * freq;
    amplitude = 10 * rand;
    y = sign * amplitude * sin(omega*t);
    
elseif(messageType == 2) % Cosine
    freq = 2*rand;
    omega = 2 * pi * freq;
    amplitude = 10 * rand;
    y = sign * amplitude * cos(omega*t);
    
elseif(messageType == 3) % Square Wave
    freq = 2*rand;
    omega = 2 * pi * freq;
    amplitude = 10 * rand;
    y = sign * amplitude * square(omega*t);
    
elseif(messageType == 4) % Triagle Wave
    freq = 2*rand;
    omega = 2 * pi * freq;
    amplitude = 10 * rand;
    y = sign * amplitude * sawtooth(omega*t);
    
elseif(messageType == 5) % Pulse Trains
    pulsePeriods = 0 : 1 : 10;   
    pulseWidth = 0.25;
    pulseType = 3 * rand; % determines what type of pulse
    if(pulseType < 1)
        func = 'gauspuls';
    elseif(pulseType < 2)
        func = 'rectpuls';
    else
        func = 'tripuls';
    end
    y = sign * pulstran(t,pulsePeriods,func,pulseWidth);
    
elseif(messageType == 6) % Audio File
    Fs = 44100;
    type = 2*rand;
    type = floor(type);
    if(type == 1) % Audio File
        timeSegment = (110 * rand) + 11;
        timeSegment = floor(timeSegment);
        samples = [(timeSegment-10)*Fs,(timeSegment)*Fs]; % (Sampling points) * (number of seconds you'd like
                     % to observe the audio file)  
        [y, Fs] = audioread('AudioFile.wav',samples);
        y = y(:, 1);
        t = 0:1/Fs:(length(y) - 1)/Fs; % Time domain derived from sampling points
    else % Recorded Voice
        timeSegment = (18 * rand) + 11;
        timeSegment = floor(timeSegment);
        samples = [(timeSegment-10)*Fs,(timeSegment)*Fs]; % (Sampling points) * (number of seconds you'd like
                     % to observe the audio file) 
        [y, Fs] = audioread('RecordedVoice.wav',samples);
        y = y(:, 1);
        t = 0:1/Fs:(length(y) - 1)/Fs; % Time domain derived from sampling points
    end
%     sound(y, Fs) % This line plays the audio file
end
end



