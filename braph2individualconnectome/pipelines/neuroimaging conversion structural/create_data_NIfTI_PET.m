function create_data_NIfTI_PET(atlas_path, output_dir, group_names, num_files_per_group, seed, covarying_roi_indices)
% CREATE_DATA_NIFTI_PET
% Generate PET-specific simulated NIfTI data with ROI-level SUVR ground truth.
%
% Inputs:
%   atlas_path            - path to atlas NIfTI file
%   output_dir            - output directory
%   group_names           - group names
%   num_files_per_group   - number of subjects per group
%   seed                  - random seed
%   covarying_roi_indices - ROI indices designed to covary; if empty, the first 20 non-reference ROIs are used
%
% Default behavior:
%   - 1 group
%   - 10 subjects
%   - first 20 non-reference ROIs are designed to covary
%   - BIDS-like folder structure: sub-XXXX/ses-01/pet
%   - 1 VOI Excel file with subject metadata only
%   - 1 Excel file with subject-wise ROI SUVR means
%   - 1 Excel file describing which ROIs are designed to covary together
%   - 1 Excel file describing the whole-cerebellum reference ROIs
%   - 1 folder with per-subject ROI PDF matrices
%
% Outputs in reference_data:
%   - group_pet.vois.xlsx
%   - group_roi_means_pet.xlsx
%   - groundtruth_covarying_rois_pet.xlsx
%   - groundtruth_reference_rois.xlsx
%   - group_pdf_bins_pet.xlsx
%   - pdf_pet/
%
% Outputs per subject:
%   - sub-XXXX/ses-01/pet/sub-XXXX_ses-01_pet.nii
%
% Notes:
%   - The saved PET image is an SUVR-like image, not raw uptake.
%   - SUVR is computed by dividing the simulated raw uptake image by the
%     subject-specific mean uptake in the whole-cerebellum reference region.
%   - ROI column names in group_roi_means_pet.xlsx are taken from
%     aal120_atlas_mapping.csv.
%   - The ground-truth ROI SUVR means are exact only under the assumption
%     that ROI averaging is performed on voxel supports matching the
%     simulated PET regional support exactly. In practice, this corresponds
%     to using a perfectly aligned gray-matter probability mask whose
%     effective threshold preserves the same contributing voxels.
%   - Per-subject PDF matrices are saved with:
%       rows    = common PDF bins
%       columns = ROIs in atlas order

    %% Defaults
    if nargin < 1 || isempty(atlas_path)
        atlas_path = fullfile( ...
            fileparts(which('create_data_NIfTI_PET')), ...
            'example atlases NIfTI', ...
            'aal120_atlas.nii' ...
            );
    end
    if nargin < 2 || isempty(output_dir)
        output_dir = fullfile(fileparts(which('create_data_NIfTI_PET')), 'Example data NIfTI');
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

    existing_pet_files = dir(fullfile(output_dir, 'sub-*', 'ses-*', 'pet', '*_pet.nii'));

    if ~isempty(existing_pet_files)
        fprintf('PET NIfTI files already exist. Skipping PET data generation in: %s\n', output_dir);
        return
    end

    reference_dir = fullfile(output_dir, 'reference_data');
    if ~isfolder(reference_dir)
        mkdir(reference_dir);
    end

    pdf_pet_dir = fullfile(reference_dir, 'pdf_pet');
    if ~isfolder(pdf_pet_dir)
        mkdir(pdf_pet_dir);
    end

    %% Load atlas
    fprintf('Loading atlas from %s...\n', atlas_path);
    atlas_info = niftiinfo(atlas_path);
    atlas_data = niftiread(atlas_path);

    region_labels = unique(atlas_data(:));
    region_labels(region_labels == 0) = [];
    num_regions = numel(region_labels);

    fprintf('Number of brain regions: %d\n', num_regions);

    %% Load atlas mapping CSV
    mapping_csv = fullfile(fileparts(atlas_path), 'aal120_atlas_mapping.csv');
    if ~isfile(mapping_csv)
        error('Mapping CSV not found: %s', mapping_csv);
    end

    mapping_table = readtable(mapping_csv, 'TextType', 'string');

    if width(mapping_table) < 4
        error('aal120_atlas_mapping.csv must have at least 4 columns: index, full region name, atlas label, short region name.');
    end

    mapping_full_names  = string(mapping_table{:, 2});  % Var2 = full region name
    mapping_labels      = mapping_table{:, 3};          % Var3 = atlas numeric code
    mapping_short_names = string(mapping_table{:, 4});  % Var4 = short ROI code

    %% Build ROI names aligned to atlas labels
    roi_names = strings(1, num_regions);       % short names for Excel headers
    roi_full_names = strings(1, num_regions);  % full names for logic

    for i = 1:num_regions
        idx = find(double(mapping_labels) == double(region_labels(i)), 1, 'first');
        if isempty(idx)
            roi_names(i) = "Region_" + string(region_labels(i));
            roi_full_names(i) = "Region_" + string(region_labels(i));
        else
            roi_names(i) = mapping_short_names(idx);
            roi_full_names(i) = mapping_full_names(idx);
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

    fprintf('ROI name/order check passed: aal120_atlas.xlsx matches roi_means_table headers.\n');

    %% Define whole-cerebellum reference regions
    is_reference_roi = contains(lower(roi_full_names), "cerebel") | ...
                       contains(lower(roi_full_names), "cerebell") | ...
                       contains(lower(roi_full_names), "vermis");

    reference_roi_indices = find(is_reference_roi);

    if isempty(reference_roi_indices)
        error('No cerebellar reference ROIs found in aal120_atlas_mapping.csv.');
    end

    fprintf('Number of whole-cerebellum reference ROIs: %d\n', numel(reference_roi_indices));

    %% Validate or set covarying ROI indices
    if isempty(covarying_roi_indices)
        covarying_roi_indices = 1:min(20, num_regions);
    else
        covarying_roi_indices = unique(covarying_roi_indices(:))';

        if any(covarying_roi_indices < 1) || any(covarying_roi_indices > num_regions)
            error('covarying_roi_indices must contain ROI indices between 1 and %d.', num_regions);
        end
    end

    % Reference ROIs should not be part of the covarying disease-like PET block
    covarying_roi_indices = setdiff(covarying_roi_indices, reference_roi_indices);

    if isempty(covarying_roi_indices)
        error('No valid non-reference covarying ROIs remain after removing reference ROIs.');
    end

    fprintf('Number of covarying non-reference ROIs: %d\n', numel(covarying_roi_indices));

    %% Headers
    vois_headers = {'ID', 'Label', 'Notes', 'Age', 'Sex', 'Education'};
    roi_mean_headers = [{'ID', 'Label', 'Notes'}, cellstr(roi_names)];

    %% Simulation design

    % Raw uptake scale before SUVR normalization
    raw_ref_mean = 10.0;      % mean raw uptake in reference region
    raw_ref_std  = 1.0;       % voxel-level std in reference region

    raw_nonref_base_mean = 10.5;  % baseline non-reference mean, giving SUVR ~1.0 after normalization
    raw_nonref_base_std  = 3.0;   % voxel-level std in non-reference regions

    shared_sd = 2.5;          % strength of shared latent factor for covarying ROIs
    indep_sd  = 1.5;          % between-subject variation for independent ROIs

    %% PET NIfTI header
    pet_info = atlas_info;
    pet_info.Datatype = 'single';
    pet_info.BitsPerPixel = 32;

    %% PET PDF settings
    pet_pdf_edges = linspace(0, 3, 101);  % 100 bins
    pet_pdf_bin_centers = (pet_pdf_edges(1:end-1) + pet_pdf_edges(2:end)) / 2;

    %% Save PET PDF bin centres
    pet_pdf_bins_file = fullfile(reference_dir, 'group_pdf_bins_pet.xlsx');
    writecell([{'BinCenter'}; num2cell(pet_pdf_bin_centers(:))], pet_pdf_bins_file);
    fprintf('Saved PET PDF bin centres to: %s\n', pet_pdf_bins_file);

    %% Global tables
    all_vois_cell = vois_headers;
    all_roi_means_cell = roi_mean_headers;

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

    reference_info = cell(numel(reference_roi_indices) + 1, 3);
    reference_info(1, :) = {'RegionIndex', 'RegionLabel', 'RegionName'};
    for k = 1:numel(reference_roi_indices)
        r = reference_roi_indices(k);
        reference_info(k + 1, :) = {r, region_labels(r), roi_names(r)};
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
            pet_dir = fullfile(sub_dir, 'pet');

            if ~isfolder(pet_dir)
                mkdir(pet_dir);
            end

            % Subject label/note fields
            row_label = sprintf('Label %d', global_subject_counter);
            row_notes = sprintf('Note %d', global_subject_counter);

            % Demographics
            age = randi([18, 90]);
            sex = sex_options{randi(numel(sex_options))};
            education = randi(education_range);

            % Initialize subject data in raw uptake space
            raw_data = zeros(size(atlas_data), 'single');
            realized_means_all_regions = zeros(1, num_regions);

            % Shared latent effect for covarying ROI block
            shared_latent = shared_sd * randn();

            % Build ROI target mean vector in raw uptake space
            target_means_all_regions = zeros(1, num_regions);
            for region_idx = 1:num_regions
                if ismember(region_idx, reference_roi_indices)
                    target_mean = raw_ref_mean + raw_ref_std * randn();
                elseif ismember(region_idx, covarying_roi_indices)
                    target_mean = raw_nonref_base_mean + shared_latent + 0.5 * randn();
                else
                    target_mean = raw_nonref_base_mean + indep_sd * randn();
                end

                target_mean = max(target_mean, 0.1);
                target_means_all_regions(region_idx) = target_mean;
            end

            % Generate raw uptake voxel values region by region
            for region_idx = 1:num_regions
                label = region_labels(region_idx);
                region_mask = (atlas_data == label);
                n_vox = nnz(region_mask);

                if n_vox == 0
                    continue;
                end

                if ismember(region_idx, reference_roi_indices)
                    std_val = raw_ref_std;
                else
                    std_val = raw_nonref_base_std;
                end

                mean_val = target_means_all_regions(region_idx);

                simulated_values = mean_val + std_val * randn(n_vox, 1);
                simulated_values = max(simulated_values, 0);  % PET-like nonnegative raw uptake

                raw_data(region_mask) = single(simulated_values);
            end

            % Compute whole-cerebellum reference mean from raw uptake
            reference_mask = false(size(atlas_data));
            for rr = reference_roi_indices
                reference_mask = reference_mask | (atlas_data == region_labels(rr));
            end

            reference_values = raw_data(reference_mask);
            reference_mean = mean(reference_values);

            if reference_mean <= 0 || isnan(reference_mean)
                error('Invalid reference mean encountered for subject %s.', subject_id);
            end

            % Convert raw uptake image to SUVR image
            simulated_data = raw_data / single(reference_mean);

            % Extract realized ROI means from SUVR image
            for region_idx = 1:num_regions
                label = region_labels(region_idx);
                region_mask = (atlas_data == label);

                if nnz(region_mask) == 0
                    realized_means_all_regions(region_idx) = NaN;
                    continue;
                end

                realized_means_all_regions(region_idx) = mean(simulated_data(region_mask));
            end

            %% Save PET SUVR NIfTI
            pet_file = fullfile(pet_dir, sprintf('%s_%s_pet.nii', subject_id, session_id));
            niftiwrite(single(simulated_data), pet_file, pet_info);
            fprintf('Saved PET SUVR NIfTI file: %s\n', pet_file);

            %% Compute and save PET ROI PDFs
            pet_pdf_matrix = compute_roi_pdf_matrix(simulated_data, atlas_data, region_labels, pet_pdf_edges);
            pet_pdf_file = fullfile(pdf_pet_dir, sprintf('%s_%s_pet_pdf.xlsx', subject_id, session_id));
            save_subject_pdf_xlsx(pet_pdf_matrix, pet_pdf_file);
            fprintf('Saved PET ROI PDF matrix to: %s\n', pet_pdf_file);

            %% Add row to VOI table
            all_vois_cell = [all_vois_cell; {subject_id, row_label, row_notes, age, sex, education}];

            %% Add row to ROI means table
            roi_means_row = num2cell(realized_means_all_regions);
            all_roi_means_cell = [all_roi_means_cell; {subject_id, row_label, row_notes, roi_means_row{:}}];
        end
    end

    %% Save combined VOI table
    vois_file_path = fullfile(reference_dir, 'group_pet.vois.xlsx');
    vois_table = cell2table(all_vois_cell(2:end, :), 'VariableNames', all_vois_cell(1, :));
    writetable(vois_table, vois_file_path);
    fprintf('Saved VOIs to: %s\n', vois_file_path);

    %% Save ROI means table
    roi_means_file_path = fullfile(reference_dir, 'group_roi_means_pet.xlsx');
    writecell(all_roi_means_cell, roi_means_file_path);
    fprintf('Saved ROI means to: %s\n', roi_means_file_path);

    %% Save covarying ROI information
    covarying_file_path = fullfile(reference_dir, 'groundtruth_covarying_rois_pet.xlsx');
    covarying_table = cell2table(covarying_info(2:end, :), 'VariableNames', covarying_info(1, :));
    writetable(covarying_table, covarying_file_path);
    fprintf('Saved covarying ROI information to: %s\n', covarying_file_path);

    %% Save reference ROI information
    reference_file_path = fullfile(reference_dir, 'groundtruth_reference_rois.xlsx');
    reference_table = cell2table(reference_info(2:end, :), 'VariableNames', reference_info(1, :));
    writetable(reference_table, reference_file_path);
    fprintf('Saved reference ROI information to: %s\n', reference_file_path);
end

%% Helper functions
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
