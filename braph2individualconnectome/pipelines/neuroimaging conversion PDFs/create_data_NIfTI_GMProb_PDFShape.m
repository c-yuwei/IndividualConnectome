function create_data_NIfTI_GMProb_PDFShape(atlas_path, output_dir, group_names, num_files_per_group, seed, covarying_roi_indices)
% CREATE_DATA_NIFTI_GMPROB_PDFSHAPE
% Generate simulated gray matter probability maps with ROI-level PDF-shape covariation.
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
%   - 1 Excel file with subject-wise ROI mean GM probability
%   - 1 Excel file describing which ROIs are designed to covary together
%   - 1 folder with per-subject ROI PDF matrices
%
% Outputs in reference_data:
%   - group_gmprob.vois.xlsx
%   - group_roi_means_gmprob.xlsx
%   - groundtruth_covarying_rois_gmprob.xlsx
%   - group_pdf_bins_gmprob.xlsx
%   - pdf_gmprob/
%
% Outputs per subject:
%   - sub-XXXX/ses-01/anat/sub-XXXX_ses-01_GMprob.nii
%
% Notes:
%   - Each saved image is a continuous gray matter probability map in [0, 1].
%   - Covarying ROIs share a subject-level PDF-shape factor.
%   - ROI means are re-centred to a fixed target mean, so the designed signal
%     is mainly in the PDF shape rather than the ROI mean.
%   - This dataset is intended to test PDF-based individual connectome methods,
%     such as PDF correlation or PDF divergence.
%   - Per-subject PDF matrices are saved with:
%       rows    = common PDF bins
%       columns = ROIs in atlas order

    %% Defaults
    if nargin < 1 || isempty(atlas_path)
        atlas_path = fullfile( ...
            fileparts(which('create_data_NIfTI_GMProb_PDFShape')), ...
            'example atlases NIfTI', ...
            'aal120_atlas.nii' ...
            );
    end
    if nargin < 2 || isempty(output_dir)
        output_dir = fullfile(fileparts(which('create_data_NIfTI_GMProb_PDFShape')), 'Example data NIfTI PDF shape covariation');
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

    existing_gmprob_files = dir(fullfile(output_dir, 'sub-*', 'ses-*', 'anat', '*_GMprob.nii'));
    if ~isempty(existing_gmprob_files)
        fprintf('GM probability NIfTI files already exist. Skipping GM probability PDF-shape data generation in: %s\n', output_dir);
        return
    end

    reference_dir = fullfile(output_dir, 'reference_data');
    if ~isfolder(reference_dir)
        mkdir(reference_dir);
    end

    pdf_gmprob_dir = fullfile(reference_dir, 'pdf_gmprob');
    if ~isfolder(pdf_gmprob_dir)
        mkdir(pdf_gmprob_dir);
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
    mapping_csv = fullfile(fileparts(atlas_path), 'aal120_atlas_mapping.csv');
    if ~isfile(mapping_csv)
        error('Mapping CSV not found: %s', mapping_csv);
    end

    mapping_table = readtable(mapping_csv, 'TextType', 'string');

    if width(mapping_table) < 4
        error('aal120_atlas_mapping.csv must have at least 4 columns: index, full region name, atlas label, short region name.');
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

    %% Cross-check ROI order and names against aal120_atlas.xlsx
    atlas_xlsx = fullfile(fileparts(atlas_path), 'aal120_atlas.xlsx');
    if ~isfile(atlas_xlsx)
        error('Atlas XLSX not found: %s', atlas_xlsx);
    end

    atlas_xlsx_cell = readcell(atlas_xlsx);
    atlas_short_name_cells = atlas_xlsx_cell(5:end, 1);
    atlas_short_names = string(atlas_short_name_cells(~cellfun(@isempty, atlas_short_name_cells)));

    if numel(atlas_short_names) ~= num_regions
        error(['Mismatch in number of ROIs between atlas NIfTI/mapping and aal120_atlas.xlsx. ' ...
            'Expected %d, found %d in aal120_atlas.xlsx.'], ...
            num_regions, numel(atlas_short_names));
    end

    if ~isequal(string(roi_names(:)), string(atlas_short_names(:)))
        mismatch_idx = find(string(roi_names(:)) ~= string(atlas_short_names(:)), 1, 'first');
        error(['ROI name/order mismatch between mapping-derived roi_names and aal120_atlas.xlsx ' ...
            'at position %d: roi_names="%s", atlas_xlsx="%s".'], ...
            mismatch_idx, string(roi_names(mismatch_idx)), string(atlas_short_names(mismatch_idx)));
    end

    fprintf('ROI name/order check passed: aal120_atlas.xlsx matches GM ROI mean headers.\n');

    %% Prepare GM NIfTI header
    gm_info = atlas_info;
    gm_info.Datatype = 'single';
    gm_info.BitsPerPixel = 32;

    %% Headers
    vois_headers = {'ID', 'Label', 'Notes', 'Age', 'Sex', 'Education'};
    gmprob_headers = [{'ID', 'Label', 'Notes'}, cellstr(roi_names)];

    %% Simulation design

    % Fixed target mean for all ROIs
    target_gm_mean = 0.60;

    % PDF-shape parameters
    base_shape_delta = 0.16;          % baseline half-separation between low/high components
    shared_shape_shift_std = 0.07;   % subject-level shared shape variation for covarying ROIs
    indep_shape_shift_std  = 0.03;   % independent shape variation for non-covarying ROIs
    voxel_noise_std = 0.015;         % voxel-level noise

    % Safety range to avoid clipping-induced mean shifts
    min_shape_delta = 0.04;
    max_shape_delta = 0.28;

    %% GM probability PDF settings
    gm_pdf_edges = linspace(0, 1, 101);  % 100 bins across [0, 1]
    gm_pdf_bin_centers = (gm_pdf_edges(1:end-1) + gm_pdf_edges(2:end)) / 2;

    %% Save GM probability PDF bin centres
    gm_pdf_bins_file = fullfile(reference_dir, 'group_pdf_bins_gmprob.xlsx');
    writecell([{'BinCenter'}; num2cell(gm_pdf_bin_centers(:))], gm_pdf_bins_file);
    fprintf('Saved GM probability PDF bin centres to: %s\n', gm_pdf_bins_file);

    %% Global tables
    all_vois_cell = vois_headers;
    all_gmprob_means_cell = gmprob_headers;

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

        sex_options = {'Female', 'Male'};
        education_range = [8, 20];

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

            gm_prob_data = zeros(size(atlas_data), 'single');
            realized_gmprob_means = zeros(1, num_regions);

            % Shared subject-level PDF-shape factor for covarying ROIs
            shared_shape_shift = shared_shape_shift_std * randn();

            %% Generate ROI-specific GM probabilities
            for region_idx = 1:num_regions
                label = region_labels(region_idx);
                region_mask = (atlas_data == label);

                if ~any(region_mask(:))
                    realized_gmprob_means(region_idx) = NaN;
                    continue;
                end

                n_vox = nnz(region_mask);

                % Use the ROI depth profile to assign voxels into two components.
                % This keeps some spatial structure while changing the within-ROI distribution.
                inward_distance = bwdist(~region_mask);
                region_dist = inward_distance(region_mask);

                if numel(unique(region_dist)) <= 1
                    component_sign = ones(n_vox, 1);
                    component_sign(1:floor(n_vox / 2)) = -1;
                    component_sign = component_sign(randperm(n_vox));
                else
                    median_dist = median(region_dist);
                    component_sign = ones(n_vox, 1);
                    component_sign(region_dist <= median_dist) = -1;
                end

                % Shape variation:
                % - covarying ROIs share the same subject-level shape shift
                % - non-covarying ROIs have independent shape shifts
                if ismember(region_idx, covarying_roi_indices)
                    shape_delta = base_shape_delta + shared_shape_shift + 0.005 * randn();
                else
                    shape_delta = base_shape_delta + indep_shape_shift_std * randn();
                end

                shape_delta = min(max(shape_delta, min_shape_delta), max_shape_delta);

                roi_probs = target_gm_mean ...
                    + shape_delta * component_sign ...
                    + voxel_noise_std * randn(n_vox, 1);

                % Re-centre the ROI to the same target mean.
                % This suppresses mean-level differences while preserving PDF-shape differences.
                roi_probs = match_mean_within_bounds(roi_probs, target_gm_mean, 0, 1);

                gm_prob_data(region_mask) = single(roi_probs);
                realized_gmprob_means(region_idx) = mean(roi_probs);
            end

            %% Save GM probability NIfTI
            gm_file = fullfile(anat_dir, sprintf('%s_%s_GMprob.nii', subject_id, session_id));
            niftiwrite(single(gm_prob_data), gm_file, gm_info);
            fprintf('Saved GM probability NIfTI file: %s\n', gm_file);

            %% Compute and save GM probability ROI PDFs
            gm_pdf_matrix = compute_roi_pdf_matrix(gm_prob_data, atlas_data, region_labels, gm_pdf_edges);
            gm_pdf_file = fullfile(pdf_gmprob_dir, sprintf('%s_%s_GMprob_pdf.xlsx', subject_id, session_id));
            save_subject_pdf_xlsx(gm_pdf_matrix, gm_pdf_file);
            fprintf('Saved GM probability ROI PDF matrix to: %s\n', gm_pdf_file);

            %% Add row to VOI table
            all_vois_cell = [all_vois_cell; {subject_id, row_label, row_notes, age, sex, education}];

            %% Add row to GM probability means table
            gmprob_row = num2cell(realized_gmprob_means);
            all_gmprob_means_cell = [all_gmprob_means_cell; {subject_id, row_label, row_notes, gmprob_row{:}}];
        end
    end

    %% Save combined VOI table
    vois_file_path = fullfile(reference_dir, 'group_gmprob.vois.xlsx');
    vois_table = cell2table(all_vois_cell(2:end, :), 'VariableNames', all_vois_cell(1, :));
    writetable(vois_table, vois_file_path);
    fprintf('Saved VOIs to: %s\n', vois_file_path);

    %% Save GM probability means table
    gmprob_means_file = fullfile(reference_dir, 'group_roi_means_gmprob.xlsx');
    writecell(all_gmprob_means_cell, gmprob_means_file);
    fprintf('Saved GM probability ROI means to: %s\n', gmprob_means_file);

    %% Save covarying ROI information
    covarying_file_path = fullfile(reference_dir, 'groundtruth_covarying_rois_gmprob.xlsx');
    covarying_table = cell2table(covarying_info(2:end, :), 'VariableNames', covarying_info(1, :));
    writetable(covarying_table, covarying_file_path);
    fprintf('Saved covarying ROI information to: %s\n', covarying_file_path);
