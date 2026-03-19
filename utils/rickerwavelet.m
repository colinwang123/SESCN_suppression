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


% Return the Ricker wavelet for a given time vector and central frequency
% function ricker_wavelet = rickerwavelet(t, f)
% RICKERWAVELET Generate a Ricker wavelet
% Inputs:
%   t - Time vector
%   f - Central frequency
%
% Output:
%   ricker_wavelet - Ricker wavelet

function ricker_wavelet = rickerwavelet(t, f)
    
    ricker_wavelet = (1 - 2 * (pi * f * t).^2) .* exp(-(pi * f * t).^2);
end