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
duration = 3; % duration of signal in seconds, maximum of 26

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
    
elseif(messageType == 4) % Triangle Wave
    freq = 100*rand;
    omega = 2 * pi * freq;
    amplitude = 100 * rand;
    y = sign * amplitude * sawtooth(omega*t);
    
elseif(messageType == 5) % Pulse Trains
    pulsePeriods = 0 : .01 : 50;   
    pulseWidth = 0.001;
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
    random = ceil(rand*(27-duration));
    if(type == 1) % Audio File
        [y, fs] = audioread('AudioFile.wav');
        t = 0:1/fs:duration;
        samples = [fs*random, (duration*fs)+(random*fs)];
        [y, fs] = audioread('AudioFile.wav',samples);
        y = y(:,1);
        y = y';
    else % Recorded Voice
        [y, fs] = audioread('RecordedVoice.wav');
        t = 0:1/fs:duration;
        samples = [fs*random, (duration*fs)+(random*fs)];
        [y, fs] = audioread('RecordedVoice.wav',samples);
        y = y(:,1);
        y = y';
    end
elseif(messageType == 7)
%     t = 0:1/fs:duration; 
    amplitude = 5;
    numberOfPulses = 50;
    time_sections = length(t)/numberOfPulses;
    y = [0:1:length(t)-1];
    for i = 1:length(y)
        y(i) = 0;
    end
    
    for i = 1:numberOfPulses-1
        random = floor(2*rand);
        if(random)
            y_k = 0;
        else
            y_k = amplitude;
        end
        for k = floor(i*time_sections):floor((i+1)*time_sections)
            y(k) = y_k;
        end
    end
end
end