end

function [age, sex, education] = get_subject_metadata_or_random(reference_dir, subject_id, sex_options, education_range)
% Try to load metadata from reference_data/group_pet.vois.xlsx.
% If not available, generate random fallback values.

    pet_vois_file = fullfile(reference_dir, 'group_pet.vois.xlsx');

    if isfile(pet_vois_file)
        pet_vois = readtable(pet_vois_file, 'TextType', 'string');

        required_cols = {'ID', 'Age', 'Sex', 'Education'};
        if all(ismember(required_cols, pet_vois.Properties.VariableNames))
            row_idx = find(string(pet_vois.ID) == string(subject_id), 1, 'first');

            if ~isempty(row_idx)
                age = pet_vois.Age(row_idx);
                sex = char(pet_vois.Sex(row_idx));
                education = pet_vois.Education(row_idx);
                return
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
        region_mask = (atlas_data == region_labels(region_idx));
        values = double(volume_data(region_mask));

        if isempty(values) || all(isnan(values))
            pdf_matrix(:, region_idx) = NaN;
            continue;
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

function values = match_mean_within_bounds(values, target_mean, lower_bound, upper_bound)
% MATCH_MEAN_WITHIN_BOUNDS
% Re-centre values to target_mean while keeping them inside fixed bounds.
%
% This is used to preserve ROI mean values while allowing the PDF shape to vary.

    values = double(values);

    for i = 1:5
        values = values - mean(values, 'omitnan') + target_mean;
        values = min(max(values, lower_bound), upper_bound);
    end
end
