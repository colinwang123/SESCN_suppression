#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Main Training Script

Author: Kunxi Wang
Affiliation: China University of Petroleum (Beijing)
Date: 2026-03-18

% Reference:
%  Unsupervised learning for the suppression of seismic external source
%  coherent noise, Geophysics, by Kunxi Wang, Ying Rao, Tianyue Hu, and Chunming Wang

"""

import numpy as np
import scipy.io as scio
import tensorflow as tf
import os
from keras import backend as K 
K.set_image_data_format('channels_first')

from tools.network_structure import build_unet

def pad_to_multiple_of_8(data):
    """
    Pad data to make its size divisible by 8.

    Parameters
    ----------
    data : ndarray (H, W)

    Returns
    -------
    padded_data : ndarray
    original_shape : tuple
    """

    h, w = data.shape

    # 计算padding后的尺寸（向上取整到8的倍数）
    new_h = int(np.ceil(h / 8)) * 8
    new_w = int(np.ceil(w / 8)) * 8

    padded = np.zeros((new_h, new_w))
    padded[:h, :w] = data

    return padded, (h, w)

def load_data():
    """Load and preprocess data"""

    label = scio.loadmat('./training_dataset/reference_data.mat')['reference_data']
    data = scio.loadmat('./training_dataset/input_data.mat')['flattened_data']
   
    
    label_temp, label_shape = pad_to_multiple_of_8(label)
    data_temp, data_shape = pad_to_multiple_of_8(data)



    # Normalization
    label_norm = label_temp / np.max(np.abs(label_temp))
    data_norm = data_temp / np.max(np.abs(data_temp))

    ny, nx = label_norm.shape

    data_norm = np.reshape(data_norm, (1, 1, ny, nx))
    label_norm = np.reshape(label_norm, (1, 1, ny, nx))

    return data_norm, label_norm, ny, nx


def train():
    """Training pipeline"""

    # Load data
    x_train, y_train, ny, nx = load_data()

    # Build model
    model = build_unet((1, ny, nx))

    # Compile
    optimizer = tf.keras.optimizers.Adam(learning_rate=1e-4)
    model.compile(optimizer=optimizer, loss='mae')

    model.summary()

    # Callbacks
    callbacks = [
        tf.keras.callbacks.ModelCheckpoint(
            filepath='./cnn_parameters/better_model_parameters.h5',
            monitor='val_loss',
            save_best_only=True
        ),
        tf.keras.callbacks.TensorBoard(
            log_dir='./cnn_parameters/logs',
            histogram_freq=0
        )
    ]

    # Train
    model.fit(
        x_train, y_train,
        epochs=1000,
        batch_size=1,
        shuffle=True,
        validation_data=(x_train, y_train),
        callbacks=callbacks
    )

    # Save final model
    model.save('./cnn_parameters/final_model_parameters.h5')


if __name__ == "__main__":
    train()