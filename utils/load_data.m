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

function [raw_data, true_signal, true_noise, dt, dx] = load_data()
% LOAD_DATA Load seismic datasets

load('./original_dataset/full_data.mat');
raw_data = all_data;

load('./original_dataset/clean_data.mat');
true_signal = d3;

load('./original_dataset/only_outsied_data.mat');
true_noise = outside_data;

dt = 0.001;   % Sampling interval
dx = 10;      % Trace spacing

end