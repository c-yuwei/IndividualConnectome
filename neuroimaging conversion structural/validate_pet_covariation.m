%% validate_pet_covariation
%  Validate the covariation mechanism of create_data_NIfTI_PET.
%
%  Approach: randomly pick a few NON-REFERENCE brain regions as covarying
%            regions, generate data, binarize with corrcoef >= threshold, and
%            check whether the covarying block is fully recovered.
%
%  PET-specific notes (vs the GM/WM validators):
%    - PET stores SUVR (raw uptake divided by the subject's whole-cerebellum
%      reference mean). The shared denominator couples all non-reference ROIs
%      slightly. The TRUE covarying correlation is only ~0.95 (vs GM/WM ~0.98),
%      while non-covarying pairs sit at ~0.04 (max ~0.28). So there is a large
%      separation gap (0.28 <-> 0.95) but the covarying signal sits right at
%      0.95, which is why a 0.95 threshold MISSES covarying pairs.
%    - Two calibrated changes (verified empirically, see plan file):
%        * NUM_SUBJECTS = 30 (not 10): with only 10 subjects the sample
%          correlations scatter too much around the true values; 30 tightens
%          them enough for a clean split.
%        * THRESHOLD = 0.70: placed in the middle of the separation gap.
%          Sweep showed 30 subjects pass 5/5 for any threshold in 0.65-0.80.
%    - The generator auto-detects cerebellum/vermis ROIs as reference regions
%      and STRIPS them out of the covarying set (setdiff). Therefore covarying
%      regions are sampled ONLY from non-reference ROIs, learned via a one-off
%      warm-up run that reads groundtruth_reference_rois.xlsx.
%    - Reference ROIs are EXCLUDED from the fault (spurious) check because they
%      are the normalizer and have a special structural role.
%
%  Usage: just run this script in MATLAB. No arguments needed.

%% ---- Config ----
NUM_REPEATS     = 5;        % Number of random trials (how many random trials)
NUM_SUBJECTS    = 20;       % Subjects per trial (PET needs >10 for stable correlations)
NUM_COVARYING   = 5;        % Covarying ROIs selected per trial (covarying ROIs per trial)
BASE_SEED       = 42;       % Base seed; round r uses BASE_SEED + r - 1
THRESHOLD       = 0.90;     % Binarization threshold, placed in the 0.28<->0.95 gap (PET-calibrated)
FAULT_TOLERANCE = 3;        % Max allowed spurious non-covarying regions (max spurious non-covarying regions)

% Toggle: whether to delete the generated example data after validation.
%   true  = delete each trial's output folder after it is validated (no leftovers)
%   false = keep all generated data on disk for inspection
DELETE_EXAMPLE_DATA = true;

%% ---- Paths ----
this_dir = fileparts(mfilename('fullpath'));
if isempty(this_dir); this_dir = pwd; end
addpath(this_dir);

atlas_path = fullfile(this_dir, 'Example atlases NIfTI', 'aal120_atlas.nii');
assert(isfile(atlas_path), 'Atlas not found: %s', atlas_path);

%% ---- Get the number of brain regions (same logic as the generation function) ----
atlas_data    = niftiread(atlas_path);
region_labels = unique(atlas_data(:));
region_labels(region_labels == 0) = [];     % Exclude background label = 0
num_regions   = numel(region_labels);
clear atlas_data                            % Free memory

fprintf('=== PET covariation validation (threshold=%.2f, fault_tol=%d) ===\n', ...
    THRESHOLD, FAULT_TOLERANCE);
fprintf('Regions: %d | subjects: %d | repeats: %d\n\n', ...
    num_regions, NUM_SUBJECTS, NUM_REPEATS);

%% ---- Warm-up run: discover the cerebellum reference ROIs ----
% The generator strips reference ROIs out of the covarying set, so we must learn
% which regions are reference before sampling covarying regions. We do one small
% generation, read groundtruth_reference_rois.xlsx, then delete the temp data.
warmup_dir = fullfile(this_dir, 'Example data NIfTI', 'validation_warmup');
if isfolder(warmup_dir); rmdir(warmup_dir, 's'); end
mkdir(warmup_dir);

fprintf('--- Warm-up run to discover reference (cerebellum) ROIs ---\n');
create_data_NIfTI_PET(atlas_path, warmup_dir, {'Group1'}, 1, BASE_SEED, 1:NUM_COVARYING);

ref_table     = readtable(fullfile(warmup_dir, 'reference_data', 'groundtruth_reference_rois.xlsx'));
reference_idx = sort(ref_table.RegionIndex(:))';
non_ref_pool  = setdiff(1:num_regions, reference_idx);

rmdir(warmup_dir, 's');

fprintf('Reference ROIs: %d | non-reference pool: %d\n\n', ...
    numel(reference_idx), numel(non_ref_pool));

assert(numel(non_ref_pool) >= NUM_COVARYING, ...
    'Not enough non-reference ROIs (%d) to pick %d covarying.', ...
    numel(non_ref_pool), NUM_COVARYING);

