function create_data_NIfTI_WMProb(atlas_path, output_dir, group_names, num_files_per_group, seed, covarying_roi_indices)
% CREATE_DATA_NIFTI_WMPROB
% Generate simulated white matter probability maps using the same atlas space as the PET data.
%
% Inputs:
%   atlas_path            - path to atlas NIfTI file
%   output_dir            - output directory
%   group_names           - group names
%   num_files_per_group   - number of subjects per group
%   seed                  - random seed
%   covarying_roi_indices - ROI indices designed to covary; if empty, the first 20 ROIs are used
%
% Default behavior:
%   - 1 group
%   - 10 subjects
%   - first 20 ROIs are designed to covary
%   - BIDS-like folder structure: sub-XXXX/ses-01/anat
%   - 1 VOI Excel file with subject metadata only
%   - 1 Excel file with subject-wise ROI mean WM probability
%   - 1 Excel file describing which ROIs are designed to covary together
%   - 1 folder with per-subject ROI PDF matrices
%
% Outputs in reference_data:
%   - group_wmprob.vois.xlsx
%   - group_roi_means_wmprob.xlsx
%   - groundtruth_covarying_rois_wmprob.xlsx
%   - group_pdf_bins_wmprob.xlsx
%   - pdf_wmprob/
%
% Outputs per subject:
%   - sub-XXXX/ses-01/anat/sub-XXXX_ses-01_WMprob.nii
%
% Notes:
%   - Each saved image is a continuous white matter probability map in [0, 1].
%   - Voxels near the ROI core receive higher WM probability.
%   - Voxels near the ROI boundary receive lower WM probability.
%   - Some ROIs share a subject-level shift in mean WM probability,
%     creating a mean-level covarying block across subjects.
%   - Per-subject PDF matrices are saved with:
%       rows    = common PDF bins
%       columns = ROIs in atlas order

    %% Defaults
    if nargin < 1 || isempty(atlas_path)
        atlas_path = fullfile( ...
            fileparts(which('create_data_NIfTI_WMProb')), ...
            'example atlases NIfTI', ...
            'td_atlas.nii' ...
            );
    end

    if nargin < 2 || isempty(output_dir)
        output_dir = fullfile(fileparts(which('create_data_NIfTI_WMProb')), 'Example data NIfTI');
    end

    if nargin < 3 || isempty(group_names)
        group_names = {'Group1'};
    end

    if nargin < 4 || isempty(num_files_per_group)
        num_files_per_group = 10;
    end

    if nargin < 5 || isempty(seed)
        seed = 42;
    end

    if nargin < 6
        covarying_roi_indices = [];
    end

    rng(seed);

    %% Prepare output folders
    if ~isfolder(output_dir)
        mkdir(output_dir);
    end

    existing_wmprob_files = dir(fullfile(output_dir, 'sub-*', 'ses-*', 'anat', '*_WMprob.nii'));

    if ~isempty(existing_wmprob_files)
        fprintf('WM probability NIfTI files already exist. Skipping WM probability data generation in: %s\n', output_dir);
        return
    end

    reference_dir = fullfile(output_dir, 'reference_data');

    if ~isfolder(reference_dir)
        mkdir(reference_dir);
    end

    pdf_wmprob_dir = fullfile(reference_dir, 'pdf_wmprob');

    if ~isfolder(pdf_wmprob_dir)
        mkdir(pdf_wmprob_dir);
    end

    %% Load atlas
    fprintf('Loading atlas from %s...\n', atlas_path);

    atlas_info = niftiinfo(atlas_path);
    atlas_data = niftiread(atlas_path);

    region_labels = unique(atlas_data(:));
    region_labels(region_labels == 0) = [];
    num_regions = numel(region_labels);

    fprintf('Number of brain regions: %d\n', num_regions);

    %% Validate or set covarying ROI indices
    if isempty(covarying_roi_indices)
        covarying_roi_indices = 1:min(20, num_regions);
    else
        covarying_roi_indices = unique(covarying_roi_indices(:))';

        if any(covarying_roi_indices < 1) || any(covarying_roi_indices > num_regions)
            error('covarying_roi_indices must contain ROI indices between 1 and %d.', num_regions);
        end
    end

    fprintf('Number of covarying ROIs: %d\n', numel(covarying_roi_indices));

    %% Load atlas mapping CSV
    mapping_csv = fullfile(fileparts(atlas_path), 'td_atlas_mapping.csv');

    if ~isfile(mapping_csv)
        error('Mapping CSV not found: %s', mapping_csv);
    end

    mapping_table = readtable(mapping_csv, 'TextType', 'string');

    if width(mapping_table) < 4
        error('td_atlas_mapping.csv must have at least 4 columns: index, full region name, atlas label, short region name.');
    end

    mapping_labels      = mapping_table{:, 3};          % Var3 = atlas numeric code
    mapping_short_names = string(mapping_table{:, 4});  % Var4 = short ROI code

    %% Build ROI names aligned to atlas labels
    roi_names = strings(1, num_regions);

    for i = 1:num_regions
        idx = find(double(mapping_labels) == double(region_labels(i)), 1, 'first');

        if isempty(idx)
            roi_names(i) = "Region_" + string(region_labels(i));
        else
            roi_names(i) = mapping_short_names(idx);
        end
    end

    %% Cross-check ROI order and names against td_atlas.xlsx
    atlas_xlsx = fullfile(fileparts(atlas_path), 'td_atlas.xlsx');

    if ~isfile(atlas_xlsx)
        error('Atlas XLSX not found: %s', atlas_xlsx);
    end

    atlas_xlsx_cell = readcell(atlas_xlsx);
    atlas_short_name_cells = atlas_xlsx_cell(5:end, 1);
    atlas_short_names = string(atlas_short_name_cells(~cellfun(@isempty, atlas_short_name_cells)));

    if numel(atlas_short_names) ~= num_regions
        error(['Mismatch in number of ROIs between atlas NIfTI/mapping and td_atlas.xlsx. ' ...
            'Expected %d, found %d in td_atlas.xlsx.'], ...
            num_regions, numel(atlas_short_names));
    end

    if ~isequal(string(roi_names(:)), string(atlas_short_names(:)))
        mismatch_idx = find(string(roi_names(:)) ~= string(atlas_short_names(:)), 1, 'first');

        error(['ROI name/order mismatch between mapping-derived roi_names and td_atlas.xlsx ' ...
            'at position %d: roi_names="%s", atlas_xlsx="%s".'], ...
            mismatch_idx, string(roi_names(mismatch_idx)), string(atlas_short_names(mismatch_idx)));
    end

    fprintf('ROI name/order check passed: td_atlas.xlsx matches WM ROI mean headers.\n');

    %% Prepare WM NIfTI header
    wm_info = atlas_info;
    wm_info.Datatype = 'single';
    wm_info.BitsPerPixel = 32;

    %% Subject metadata settings
    sex_options = {'Female', 'Male'};
    education_range = [8, 20];

    %% Headers
    % VOI format:
    %   row 1 = headers
    %   row 2 = categorical definitions
    %   row 3+ = subject data
    vois_headers = {'Subject ID', 'Age', 'Sex', 'Education'};
    vois_definitions = {'', '', ['Female' newline 'Male'], ''};

    wmprob_headers = [{'ID', 'Label', 'Notes'}, cellstr(roi_names)];

    %% Simulation design
    % White-matter-like probability profile.
    % Here we keep probabilities generally high but not saturated.
    boundary_prob = 0.35;
    core_prob     = 0.92;

    % Subject-level and voxel-level variability
    subject_shift_std = 0.02;
    voxel_noise_std   = 0.03;

    % Additional ROI-block covariation in mean WM probability
    shared_prob_shift_std = 0.07;
    indep_prob_shift_std  = 0.03;

    %% WM probability PDF settings
    wm_pdf_edges = linspace(0, 1, 101);  % 100 bins across [0, 1]
    wm_pdf_bin_centers = (wm_pdf_edges(1:end-1) + wm_pdf_edges(2:end)) / 2;

    %% Save WM probability PDF bin centres
    wm_pdf_bins_file = fullfile(reference_dir, 'group_pdf_bins_wmprob.xlsx');
    writecell([{'BinCenter'}; num2cell(wm_pdf_bin_centers(:))], wm_pdf_bins_file);

    fprintf('Saved WM probability PDF bin centres to: %s\n', wm_pdf_bins_file);

    %% Global tables
    all_vois_cell = [
        vois_headers
        vois_definitions
        ];

    all_wmprob_means_cell = wmprob_headers;

    covarying_info = cell(num_regions + 1, 5);
    covarying_info(1, :) = {'RegionIndex', 'RegionLabel', 'RegionName', 'IsCovarying', 'CovaryingBlockID'};

    for r = 1:num_regions
        is_covarying = ismember(r, covarying_roi_indices);

        covarying_info(r + 1, :) = { ...
            r, ...
            region_labels(r), ...
            roi_names(r), ...
            logical(is_covarying), ...
            double(is_covarying) ...
            };
    end

    %% Subject counter across all groups
    global_subject_counter = 0;

    %% Process each group
    for group_idx = 1:numel(group_names)
        group_name = group_names{group_idx}; %#ok<NASGU>

        for file_idx = 1:num_files_per_group
            global_subject_counter = global_subject_counter + 1;

            subject_id = sprintf('sub-%04d', global_subject_counter);
            session_id = 'ses-01';

            sub_dir = fullfile(output_dir, subject_id, session_id);
            anat_dir = fullfile(sub_dir, 'anat');

            if ~isfolder(anat_dir)
                mkdir(anat_dir);
            end

            row_label = sprintf('Label %d', global_subject_counter);
            row_notes = sprintf('Note %d', global_subject_counter);

            [age, sex, education] = get_subject_metadata_or_random( ...
                reference_dir, ...
                subject_id, ...
                sex_options, ...
                education_range ...
                );

            wm_prob_data = zeros(size(atlas_data), 'single');
            realized_wmprob_means = zeros(1, num_regions);

            % Subject-level global shift
            subject_shift = subject_shift_std * randn();

            % Shared ROI-block shift for covarying regions
            shared_prob_shift = shared_prob_shift_std * randn();

            %% Generate ROI-specific WM probabilities
            for region_idx = 1:num_regions
                label = region_labels(region_idx);
                region_mask = atlas_data == label;

                if ~any(region_mask(:))
                    realized_wmprob_means(region_idx) = NaN;
                    continue
                end

                inward_distance = bwdist(~region_mask);
                region_dist = inward_distance(region_mask);
                max_dist = max(region_dist);

                if max_dist <= 1
                    base_roi_probs = 0.8 * ones(nnz(region_mask), 1);
                else
                    depth_norm = (region_dist - 1) / (max_dist - 1);
                    depth_norm = min(max(depth_norm, 0), 1);
                    base_roi_probs = boundary_prob + (core_prob - boundary_prob) * depth_norm;
                end

                % ROI mean shift: shared for covarying block, independent otherwise
                if ismember(region_idx, covarying_roi_indices)
                    roi_mean_shift = shared_prob_shift + 0.01 * randn();
                else
                    roi_mean_shift = indep_prob_shift_std * randn();
                end

                wm_probs = base_roi_probs ...
                    + subject_shift ...
                    + roi_mean_shift ...
                    + voxel_noise_std * randn(size(base_roi_probs));

                wm_probs = min(max(wm_probs, 0), 1);

                wm_prob_data(region_mask) = single(wm_probs);
                realized_wmprob_means(region_idx) = mean(wm_probs);
            end

            %% Save WM probability NIfTI
            wm_file = fullfile(anat_dir, sprintf('%s_%s_WMprob.nii', subject_id, session_id));
            niftiwrite(single(wm_prob_data), wm_file, wm_info);

            fprintf('Saved WM probability NIfTI file: %s\n', wm_file);

            %% Compute and save WM probability ROI PDFs
            wm_pdf_matrix = compute_roi_pdf_matrix(wm_prob_data, atlas_data, region_labels, wm_pdf_edges);
            wm_pdf_file = fullfile(pdf_wmprob_dir, sprintf('%s_%s_WMprob_pdf.xlsx', subject_id, session_id));
            save_subject_pdf_xlsx(wm_pdf_matrix, wm_pdf_file);

            fprintf('Saved WM probability ROI PDF matrix to: %s\n', wm_pdf_file);

            %% Add row to VOI table
            all_vois_cell = [all_vois_cell; {subject_id, age, sex, education}];

            %% Add row to WM probability means table
            wmprob_row = num2cell(realized_wmprob_means);
            all_wmprob_means_cell = [all_wmprob_means_cell; {subject_id, row_label, row_notes, wmprob_row{:}}];
        end
    end

    %% Save combined VOI table
    vois_file_path = fullfile(reference_dir, 'group_wmprob.vois.xlsx');
    writecell(all_vois_cell, vois_file_path);

    fprintf('Saved VOIs to: %s\n', vois_file_path);

    %% Save WM probability means table
    wmprob_means_file = fullfile(reference_dir, 'group_roi_means_wmprob.xlsx');
    writecell(all_wmprob_means_cell, wmprob_means_file);

    fprintf('Saved WM probability ROI means to: %s\n', wmprob_means_file);

    %% Save covarying ROI information
    covarying_file_path = fullfile(reference_dir, 'groundtruth_covarying_rois_wmprob.xlsx');
    covarying_table = cell2table(covarying_info(2:end, :), 'VariableNames', covarying_info(1, :));
    writetable(covarying_table, covarying_file_path);

    fprintf('Saved covarying ROI information to: %s\n', covarying_file_path);
