function create_example_NIfTI(atlas_path, output_dir, group_names, num_files_per_group, seed)
    % Function to generate Gaussian-distributed NIfTI files and separate VOIs for two groups
    % Inputs:
    %   atlas_path        - Path to the atlas NIfTI file
    %   output_dir        - Directory to save outputs
    %   group_names       - Names of the two groups
    %   num_files_per_group - Number of subjects per group
    %   seed              - Random seed for reproducibility

    % Set defaults
    if nargin < 1 || isempty(atlas_path)
        atlas_path = which('upsampled_AAL2.nii');  % Default atlas file
    end
    if nargin < 2 || isempty(output_dir)
        output_dir = fullfile(fileparts(which('SubjectNIfTI')), 'Example data Nifti');
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

    % Set random seed
    rng(seed);

    % Load atlas
    fprintf('Loading atlas from %s...\n', atlas_path);
    atlas_info = niftiinfo(atlas_path);
    atlas_data = niftiread(atlas_path);
    atlas_mask = atlas_data > 0;  % Create binary mask

    % Identify unique region labels (excluding 0)
    region_labels = unique(atlas_data(:));
    region_labels(region_labels == 0) = [];  % Exclude background
    num_regions = length(region_labels);
    fprintf('Number of brain regions: %d\n', num_regions);

    % Headers for VOIs
    region_mean_headers = strcat("Region_", string(region_labels), "_Mean");
    region_std_headers = strcat("Region_", string(region_labels), "_Std");
    vois_headers = [{'Subject ID', 'Age', 'Sex', 'Education'}, region_mean_headers{:}, region_std_headers{:}];

    for group_idx = 1:length(group_names)
        group_name = group_names{group_idx};
        group_dir = fullfile(output_dir, group_name);

        % Ensure group directory exists
        if ~isfolder(group_dir)
            mkdir(group_dir);
        end

        % VOIs for the group
        sex_options = {'Female' 'Male'};
        education_range = [8, 20];
        empty_row = cell(1, numel(vois_headers));  % Create a row with the same number of columns as vois_headers
        empty_row{3} = cell2str(sex_options);      % Populate the third column ('Sex') with the options

        % Combine headers and the second row
        vois1 = [vois_headers; empty_row];

        % Generate NIfTI files for the group
        for file_idx = 1:num_files_per_group
            % Generate file name and subdirectory
            sub_id = sprintf('%s_subject_%d', group_name, file_idx);
            sub_folder = fullfile(group_dir, sub_id);
            mkdir(sub_folder);

            % Generate demographic variables
            age = randi([18, 90]);
            sex = sex_options{randi(2)};
            education = randi(education_range);

            % Initialize simulated data
            simulated_data = zeros(size(atlas_data));
            means_all_regions = zeros(1, num_regions);
            stds_all_regions = zeros(1, num_regions);

            % Generate a shared random variable for the first 20 regions (Group 1 only)
            shared_random_variable_mean = abs((rand + 1) * 10);  % Ensure positive shared base mean
            shared_random_variable_std = abs(1 + rand * 2);      % Ensure positive shared base std deviation

            % Generate independent random variables for all regions
            independent_means = abs((rand(num_regions, 1) + 1) * 10);  % Ensure positive independent base means
            independent_stds = abs(1 + rand(num_regions, 1) * 9);      % Ensure positive independent base std deviations
            imax = 10;
            % Generate Gaussian-distributed values for each region
            for region_idx = 1:num_regions
                label = region_labels(region_idx);

                % Random mean and standard deviation
                % mean_val = (rand + 1) * 10 + 1;
                % std_val = 1 + rand * 9;
                
                % if group_idx == 1 && region_idx <= 20
                %     mean_val = mean_val * 10;  % Scale mean by 10
                %     std_val = std_val * 5;
                % end
                if group_idx == 1
                    if region_idx <= 20
                        % High correlation for the first 20 regions in Group 1
                        mean_val = shared_random_variable_mean;% + randn * 2;  % Add slight variation
                        std_val = shared_random_variable_std;% + randn * 0.5;  % Add slight variation
                    else
                        % Weakly correlated (independent) distributions for remaining regions in Group 1
                        mean_val = shared_random_variable_mean * randi(imax) * 5 + 1;  % Use independent mean
                        std_val = shared_random_variable_std * randi(imax) * 10 + 1 ;    % Use independent std deviation
                    end
                else
                    % Independent distributions for all regions in other groups
                    mean_val = independent_means(region_idx);  % Use independent mean
                    std_val = independent_stds(region_idx);    % Use independent std deviation
                end

                % Ensure mean and std are positive
                % mean_val = max(mean_val, 0.1);  % Set a minimum value for the mean (e.g., 0.1)
                % std_val = max(std_val, 0.1);    % Set a minimum value for the std deviation (e.g., 0.1)

                % Store statistics
                means_all_regions(region_idx) = mean_val;
                stds_all_regions(region_idx) = std_val;

                % Apply values to the region mask
                region_mask = (atlas_data == label);
                simulated_values = mean_val + std_val * randn(nnz(region_mask), 1);
                simulated_data(region_mask) = simulated_values;
            end


            simulated_nifti_path = fullfile(sub_folder, [sub_id '_PET.nii']);
            niftiwrite(int16(simulated_data), simulated_nifti_path, atlas_info);
            fprintf('Saved simulated NIfTI file: %s\n', simulated_nifti_path);

            % Save atlas mask NIfTI file using niftiwrite
            mask_nifti_path = fullfile(sub_folder, [sub_id '_T1.nii']);
            niftiwrite(int16(atlas_mask), mask_nifti_path, atlas_info);
            fprintf('Saved atlas mask NIfTI file: %s\n', mask_nifti_path);


            % Add row to VOIs table
            sub_means = num2cell(means_all_regions);
            sub_stds = num2cell(stds_all_regions);
            vois1 = [vois1; {sub_id, age, sex, education, sub_means{:}, sub_stds{:}}];
        end
        im_ba = ImporterBrainAtlasXLS('FILE', which('aal94_atlas.xlsx'));
        ba = im_ba.get('BA');
        ex_ba = ExporterBrainAtlasXLS( ...
            'BA', ba, ...
            'FILE', [fileparts(group_dir) filesep() 'atlas.xlsx'] ...
            );
        ex_ba.get('SAVE')
        % Save VOIs table for the group
        vois_file_path = fullfile(fileparts(group_dir), [group_name '.vois.xlsx']);
        vois_table = cell2table(vois1(2:end, :), 'VariableNames', vois1(1, :));  % Skip second row
        writetable(vois_table, vois_file_path);
        fprintf('Saved VOIs to: %s\n', vois_file_path);
    end
end
