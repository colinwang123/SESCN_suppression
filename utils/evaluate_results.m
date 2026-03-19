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

function [error_signal, estimated_noise, ratio] = ...
    evaluate_results(raw_data, final_signal, true_signal, true_noise)
% EVALUATE_RESULTS Compute error and suppression ratio

error_signal = true_signal - final_signal;
estimated_noise = raw_data - final_signal;

num = sum(sum(abs(estimated_noise - true_noise)));
den = sum(sum(abs(true_noise)));

ratio = 1 - num / den;

end