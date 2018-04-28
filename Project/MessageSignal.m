% Returns a signal given a specified message type
    % input
    %   messageType - index of user specified message
    %   samplingFrequency - sampling frequency of the signal
    % output
    %   t - time vector that is 10 seconds long
    %   y - y(t)
    %   fs - sampling frequency of the signal (in the event that the sampling frequency
    %           was altered)
function [t, y, fs] = MessageSignal(messageType, samplingFrequency)

fs = samplingFrequency; % 
duration = 3; % duration of signal in seconds

t = 0:1/fs:duration; 

sign = rand; % determines sign of signal
if(sign > 0.5)
    sign = -1;
else
    sign = 1;
end

if(messageType == 1) % Sine
    freq = 100*rand;
    omega = 2 * pi * freq;
    amplitude = 100 * rand;
    y = sign * amplitude * sin(omega*t);
elseif(messageType == 2) % Cosine
    freq = 100*rand;
    omega = 2 * pi * freq;
    amplitude = 100 * rand;
    y = sign * amplitude * cos(omega*t);
    
elseif(messageType == 3) % Square Wave
    freq = 30*rand;
    omega = 2 * pi * freq;
    amplitude = 100 * rand;
    y = sign * amplitude * square(omega*t);
    
elseif(messageType == 4) % Triagle Wave
    freq = 30*rand;
    omega = 2 * pi * freq;
    amplitude = 100 * rand;
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
    type = 2*rand;
    type = floor(type);
    if(type == 1) % Audio File
        [y, fs] = audioread('AudioFile.wav');
        t = 0:1/fs:duration;
        samples = [1, (duration*fs)+1];
        [y, fs] = audioread('AudioFile.wav',samples);
        y = y(:,1);
        y = y';
    else % Recorded Voice
        [y, fs] = audioread('RecordedVoice.wav');
        t = 0:1/fs:duration;
        samples = [1, (duration*fs)+1];
        [y, fs] = audioread('RecordedVoice.wav',samples);
        y = y(:,1);
        y = y';
    end
end
end



