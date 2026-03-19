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

function [data_shifted, raw_shifted, shift_trace] = ...
    flatten_events(synthetic_data, synthetic_flat, raw_data, params)
% FLATTEN_EVENTS Convert hyperbolic events into horizontal events
%
% Inputs:
%   synthetic_data - Simulated hyperbolic events after attenuation
%   synthetic_flat - Auxiliary simulated data for shift estimation
%   raw_data       - Original full-wavefield data
%   params         - Parameter structure
%
% Outputs:
%   data_shifted - Flattened synthetic data
%   raw_shifted  - Flattened raw data in the same local window
%   shift_trace  - Sample shifts for each trace

nt = size(raw_data, 1);
n_receiver = params.receiver_num;

temp = abs(synthetic_flat * 1e12);
shift_trace = zeros(n_receiver, 1);

% Estimate the vertical shift of each trace
for i = 1:n_receiver
    for j = 1:nt
        if temp(j,i) >= 1
            shift_trace(i) = j;
            break;
        end
    end
end

% Normalize shift values
shift_trace = shift_trace - min(shift_trace);
max_shift = max(shift_trace);
shift_trace = 1 + max_shift - shift_trace;

% Allocate flattened matrices
data_shifted = zeros(nt + max_shift, n_receiver);
raw_shifted  = zeros(nt + max_shift, n_receiver);

% Apply trace-by-trace shifting
for i = 1:n_receiver
    idx_shift = shift_trace(i):(shift_trace(i) + nt - 1);
    idx_raw = params.start_trace + i - 1;

    data_shifted(idx_shift, i) = synthetic_data(:,i);
    raw_shifted(idx_shift, i)  = raw_data(:, idx_raw);
end

end