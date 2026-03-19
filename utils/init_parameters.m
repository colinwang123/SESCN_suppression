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

function params = init_parameters()
% INIT_PARAMETERS Initialize SESCN modeling parameters

params.nu = 900;          % SESCN propagation velocity
params.tau = 0.093;       % Time interval between SESCNs
params.fc = 50;           % Central frequency of the Ricker wavelet (Hz)

params.dx = 10;           % Trace spacing (m)
params.dt = 0.001;        % Sampling interval (s)
params.tmax = 2.08;       % Maximum recording time (s)

params.receiver_num = 200;    % Number of receivers for SESCN
params.start_trace = 200;     % Starting trace index for local embedding

params.x0 = 100 * params.dx;  % Source x-coordinate (m)
params.y0 = 50 * params.dx;   % Source y-coordinate (m)

params.move1 = -100;      % Negative shift of the single Ricker wavelet
params.move2 = 200;       % Positive shift of the single Ricker wavelet

end