function [demod] = Demodulator(t,mod,cf)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

carrier = sin((cf*2*pi*t));

demod = mod.*carrier;

end

