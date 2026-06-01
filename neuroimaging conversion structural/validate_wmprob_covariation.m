%% validate_wmprob_covariation
%  Validate the covariation mechanism of create_data_NIfTI_WMProb.
%
%  Approach: randomly pick a few brain regions as covarying regions, generate
%            data, binarize with corrcoef >= threshold, and check whether the
%            covarying block is fully recovered.
%
%  Note: the WM generator is hardcoded to the td_atlas (~10 regions), which is
%        much smaller than the aal120 atlas used by the GM validator. The
%        covariation mechanism itself is identical to the GM case.
%
%  Usage: just run this script in MATLAB. No arguments needed.

%% ---- Config ----
NUM_REPEATS     = 5;        % Number of random trials (how many random trials)
NUM_SUBJECTS    = 10;       % Subjects generated per trial (subjects per trial)
NUM_COVARYING   = 3;        % Covarying ROIs selected per trial (td_atlas is small, ~10 regions)
BASE_SEED       = 42;       % Base seed; round r uses BASE_SEED + r - 1
THRESHOLD       = 0.95;     % Correlation binarization threshold (correlation binarization)
FAULT_TOLERANCE = 3;        % Max allowed spurious non-covarying regions (max spurious non-covarying regions)

% Toggle: whether to delete the generated example data after validation.
%   true  = delete each trial's output folder after it is validated (no leftovers)
%   false = keep all generated data on disk for inspection
DELETE_EXAMPLE_DATA = true;

%% ---- Paths ----
this_dir = fileparts(mfilename('fullpath'));
if isempty(this_dir); this_dir = pwd; end
addpath(this_dir);

atlas_path = fullfile(this_dir, 'Example atlases NIfTI', 'td_atlas.nii');
assert(isfile(atlas_path), 'Atlas not found: %s', atlas_path);

%% ---- Get the number of brain regions (same logic as the generation function) ----
atlas_data    = niftiread(atlas_path);
region_labels = unique(atlas_data(:));
region_labels(region_labels == 0) = [];     % Exclude background label = 0
num_regions   = numel(region_labels);
clear atlas_data                            % Free memory

fprintf('=== WMProb covariation validation (threshold=%.2f, fault_tol=%d) ===\n', ...
    THRESHOLD, FAULT_TOLERANCE);
fprintf('Regions: %d | subjects: %d | repeats: %d\n\n', ...
    num_regions, NUM_SUBJECTS, NUM_REPEATS);

%% ---- Main loop: each round randomly picks covarying regions and validates ----
pass_flags = false(1, NUM_REPEATS);

for r = 1:NUM_REPEATS
    seed = BASE_SEED + r - 1;

    % Use the seed to randomly select the covarying regions
    rng(seed);
    covar_idx = sort(randperm(num_regions, NUM_COVARYING));

    % Create output directory under the current folder (the generation function
    % skips when it detects existing NIfTI files, so a fresh directory is required)
    out_dir = fullfile(this_dir, 'Example data NIfTI', sprintf('validation_seed_%d', seed));
    if isfolder(out_dir); rmdir(out_dir, 's'); end
    mkdir(out_dir);

    % Call the generation function directly so all of its output is printed
    fprintf('--- Generating WM data for seed %d ---\n', seed);
    create_data_NIfTI_WMProb(atlas_path, out_dir, {'Group1'}, NUM_SUBJECTS, seed, covar_idx);

    % Read the ROI mean matrix [subjects x regions]
    means_xlsx = fullfile(out_dir, 'reference_data', 'group_roi_means_wmprob.xlsx');
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

    % Check block recovery: are all C(NUM_COVARYING,2) pairs in the block >= threshold?
    within_pairs = nchoosek(numel(covar_idx), 2);   % C(3,2) = 3
    TP = nnz(B & offdiag & blockmask) / 2;          % Correctly detected high-correlation pairs
    FN = within_pairs - TP;                          % Missed pairs (must be 0)

    % Fault tolerance: count non-covarying regions with above-threshold spurious correlation
    spurious    = B & offdiag & ~blockmask;          % Above-threshold edges outside the block
    touched     = any(spurious, 2)';                 % Regions touched by spurious correlation
    is_noncov   = ~ismember(1:n, covar_idx);         % Non-covarying region flags
    fault_count = nnz(touched & is_noncov);          % Number of spurious non-covarying regions

    % Echo check: do the covarying regions recorded in the groundtruth xlsx match the input?
    gt = readtable(fullfile(out_dir, 'reference_data', 'groundtruth_covarying_rois_wmprob.xlsx'));
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
