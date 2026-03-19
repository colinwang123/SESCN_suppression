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


% Generate a periodically repeated SESCN


function result = simulate_periodic_SESCN(x_r, y_r, t, nu, tau,f_c,x_0,y_0,move1,move2)

% YOURFORMULA Simulate periodic external noise using shifted Ricker wavelets
%
% Inputs:
%   x_r, y_r - Receiver coordinates (m)
%   t        - Time vector (s)
%   nu       - Propagation velocity (m/s)
%   tau      - Time interval between adjacent wavelets (s)
%   f_c      - Central frequency of the Ricker wavelet (Hz)
%   x_0, y_0 - Source coordinates (m)
%   move1    - Minimum shift index
%   move2    - Maximum shift index
%
% Output:
%   result   - Simulated SESCN waveform at the receiver position


    % Source coordinates in meters
    x_0=x_0+0;  
    y_0=y_0+0;  

    % Compute the distance between the receiver and the source
    d = sqrt((x_r - x_0)^2 + (y_r - y_0)^2);

    % Define the waveform function using the Ricker wavelet
    w = @(t) rickerwavelet(t, f_c);

    % Initialize the output waveform
    result = zeros(size(t)); 
    
    % Superpose multiple time-shifted Ricker wavelets
    for n = move1:move2  
        shifted_t = t - n * tau - d / nu;
        result = result + w(shifted_t);
    end
    
    % Apply geometric amplitude decay
    result = result /(d*d);
end



