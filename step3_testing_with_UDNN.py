#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
step3-Main Testing Script

Author: Kunxi Wang
Affiliation: China University of Petroleum (Beijing)
Date: 2026-03-18


% Reference:
%  Unsupervised learning for the suppression of seismic external source
%  coherent noise, Geophysics, by Kunxi Wang, Ying Rao, Tianyue Hu, and Chunming Wang


Description
-----------
This script performs inference using a trained convolutional neural network.
The seismic data are padded to satisfy the multi-scale downsampling constraint,
normalized into [-1, 1], and reshaped into NCHW format (channels_first).
After prediction, the results are rescaled and cropped back to the original size.
"""

import numpy as np
import scipy.io as scio
import os
from tensorflow.keras.models import load_model
from tensorflow.keras import backend as K

# Enforce channels_first format (NCHW)
K.set_image_data_format('channels_first')


# =============================================================================
# Utility Functions
# =============================================================================

def pad_to_multiple_of_8(data):
    """
    Pad input data so that both dimensions are divisible by 8.

    Parameters
    ----------
    data : ndarray of shape (H, W)

    Returns
    -------
    padded : ndarray
        Padded data
    original_shape : tuple
        Original data size (H, W)
    """
    h, w = data.shape

    new_h = int(np.ceil(h / 8)) * 8
    new_w = int(np.ceil(w / 8)) * 8

    padded = np.zeros((new_h, new_w))
    padded[:h, :w] = data

    return padded, (h, w)


def unpad(data, original_shape):
    """
    Crop padded data back to original size.

    Parameters
    ----------
    data : ndarray
    original_shape : tuple

    Returns
    -------
    cropped : ndarray
    """
    h, w = original_shape
    return data[:h, :w]


def normalize(data):
    """
    Normalize data to the range [-1, 1].

    Parameters
    ----------
    data : ndarray

    Returns
    -------
    normalized : ndarray
    scale : float
    """
    scale = np.max(np.abs(data))
    normalized = data / scale
    return normalized, scale


# =============================================================================
# Main Function
# =============================================================================

def main():
    """Main inference workflow"""

    # -------------------------------------------------------------------------
    # Load seismic data from .mat files
    # -------------------------------------------------------------------------
    label = scio.loadmat('./training_dataset/reference_data.mat')['reference_data']
    data = scio.loadmat('./training_dataset/input_data.mat')['flattened_data']

    # -------------------------------------------------------------------------
    # Padding (to ensure compatibility with downsampling layers)
    # -------------------------------------------------------------------------
    label_pad, original_shape = pad_to_multiple_of_8(label)
    data_pad, _ = pad_to_multiple_of_8(data)

    # -------------------------------------------------------------------------
    # Normalization
    # -------------------------------------------------------------------------
    label_norm, label_scale = normalize(label_pad)
    data_norm, data_scale = normalize(data_pad)

    # -------------------------------------------------------------------------
    # Reshape to NCHW format
    # (batch, channel, height, width)
    # -------------------------------------------------------------------------
    ny, nx = data_norm.shape
    input_data = np.reshape(data_norm, (1, 1, ny, nx))

    # -------------------------------------------------------------------------
    # Load trained CNN model
    # -------------------------------------------------------------------------
    model = load_model('./cnn_parameters/better_model_parameters.h5')

    # -------------------------------------------------------------------------
    # Perform prediction
    # -------------------------------------------------------------------------
    prediction = model.predict(input_data)

    # Remove batch and channel dimensions
    result = prediction[0, 0, :, :]

    # -------------------------------------------------------------------------
    # Rescale to original amplitude
    # -------------------------------------------------------------------------
    result = result * label_scale

    # -------------------------------------------------------------------------
    # Crop back to original size
    # -------------------------------------------------------------------------
    result = unpad(result, original_shape)

    # -------------------------------------------------------------------------
    # Save result
    # -------------------------------------------------------------------------
    os.makedirs('./saved_result_dataset', exist_ok=True)
    np.save('./saved_result_dataset/result.npy', result)
    scio.savemat('./saved_result_dataset/result.mat', {'result':result})
    print("Inference completed successfully.")


# =============================================================================
# Entry Point
# =============================================================================

if __name__ == "__main__":
    main()