function [mod] = Modulator(t,y, cf)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

carrier = sin((cf*2*pi*t));

mod = carrier.*y;

end

