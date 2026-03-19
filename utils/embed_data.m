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

function embedded = embed_data(raw, local, params)
% Embed local data into full seismic section

embedded = zeros(size(raw));

idx1 = params.start_trace;
idx2 = idx1 + params.receiver_num - 1;

embedded(:, idx1:idx2) = local;

end