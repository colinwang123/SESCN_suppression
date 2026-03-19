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

function [synthetic_data, synthetic_flat] = forward_modeling(nt, params)
% FORWARD_MODELING Generate synthetic external noise data
%
% Inputs:
%   nt     - Number of time samples in the raw data
%   params - Parameter structure
%
% Outputs:
%   synthetic_data - Simulated hyperbolic events
%   synthetic_flat - Simulated events used for flattening reference

t = 0:params.dt:params.tmax;

synthetic_data = zeros(length(t), params.receiver_num);
synthetic_flat = zeros(length(t), params.receiver_num);

for i = 1:params.receiver_num

    xr = i * params.dx;   % Receiver x-coordinate
    yr = 0;               % Receiver y-coordinate

    synthetic_data(:,i) = simulate_periodic_SESCN( ...
        xr, yr, t, ...
        params.nu, params.tau, params.fc, ...
        params.x0, params.y0, ...
        params.move1, params.move2);

    synthetic_flat(:,i) = simulate_periodic_SESCN( ...
        xr, yr, t, ...
        params.nu, params.tau, params.fc, ...
        params.x0, params.y0, ...
        0, params.move2);
end

synthetic_data = synthetic_data(1:nt,:);
synthetic_flat = synthetic_flat(1:nt,:);

end