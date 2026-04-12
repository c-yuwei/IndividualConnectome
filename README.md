![BRAPH 2](braph2banner.png)

[![BRAPH 2](https://img.shields.io/badge/Bluesky-BRAPH%202-blue?style=social&logo=bluesky&url=https%3A%2F%2Fbraph2software.bsky.social)](https://braph2software.bsky.social)
[![BRAPH 2](https://img.shields.io/twitter/url?label=BRAPH%202&style=social&url=https%3A%2F%2Ftwitter.com%2Fbraph2software)](https://twitter.com/braph2software)
[![cite us](https://img.shields.io/badge/DOI-10.1371%2Fjournal.pone.0178798-blue)](https://doi.org/10.1371/journal.pone.0178798)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/yu-wei-c/DiSTAP)](https://github.com/yu-wei-c/DiSTAP/releases)
[![arXiv](https://img.shields.io/badge/arXiv-2507.15772-b31b1b.svg)](https://arxiv.org/abs/2507.15772)

# BRAPH 2 Individual Connectome

The **BRAPH 2 Individual Connectome** distribution provides end-to-end pipelines for constructing and analysing **individual similarity connectomes** from preprocessed neuroimaging data, including **positron emission tomography (PET)**, which measures tracer uptake related to tissue metabolism or molecular processes, and **T1-weighted magnetic resonance imaging (T1-weighted MRI)**, a structural MRI modality that provides high-resolution anatomical contrast of brain tissue. The distribution supports both **region-of-interest (ROI)-based** approaches, where each brain region is represented by one summary value such as regional Standardized Uptake Value Ratio (SUVR) or gray-matter probability, and **probability density function (PDF)-based** approaches, where each brain region is represented by the distribution of voxel values within that region. This enables users to move from preprocessed images to subject-level connectomes, graph-theoretical analysis, and deep-learning classification within a unified framework.

This distribution reuses the core analytical infrastructure of the standard BRAPH 2 distribution. For a general introduction to BRAPH 2, please refer to the main [BRAPH 2](https://github.com/braph-software/BRAPH-2/tree/develop) repository and its [tutorials](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials).

## Pipelines and folder structure

Within this repository, the pipelines are organised under dedicated folders according to their input representation and connectome-construction strategy.

### 1. Neuroimaging conversion to **regional-of-interest (ROI) values**
- **Pipeline folder:** `braph2individualconnectome/pipelines/Neuroimaging conversion structural/`
- **Example script:** `braph2individualconnectome/pipelines/Neuroimaging conversion structural/example_IMG_ROI_PET.m`

This pipeline computes **region-of-interest (ROI) values** from preprocessed neuroimaging data, such as PET or T1-weighted MRI.

It is intended for workflows where each subject is represented by one scalar value per brain region, for example regional SUVR, cortical thickness, or gray-matter probability summary.

### 2. Neuroimaging conversion to **regional probability density functions (PDFs)**
- **Pipeline folder:** `braph2individualconnectome/pipelines/Neuroimaging conversion PDFs/`
- **Example script:** `braph2individualconnectome/pipelines/Neuroimaging conversion PDFs/example_IMG_PDFs_PET.m`

This pipeline computes **regional probability density functions (PDFs)** from preprocessed neuroimaging data, such as PET or T1-weighted MRI.

It is intended for workflows where each subject is represented not only by a regional average, but by the full within-region distribution of voxel values.

### 3. ROI-value conversion to connectivity with Mahalanobis distance
- **Pipeline folder:** `braph2individualconnectome/pipelines/Structural mahalanobis connectivity/`
- **Example script:** `braph2individualconnectome/pipelines/Structural mahalanobis connectivity/example_ST_MAHALANOBIS_CON.m`

This pipeline constructs an **individual similarity connectome** from ROI values using a Mahalanobis-distance-based strategy. It aims to capture subject-level inter-regional similarity structure beyond simple univariate summaries.

> Reference to be added.

### 4. ROI-value conversion to connectivity with perturbation
- **Pipeline folder:** `braph2individualconnectome/pipelines/Structural perturbation connectivity/`
- **Example script:** `braph2individualconnectome/pipelines/Structural perturbation connectivity/example_ST_PERTURBATION_CON.m`

This pipeline constructs an **individual similarity connectome** from ROI values using a perturbation-based strategy. It is designed to quantify subject-level inter-regional similarity through controlled perturbation of the regional feature representation.

> Reference to be added.

### 5. PDF conversion to connectivity with correlation
- **Pipeline folder:** `braph2individualconnectome/pipelines/PDFs correlation connectivity/`
- **Example script:** `braph2individualconnectome/pipelines/PDFs correlation connectivity/example_PDFs_CORR_CON.m`

This pipeline constructs an **individual similarity connectome** from regional PDFs using correlation. It captures similarity between brain regions by comparing the shapes of their within-region voxel-value distributions.

> Reference to be added.

### 6. PDF conversion to connectivity with divergence
- **Pipeline folder:** `braph2individualconnectome/pipelines/PDFs divergence connectivity/`
- **Example script:** `braph2individualconnectome/pipelines/PDFs divergence connectivity/example_PDFs_DIV_CON.m`

This pipeline constructs an **individual similarity connectome** from regional PDFs using divergence. It captures differences or similarity between regional voxel-value distributions in a way that is sensitive to distributional shape.

> Reference to be added.

### 7. Variable-of-interest NN
This pipeline provides neural-network classification that incorporates both imaging-derived features and **variables of interest** such as age, sex, and education.

It is intended to support classification while also enabling meaningful interpretation of important brain regions, complementing the subject-level connectome analyses.


## Software requirements

To run **BRAPH 2 Individual Connectome**, you need:

### MATLAB
- MATLAB (R2022a or later is recommended)
- The following toolboxes:
  - **Statistics and Machine Learning Toolbox**
  - **Deep Learning Toolbox**
  - **Parallel Computing Toolbox**

Additional toolbox requirements may be documented for specific pipelines if needed.

## Getting started

Once the repository is downloaded or cloned, you can run the distribution directly from MATLAB.

### 1. Launch the distribution
```matlab
cd braph2individualconnectome
braph2individualconnectome
```

### 2. Run the example scripts

Example scripts are provided for each pipeline so that users can reproduce the expected workflow on the accompanying example data.

These examples are intended to demonstrate:
- extraction of ROI values from preprocessed PET or T1-weighted MRI
- extraction of regional PDFs from preprocessed PET or T1-weighted MRI
- construction of individual similarity connectomes
- graph-theoretical analysis
- neural-network classification with variables of interest

The exact example script names and study folders will be documented here as the repository structure is finalised.

## Software compilation

The compiled version of this distribution is already included in this repository under the corresponding compiled folder. However, if you extend the pipelines, add new elements, or modify the current architecture, you may wish to recompile the distribution.

You can recompile it using the BRAPH 2 Genesis mechanism. In MATLAB:

```matlab
% Example – adapt the configuration filename to your setup
braph2genesis('braph2individualconnectome_config.m');
```

This will regenerate the compiled distribution folder with the updated elements and GUIs.

## Warning
Before recompiling, remove the existing compiled distribution folder and take it off the MATLAB path to avoid conflicts. The folder will be recreated after a successful compilation.

## Citing

If you use BRAPH 2 Individual Connectome in your work, please cite:

> Reference to be added.

> Chang et al., *BRAPH 2: a flexible, open-source, reproducible, community-oriented, easy-to-use framework for network analyses in neurosciences* (preprint).
> [biorXiv:10.1101/2025.04.11.648455](https://doi.org/10.1101/2025.04.11.648455)
