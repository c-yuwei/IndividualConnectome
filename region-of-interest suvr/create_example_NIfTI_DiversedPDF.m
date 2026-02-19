function create_example_NIfTI(atlas_path, output_dir, group_names, num_files_per_group, seed)
% CREATE_EXAMPLE_NIFTI
% Generate 2-group simulated PET NIfTIs where:
%   - Mean-based / distance-based methods (based on ROI mean / ROI std) should NOT see group differences
%   - PDF-based methods (divergence / correlation on PDFs) SHOULD see group differences in selected regions
%
% Key idea:
%   - For each ROI in every subject, we enforce the SAME sample mean and SAME sample std across groups.
%   - Only in special ROIs, Group2 uses a multimodal mixture (different PDF shape), Group1 uses unimodal Gaussian.
%   - We clip to nonnegative (SUVR-like), THEN re-match sample mean/std (critical).
%
% NOTE:
%   - PET is saved as float32 (single). Saving as int16 will quantise values and can distort PDFs.

    % Defaults
    if nargin < 1 || isempty(atlas_path)
        atlas_path = which('upsampled_AAL2.nii');
    end
    if nargin < 2 || isempty(output_dir)
        output_dir = fullfile(fileparts(which('SubjectNIfTI')), 'Example data Nifti diverse PDF');
    end
    if nargin < 3 || isempty(group_names)
        group_names = {'Group1', 'Group2'};
    end
    if nargin < 4 || isempty(num_files_per_group)
        num_files_per_group = 25;
    end
    if nargin < 5 || isempty(seed)
        seed = 42;
    end

    rng(seed);

    % ==========================
    % Load atlas
    % ==========================
    fprintf('Loading atlas from %s...\n', atlas_path);
    atlas_info = niftiinfo(atlas_path);
    atlas_data = niftiread(atlas_path);
    atlas_mask = atlas_data > 0;

    region_labels = unique(atlas_data(:));
    region_labels(region_labels == 0) = [];
    num_regions = length(region_labels);
    fprintf('Number of brain regions: %d\n', num_regions);

    % ==========================
    % VOIs headers
    % ==========================
    region_mean_headers = strcat("Region_", string(region_labels), "_Mean");
    region_std_headers  = strcat("Region_", string(region_labels), "_Std");
    vois_headers = [{'Subject ID', 'Age', 'Sex', 'Education'}, region_mean_headers{:}, region_std_headers{:}];

    % ==========================
    % Global target scale (used to build the ROI-mean covariance model)
    % ==========================
    global_mean = 15;
    global_std  = 5;

    % ==========================
    % Special ROIs (by index in region_labels)
    % ==========================
    special_range = 21:40;
    special_range = special_range(special_range >= 1 & special_range <= num_regions);

    % ==========================
    % Simulation controls
    % ==========================
    % Mixture controls (Group2, special ROIs)
    w1_fixed = 0.25;         % side weight (0.15~0.25 also ok)
    small_sd_ratio = 0.35;   % component std ratio

    % ==========================
    % Precompute subject-level ROI mean vectors with shared covariance
    % ==========================
    mu_vec = global_mean * ones(1, num_regions);

    % AR(1)-like covariance across ROIs (SPD). Adjust rho if needed.
    rho = 0.6;
    idx = (1:num_regions);
    Sigma = rho .^ abs(idx(:) - idx(:)');
    Sigma = (global_std^2) * Sigma;

    % Shared across both groups (paired subjects)
    roi_mu_subject = mvnrnd(mu_vec, Sigma, num_files_per_group);      % [nSub x nRegions]

    % Shared ROI stds (can be constant, or region-varying if desired)
    roi_sd_subject = global_std * ones(num_files_per_group, num_regions);

    % ==========================
    % Main loop over groups
    % ==========================
    for group_idx = 1:length(group_names)
        group_name = group_names{group_idx};
        group_dir = fullfile(output_dir, group_name);

        if ~isfolder(group_dir)
            mkdir(group_dir);
        end

        % VOIs for the group
        sex_options = {'Female' 'Male'};
        education_range = [8, 20];

        empty_row = cell(1, numel(vois_headers));
        empty_row{3} = cell2str(sex_options);
        vois1 = [vois_headers; empty_row];

        % ==========================
        % Per-subject simulation
        % ==========================
        for file_idx = 1:num_files_per_group
            sub_id = sprintf('%s_subject_%d', group_name, file_idx);
            sub_folder = fullfile(group_dir, sub_id);
            mkdir(sub_folder);

            age = randi([18, 90]);
            sex = sex_options{randi(2)};
            education = randi(education_range);

            simulated_data = zeros(size(atlas_data), 'single');
            means_all_regions = zeros(1, num_regions);
            stds_all_regions  = zeros(1, num_regions);

            % ==========================
            % ROI loop (only simulation changes relative to your original flow)
            % ==========================
            for region_idx = 1:num_regions
                label = region_labels(region_idx);
                region_mask = (atlas_data == label);
                n_vox = nnz(region_mask);

                if n_vox == 0
                    means_all_regions(region_idx) = NaN;
                    stds_all_regions(region_idx)  = NaN;
                    continue;
                end

                % Target ROI mean/std for THIS subject (shared across groups)
                mu = roi_mu_subject(file_idx, region_idx);
                sd = roi_sd_subject(file_idx, region_idx);

                % ----- generate voxel values -----
                if ismember(region_idx, special_range)
                    if group_idx == 1
                        % Group1: unimodal Gaussian
                        simulated_values = mu + sd * randn(n_vox, 1);
                    else
                        % Group2: Bimodal Gaussian mixture (multi-shaped) with same mean/variance
                        % Two components, equal weight 0.5
                        small_std = sd * 0.3;  % Component std (tunable)
                        delta = sqrt(sd^2 - small_std^2);  % Separation to match total variance
                        % 50% from mean - delta, 50% from mean + delta
                        n_vox = nnz(atlas_data == label);
                        comp_choice = rand(n_vox, 1) > 0.5;  % Bernoulli for component selection
                        simulated_values = zeros(n_vox, 1);
                        simulated_values(comp_choice)  = (mu - delta) + small_std * randn(sum(comp_choice), 1);
                        simulated_values(~comp_choice) = (mu + delta) + small_std * randn(sum(~comp_choice), 1);
                        % % Group2: trimodal symmetric mixture (different PDF shape)
                        % w1 = w1_fixed;
                        % w2 = 1 - 2*w1;
                        % weights = [w1, w2, w1];
                        % 
                        % small_sd = min(small_sd_ratio * sd, 0.95 * sd);
                        % 
                        % % Match theoretical variance BEFORE clipping:
                        % % Var = small_sd^2 + 2*w1*delta^2 => delta = sqrt((sd^2-small_sd^2)/(2*w1))
                        % delta = sqrt(max((sd^2 - small_sd^2) / (2*w1), 0));
                        % 
                        % comp_id = randsample(1:3, n_vox, true, weights);
                        % simulated_values = zeros(n_vox, 1);
                        % simulated_values(comp_id == 1) = (mu - delta) + small_sd * randn(sum(comp_id == 1), 1);
                        % simulated_values(comp_id == 2) = mu           + small_sd * randn(sum(comp_id == 2), 1);
                        % simulated_values(comp_id == 3) = (mu + delta) + small_sd * randn(sum(comp_id == 3), 1);
                    end
                else
                    % Non-special: identical unimodal Gaussian in both groups
                    simulated_values = mu + sd * randn(n_vox, 1);
                end



                % Force sample mean = mu (critical for null mean/distance baseline)
                simulated_values = simulated_values - mean(simulated_values) + mu;

                % Force sample std = sd (recommended to kill sd-driven Mahalanobis effects)
                cur_sd = std(simulated_values, 0);
                if cur_sd > 0
                    simulated_values = (simulated_values - mean(simulated_values)) * (sd / cur_sd) + mu;
                end

                % Store REAL sample moments in VOIs
                means_all_regions(region_idx) = mean(simulated_values);
                stds_all_regions(region_idx)  = std(simulated_values, 0);

                % Write into volume
                simulated_data(region_mask) = single(simulated_values);
            end


            % ---- Save PET NIfTI (float32 to preserve PDF shape) ----
            simulated_nifti_path = fullfile(sub_folder, [sub_id '_PET.nii']);
            niftiwrite(int16(simulated_data), simulated_nifti_path, atlas_info);
            fprintf('Saved simulated NIfTI file: %s\n', simulated_nifti_path);

            % Save atlas mask NIfTI file using niftiwrite
            mask_nifti_path = fullfile(sub_folder, [sub_id '_T1.nii']);
            niftiwrite(int16(atlas_mask), mask_nifti_path, atlas_info);
            fprintf('Saved atlas mask NIfTI file: %s\n', mask_nifti_path);

            % Add row to VOIs table
            sub_means = num2cell(means_all_regions);
            sub_stds  = num2cell(stds_all_regions);
            vois1 = [vois1; {sub_id, age, sex, education, sub_means{:}, sub_stds{:}}];
        end

        % Keep your atlas export flow
        im_ba = ImporterBrainAtlasXLS('FILE', which('aal94_atlas.xlsx'));
        ba = im_ba.get('BA');
        ex_ba = ExporterBrainAtlasXLS( ...
            'BA', ba, ...
            'FILE', [fileparts(group_dir) filesep() 'atlas.xlsx'] ...
            );
        ex_ba.get('SAVE');

        % Save VOIs
        vois_file_path = fullfile(fileparts(group_dir), [group_name '.vois.xlsx']);
        vois_table = cell2table(vois1(2:end, :), 'VariableNames', vois1(1, :)); % Skip second row
        writetable(vois_table, vois_file_path);
        fprintf('Saved VOIs to: %s\n', vois_file_path);
    end
end
