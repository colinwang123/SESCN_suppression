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

function [data_inv, ref_inv] = inverse_transform(data_flat, ref_flat, shift_trace, nt)
% INVERSE_TRANSFORM Convert flattened events back to hyperbolic events
%
% Inputs:
%   data_flat   - Flattened data
%   ref_flat    - Flattened reference data
%   shift_trace - Sample shifts for each trace
%   nt          - Number of time samples in the original data
%
% Outputs:
%   data_inv - Inverse-transformed data
%   ref_inv  - Inverse-transformed reference data

[~, n_receiver] = size(data_flat);

data_inv = zeros(nt, n_receiver);
ref_inv  = zeros(nt, n_receiver);

for i = 1:n_receiver
    idx = shift_trace(i):(shift_trace(i) + nt - 1);

    data_inv(:,i) = data_flat(idx,i);
    ref_inv(:,i)  = ref_flat(idx,i);
end

end