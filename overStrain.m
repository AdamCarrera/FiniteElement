function [isOverStrain] = overStrain(length1,length2)
%OVERSTRAIN Calculate engineering strain, return boolean true if
%   less than 2%

strain = length2 / length1;

if strain < 0.02
    isOverStrain = true;
%     print('engineering strain less than 2%');
else
    isOverStrain = false;
%     print('engineering strain greater than 2%, adjust material values in');
%     print(' assign values');
end

end

