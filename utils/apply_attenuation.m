%% ========================================================================
% subcode for suppression of seismic external source coherent noise
%
% Author: Kunxi Wang
% Affiliation: China University of Petroleum (Beijing)
% Date: 2026-03-18
%
% Reference:
%  Unsupervised learning for the suppression of seismic external source
%  coherent noise, Geophysics, by Kunxi Wang, Ying Rao, Tianyue Hu, and Chunming Wang
% ========================================================================

function data_out = apply_attenuation(data_in, params)
% APPLY_ATTENUATION Apply lateral edge attenuation
%
% Inputs:
%   data_in - Input local seismic data
%   params  - Parameter structure
%
% Output:
%   data_out - Attenuated data

n = params.receiver_num;

left_weights = linspace(0,1,n/2);
right_weights = linspace(1,0,n/2);

data_out = data_in;

for i = 1:n/2
    data_out(:,i) = data_out(:,i) * left_weights(i);
end

for i = n/2+1:n
    data_out(:,i) = data_out(:,i) * right_weights(i - n/2);
end

end