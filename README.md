# SESCN_suppression

# Unsupervised learning for the suppression of seismic external source coherent noise

Official implementation of the *GEOPHYSICS* paper:

**Unsupervised learning for the suppression of seismic external source coherent noise**  
**by Kunxi Wang, Ying Rao, Tianyue Hu, Chunming Wang**

This repository provides a hybrid **MATLAB + Python** workflow for suppressing seismic external source coherent noise (SESCN) using an **unsupervised deep neural network (UDNN)** combined with the **forward modeling of external source noise (FMESN)**.

---
### Running Order

To reproduce the final results, the scripts must be run in the following order after the required MATLAB and Python environments have been installed:

1. step1_make_training_dataset.m

2. step2_training_with_UDNN.py

3. step3_testing_with_UDNN.py

4. step4_show_result_figures.m

These four scripts form the complete workflow.
The final results can only be obtained by executing them sequentially in this order.

---

## Abstract

In seismic data acquisition, the external sources generate strong coherent noise, so-called seismic external source coherent noise (SESCN), in addition to the main seismic source. To suppress SESCN from seismic data, we propose an unsupervised deep neural network (UDNN) in combination with the forward modeling of the external source noise (FMESN) method. According to the distribution and kinematic form of SESCN in the original data, we obtain FMESN by the forward modeling method. Although there are differences in amplitudes, frequencies, and phases between FMESN and the real SESCN in the original data, FMESN is kinematically equivalent to the real SESCN. In other words, the real SESCN can be calibrated by FMESN. UDNN has an excellent nonlinear mapping capability. In the training phase of UDNN, FMESN, with its events flattened by the hyperbolic normal moveout correction (HNMC) operator, is used as input data and mapped to the estimated SESCN by UDNN. Our proposed UDNN method does not require real effective signals and real SESCN to participate in the training phase as training data, which can solve the problem of missing training data. Examples of synthetic data and field data show that our proposed UDNN method can effectively suppress SESCN and that its suppression effect is better than that of the frequency-wavenumber (FK) domain dip filter method.

---

## Requirements

### MATLAB
- **MATLAB R2023a**

### Python
The Python environment for training and testing is defined in:

-bash

environment.yml



This file specifies the required installation environment for Python, TensorFlow, and related supporting libraries.

Installation

Two software environments are required:

1. MATLAB

Install MATLAB R2023a.

2. Python environment

Create the Python environment from environment.yml:

conda env create -f environment.yml


---
### Workflow
Step 1. Generate the training dataset

Run in MATLAB:

step1_make_training_dataset

This step generates the training data used by the UDNN model.

Step 2. Train the UDNN model

Run in Python:

python step2_training_with_UDNN.py

This step trains the model and saves the learned parameters to cnn_parameters/.

Step 3. Test the trained model

Run in Python:

python step3_testing_with_UDNN.py

This step loads the trained model and saves the prediction results to saved_result_dataset/.

Step 4. Visualize the final results

Run in MATLAB:

step4_show_result_figures

This step generates the final figures and visual comparisons.
---


## Repository Structure

```text
.
├── cnn_parameters/
│   ├── logs/
│   ├── better_model_parameters.h5
│   └── final_model_parameters.h5
├── figures/
│   ├── Figure3_in_the_reference_paper.png
│   ├── Figure5_in_the_reference_paper.png
│   └── Figure6_in_the_reference_paper.png
├── original_dataset/
│   ├── clean_data.mat
│   ├── full_data.mat
│   └── only_outsied_data.mat
├── saved_result_dataset/
│   ├── result.mat
│   └── result.npy
├── tools/
│   └── network_structure.py
├── training_dataset/
│   ├── input_data.mat
│   └── reference_data.mat
├── utils/
│   ├── apply_attenuation.m
│   ├── embed_data.m
│   ├── evaluate_results.m
│   ├── flatten_events.m
│   ├── forward_modeling.m
│   ├── init_parameters.m
│   ├── inverse_transform.m
│   ├── load_data.m
│   ├── load_original_data.m
│   ├── plot_final_results.m
│   ├── plot_original_data.m
│   ├── plot_udnn_results.m
│   ├── rickerwavelet.m
│   ├── seismic.m
│   └── simulate_periodic_SESCN.m
├── environment.yml
├── step1_make_training_dataset.m
├── step2_training_with_UDNN.py
├── step3_testing_with_UDNN.py
└── step4_show_result_figures.m
```

---
## Main Files

environment.yml: Python, TensorFlow, and supporting library requirements

step1_make_training_dataset.m: training-data generation

step2_training_with_UDNN.py: UDNN training

step3_testing_with_UDNN.py: UDNN testing

step4_show_result_figures.m: final visualization

## Data and Outputs
### Input data

original_dataset/: original seismic data

training_dataset/: generated training data

### Output data

cnn_parameters/: trained model parameters, the second step by running the "step2_training_with_UDNN.py" will produce the cnn_parameters "better_model_parameters.h5" and "final_model_parameters.h5", or you can download an example related to cnn_parameters from "https://drive.google.com/drive/folders/1wAOhe3ZUfMj9fgvHG07U5KAvmqIw8NpZ?usp=sharing".

saved_result_dataset/: prediction results

figures/: output figures
<img width="2382" height="1486" alt="Figure3_in_the_reference_paper" src="https://github.com/user-attachments/assets/5f3fe008-93d6-45da-a786-b0a548acd511" />
<img width="2904" height="2480" alt="Figure5_in_the_reference_paper" src="https://github.com/user-attachments/assets/c95ce66b-c15c-4066-8ccc-65a24184929e" />
<img width="6681" height="1671" alt="Figure6_in_the_reference_paper" src="https://github.com/user-attachments/assets/9a193a25-a86c-4570-99b1-1bedfd497258" />


### Notes

Please run all scripts from the repository root directory.

Please ensure that the relative paths in MATLAB and Python scripts match your local setup.

Minor path or file-I/O adjustments may be needed on different systems.

### Citation

If you use this repository in your research, please cite:

@article{wang_udnn_sescn,
  title   = {Unsupervised learning for the suppression of seismic external source coherent noise},
  author  = {Wang, Kunxi and Rao, Ying and Hu, Tianyue and Wang, Chunming},
  journal = {GEOPHYSICS}
}