end

function [age, sex, education] = get_subject_metadata_or_random(reference_dir, subject_id, sex_options, education_range)
% Try to load metadata from reference_data/group_pet.vois.xlsx.
% If not available, generate random fallback values.
%
% Expected VOI format:
%   row 1 = headers
%   row 2 = categorical definitions
%   row 3+ = subject data

    pet_vois_file = fullfile(reference_dir, 'group_pet.vois.xlsx');

    if isfile(pet_vois_file)
        pet_vois_cell = readcell(pet_vois_file);

        if size(pet_vois_cell, 1) >= 3
            headers = string(pet_vois_cell(1, :));

            id_col = find(headers == "Subject ID", 1);
            age_col = find(headers == "Age", 1);
            sex_col = find(headers == "Sex", 1);
            education_col = find(headers == "Education", 1);

            required_cols_found = ~isempty(id_col) && ...
                ~isempty(age_col) && ...
                ~isempty(sex_col) && ...
                ~isempty(education_col);

            if required_cols_found
                data_rows = 3:size(pet_vois_cell, 1); % skip header and categorical-definition row

                for row_i = data_rows
                    if strcmp(string(pet_vois_cell{row_i, id_col}), string(subject_id))
                        age = pet_vois_cell{row_i, age_col};
                        sex = char(string(pet_vois_cell{row_i, sex_col}));
                        education = pet_vois_cell{row_i, education_col};
                        return
                    end
                end
            end
        end
    end

    % Fallback: random metadata
    age = randi([18, 90]);
    sex = sex_options{randi(numel(sex_options))};
    education = randi(education_range);
end

function pdf_matrix = compute_roi_pdf_matrix(volume_data, atlas_data, region_labels, bin_edges)
% COMPUTE_ROI_PDF_MATRIX
% Compute histogram-based ROI PDFs on a common bin grid.
%
% Output:
%   pdf_matrix: [nBins x nRegions]
%       each column is the PDF of one ROI evaluated on the same bins

    num_regions = numel(region_labels);
    n_bins = numel(bin_edges) - 1;
    pdf_matrix = zeros(n_bins, num_regions);

    for region_idx = 1:num_regions
        region_mask = atlas_data == region_labels(region_idx);
        values = double(volume_data(region_mask));

        if isempty(values) || all(isnan(values))
            pdf_matrix(:, region_idx) = NaN;
            continue
        end

        pdf_vals = histcounts(values, bin_edges, 'Normalization', 'pdf');
        pdf_matrix(:, region_idx) = pdf_vals(:);
    end
end

function save_subject_pdf_xlsx(pdf_matrix, output_file)
% SAVE_SUBJECT_PDF_XLSX
% Save ROI PDF matrix to XLSX without variable names,
% analogous to the FUN time-series example.

    writetable(array2table(pdf_matrix), output_file, 'WriteVariableNames', false);
end
