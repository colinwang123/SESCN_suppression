%% ========================================================================
%  step4-Visualization and show our final results
%
% Author: Kunxi Wang
% Affiliation: China University of Petroleum (Beijing)
% Date: 2026-03-18
% ========================================================================
clear; clc; close all;
addpath("./utils");

%% Load data
[raw_data, true_signal, true_noise, dt, dx] = load_data();

%% Initialize parameters
params = init_parameters();

%% Forward modeling
nt = size(raw_data, 1);
[synthetic_data, synthetic_flat] = forward_modeling(nt, params);

%% Amplitude attenuation as supplemented based on actual circumstances
synthetic_data = apply_attenuation(synthetic_data, params);

%% Flatten events using HNMC
[data_shifted, raw_shifted, shift_trace] = ...
    flatten_events(synthetic_data, synthetic_flat, raw_data, params);

%% Load UDNN prediction
load('./saved_result_dataset/result.mat');   % variable: result
noise_pred = result;

signal_flat = raw_shifted - noise_pred;

%% Inverse transform
[noise_inv, signal_inv] = ...
    inverse_transform(noise_pred, signal_flat, shift_trace, nt);

%% Replace into full data
final_signal = raw_data;
trace_start = params.start_trace;
trace_end = trace_start + params.receiver_num - 1;
final_signal(:, trace_start:trace_end) = signal_inv;

%% Evaluation
[error_signal, estimated_noise, suppression_ratio] = ...
    evaluate_results(raw_data, final_signal, true_signal, true_noise);

disp(['Suppression ratio = ', num2str(suppression_ratio)]);

%% ====================== Visualization ======================

[ntwkx, nxwkx] = size(raw_data);

caxis_range = [-1 1];
lw1 = 2;

% 1. Original data
plot_original_data(raw_data, ntwkx, nxwkx, dt, lw1, caxis_range);
exportgraphics(gcf, './figures/Figure3_in_the_reference_paper.png', 'Resolution', 300);

% 2. UDNN local results (hyperbolic domain)
plot_udnn_results(noise_inv, signal_inv, ntwkx, dt, lw1, caxis_range);
exportgraphics(gcf, './figures/Figure5_in_the_reference_paper.png', 'Resolution', 300);

% 3. Final comparison (full wavefield)
plot_final_results(estimated_noise, final_signal, error_signal, ...
    ntwkx, nxwkx, dt, lw1, caxis_range);
exportgraphics(gcf, './figures/Figure6_in_the_reference_paper.png', 'Resolution', 300);