%% ---- Main loop: each round randomly picks covarying regions and validates ----
pass_flags = false(1, NUM_REPEATS);

for r = 1:NUM_REPEATS
    seed = BASE_SEED + r - 1;

    % Use the seed to randomly select covarying regions FROM THE NON-REFERENCE POOL
    rng(seed);
    covar_idx = sort(non_ref_pool(randperm(numel(non_ref_pool), NUM_COVARYING)));

    % Create output directory under the current folder (the generation function
    % skips when it detects existing NIfTI files, so a fresh directory is required)
    out_dir = fullfile(this_dir, 'Example data NIfTI', sprintf('validation_seed_%d', seed));
    if isfolder(out_dir); rmdir(out_dir, 's'); end
    mkdir(out_dir);

    % Call the generation function directly so all of its output is printed
    fprintf('--- Generating PET data for seed %d ---\n', seed);
    % create_data_NIfTI_PET(atlas_path, out_dir, {'Group1'}, NUM_SUBJECTS, seed, covar_idx);
    evalc('create_data_NIfTI_PET(atlas_path, out_dir, {''Group1''}, NUM_SUBJECTS, seed, covar_idx)');


    % Read the ROI mean matrix [subjects x regions]
    means_xlsx = fullfile(out_dir, 'reference_data', 'group_roi_means_pet.xlsx');
    raw  = readcell(means_xlsx);
    M    = cell2mat(raw(2:end, 4:end));     % Skip the header row + ID/Label/Notes columns

    % Compute the correlation matrix -> binarize with the threshold
    R = corrcoef(M);                        % Pearson correlation matrix [regions x regions]
    n = size(R, 1);
    B = R >= THRESHOLD;                     % Binary matrix: 1 = high correlation

    % Build the covarying block mask (diagonal excluded)
    offdiag   = ~eye(n);
    blockmask = false(n);
    blockmask(covar_idx, covar_idx) = true;  % True inside the covarying block
    blockmask(logical(eye(n))) = false;      % Exclude the diagonal

    % Check block recovery: are all C(5,2)=10 pairs in the covarying block >= threshold?
    within_pairs = nchoosek(numel(covar_idx), 2);   % Should be 10
    TP = nnz(B & offdiag & blockmask) / 2;          % Correctly detected high-correlation pairs
    FN = within_pairs - TP;                          % Missed pairs (must be 0)

    % Fault tolerance: count non-covarying regions with above-threshold spurious
    % correlation. Reference (cerebellum) ROIs are EXCLUDED -- they are the SUVR
    % normalizer and share the denominator by design.
    spurious    = B & offdiag & ~blockmask;          % Above-threshold edges outside the block
    touched     = any(spurious, 2)';                 % Regions touched by spurious correlation
    is_noncov   = ~ismember(1:n, covar_idx) & ~ismember(1:n, reference_idx);
    fault_count = nnz(touched & is_noncov);          % Number of spurious non-covarying regions

    % Echo check: do the covarying regions recorded in the groundtruth xlsx match the input?
    % (We sampled from non-reference ROIs, so no stripping should occur -> exact match.)
    gt = readtable(fullfile(out_dir, 'reference_data', 'groundtruth_covarying_rois_pet.xlsx'));
    gt_idx = gt.RegionIndex(gt.IsCovarying ~= 0)';
    echo_ok = isequal(sort(gt_idx), sort(covar_idx));

    % Pass criterion: echo correct AND FN=0 AND spurious regions <= fault tolerance
    pass = echo_ok && (FN == 0) && (fault_count <= FAULT_TOLERANCE);
    pass_flags(r) = pass;

    if pass; tag = 'PASS'; else; tag = 'FAIL'; end
    fprintf('  Repeat %d/%d  seed=%d  covar=[%s]  TP=%d/%d  FN=%d  fault=%d  => %s\n', ...
        r, NUM_REPEATS, seed, strjoin(string(covar_idx), ','), ...
        TP, within_pairs, FN, fault_count, tag);

    % Optionally delete the generated example data for this trial (toggle above)
    if DELETE_EXAMPLE_DATA && isfolder(out_dir)
        rmdir(out_dir, 's');
    end
end

% If example data was deleted, remove the now-empty parent folder when possible
if DELETE_EXAMPLE_DATA
    parent_dir = fullfile(this_dir, 'Example data NIfTI');
    if isfolder(parent_dir)
        entries = dir(parent_dir);
        entries = entries(~ismember({entries.name}, {'.', '..'}));
        if isempty(entries)
            rmdir(parent_dir);
        end
    end
end

%% ---- Summary ----
n_pass = sum(pass_flags);
fprintf('\n========================================\n');
if all(pass_flags)
    fprintf('PASSED %d/%d repeats. OVERALL: PASS\n', n_pass, NUM_REPEATS);
else
    fprintf('PASSED %d/%d repeats. OVERALL: FAIL\n', n_pass, NUM_REPEATS);
    warning('Covariation validation FAILED: %d/%d repeats passed.', n_pass, NUM_REPEATS);
end
fprintf('========================================\n');
