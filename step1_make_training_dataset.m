%% ========================================================================
%  step1: mainly to make training dataset 
%  Seismic Data Simulation and Flattening Workflow
%
% Author: Kunxi Wang
% Affiliation: China University of Petroleum (Beijing)
% Date: 2026-03-18
%
% Reference:
%  Unsupervised learning for the suppression of seismic external source
%  coherent noise, Geophysics, by Kunxi Wang, Ying Rao, Tianyue Hu, and Chunming Wang
% ========================================================================

clear; clc; close all;
addpath("./utils");
%% ====================== Load Data ======================
[raw_data, nt, nx] = load_original_data('./original_dataset/full_data.mat');

params = init_parameters();

%% ====================== Forward Modeling ======================
[synthetic_data, synthetic_flat] = forward_modeling(nt, params);


%% ====================== Embed into Full Section ======================
embedded_data = embed_data(raw_data, synthetic_data, params);


%% ====================== Apply Attenuation ======================
% Amplitude attenuation as supplemented based on actual circumstances
attenuated_data = apply_attenuation(synthetic_data, params);


%% ====================== Flatten Events ======================
[flattened_data, reference_data, shift_samples] = ...
    flatten_events(attenuated_data, synthetic_flat, raw_data, params);


%% ====================== Save Training Dataset ======================
save('./training_dataset/input_data.mat', 'flattened_data');
save('./training_dataset/reference_data.mat', 'reference_data');

disp('The running has ended.');

