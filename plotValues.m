function [] = plotValues(length,points,waveform)
%PLOTVALUES plots values of a function along length with number of points

x = linspace(0,length,points);



plot(x,waveform)

end

