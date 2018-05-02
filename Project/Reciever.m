function [demodulation] = Reciever(t, channel, fs, cf, noiseySignal)

% noiseStrength = cf/10;

% % ************** Filtering Noise **************
% 
% CHANNELTEMP = fft(channel);
% CHANNELTEMP = abs(CHANNELTEMP)/length(t);
% for i = 1:length(CHANNELTEMP)
%     if(CHANNELTEMP(i) < 5)
%         CHANNELTEMP(i) = 0;
%     end
% end
% 
% % Rebuilding Channel
% 
% CHANNEL = fft(channel);
% 
% for i = 1:length(CHANNEL)
%     if(CHANNELTEMP(i) == 0)
%         CHANNEL(i) = 0;
%     end
% end
% 
% channel = ifft(CHANNEL);
% 
% channel = FilterFunction(false, cf, channel, fs);
% 
% % ************** Filtering Noise **************

% ************** Filtering Noise #2 **************

CHANNEL = fft(channel);
NOISE = fft(noiseySignal);
channel = ifft(CHANNEL - NOISE);

% ************** Filtering Noise #2 **************

carrier = sin((cf*2*pi*t));

demodulation = channel.*carrier;

end

