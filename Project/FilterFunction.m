function [filtered] = FilterFunction(filterType, cf, channel, fs)

% filterType - If true, low pass, if false, high pass
% cf - cut off filter
% channel - the channel message
% fs - sampling frequency

if(filterType) % if true, do a low pass filter
    [b,a] = butter(20, (cf*1.5)/(fs/2), 'low');
    
else % if false, do a low pass filter
    [b,a] = butter(20, (cf*0.5)/(fs/2), 'high');
    
end

filtered = filter(b, a, channel);

end