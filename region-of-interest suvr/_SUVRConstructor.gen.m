%% ¡header!
SUVRConstructor < ConcreteElement (roic, SUVR analysis constructor) calculates mean SUVR value of brain ROIs per subject.

%%% ¡description!
SUVRConstructor calculates mean value of brain ROIs. It loads brain atlases for ROI identification and calculates mean SUVR values per subject, supporting multiple atlases with region-index mappings loaded from CSV files.

%%% ¡seealso!
Group, SubjectNIfTI, ExporterGroupSubjectCON_XLS, SubjectST, NNDatasetSplit

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.ID
%%%% ¡title!
SUVR Constructuor ID

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.LABEL
%%%% ¡title!
SUVR Constructuor LABEL

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.REF_BR_DICT
%%%% ¡title!
Referece Regions

% %%% ¡prop!
% %%%% ¡id!
% SUVRConstructor.ATLAS_KIND
% %%%% ¡title!
% Included Atlases
% 
% %%% ¡prop!
% %%%% ¡id!
% SUVRConstructor.ATLAS_INDEX
% %%%% ¡title!
% Based Atlas

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.BA
%%%% ¡title!
Brain Atlas

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.ATLAS_PATH_DICT
%%%% ¡title!
Brain Atlas File Locations

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.GR_PET
%%%% ¡title!
Group PET

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.GR_T1
%%%% ¡title!
Group T1

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.SUVR_REGION_SELECTION
%%%% ¡title!
Select Regions for Calculating SUVR

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.GR
%%%% ¡title!
Group SUVR

%%% ¡prop!
%%%% ¡id!
SUVRConstructor.NOTES
%%%% ¡title!
SUVR Constructuor NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject ROI constructor for NIfTI.
%%%% ¡default!
'SUVRConstructor'

%%% ¡prop!
NAME (constant, string) is the name of the subject ROI constructor for NIfTI.
%%%% ¡default!
'SUVR Constructor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject ROI constructor for NIfTI.
%%%% ¡default!
'SUVRConstructor calculates a group of subjects mean value of ROI from imaging data from a series of NIfTI files.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject ROI constructor for NIfTI.
%%%% ¡settings!
'SUVRConstructor'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject ROI constructor for NIfTI.
%%%% ¡default!
'SUVRConstructor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of subject ROI constructor for NIfTI.
%%%% ¡default!
'SUVRConstructor label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about subject ROI constructor for NIfTI.
%%%% ¡default!
'SUVRConstructor notes'

%% ¡props!

%%% ¡prop!
BA (data, itemlist) is a list of brain atlases.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
ATLAS_REGION_IDS (data, stringlist) is the list of region IDs for multiple atlases.
%%%% ¡default!
{} % Default to an empty cell array


%%% ¡prop!
ATLAS_LABELS (data, cell) is the list of string labels for multiple atlases.
%%%% ¡default!
{} % Default to an empty cell array


%%% ¡prop!
MAPPING_PATH_DICT (data, idict) is the dictionary of paths to CSV files for region-index mappings.
%%%% ¡settings!
'FILE_PATH'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'FILE_PATH')
%%%% ¡postset!
if roic.get('MAPPING_PATH_DICT').get('LENGTH') > 0
    mapping_files = roic.get('MAPPING_PATH_DICT').get('IT_LIST');
    atlas_region_ids = cell(1, length(mapping_files));
    atlas_labels = cell(1, length(mapping_files));
    for atlas_idx = 1:length(mapping_files)
        file_path = mapping_files{atlas_idx}.get('PATH');
        if ~isfile(file_path)
            warning('File not found: %s. Skipping atlas %d.', file_path, atlas_idx);
            atlas_region_ids{atlas_idx} = {};
            atlas_labels{atlas_idx} = {};
            continue;
        end
        atlas_data = readtable(file_path, 'FileType', 'text');
        if size(atlas_data, 2) < 2
            warning('CSV file %s lacks 2 columns. Skipping atlas %d.', file_path, atlas_idx);
            atlas_region_ids{atlas_idx} = {};
            atlas_labels{atlas_idx} = {};
            continue;
        end
        % Split data into numeric IDs and string labels
        region_ids = atlas_data{:, 2}; % Numeric indices
        labels = atlas_data{:, 1};          % String labels
        atlas_region_ids{atlas_idx} = region_ids; % Cell array of numeric IDs
        atlas_labels{atlas_idx} = labels;                    % String array of labels
    end
    % Assuming atlas_region_ids is a cell array of column vectors
    atlas_region_ids_list = cell(1, length(atlas_region_ids)); % Preallocate a cell array
    for i = 1:length(atlas_region_ids)
        atlas_region_ids_list{i} = atlas_region_ids{i}'; % Transpose each column vector to a row vector
    end
    all_region_ids = [atlas_region_ids_list{:}]; % Concatenate all row vectors horizontally

    all_atlas_labels_list = cell(1, length(atlas_labels)); % Preallocate a cell array
    for i = 1:length(atlas_labels)
        all_atlas_labels_list{i} = atlas_labels{i}'; % Transpose each column vector to a row vector
    end
    all_atlas_labels = [all_atlas_labels_list{:}];
    all_atlas_labels = num2cell(all_atlas_labels);
    roic.set('ATLAS_REGION_IDS', all_region_ids);
    roic.set('ATLAS_LABELS', all_atlas_labels);
end

%%% ¡prop!
REF_REGION_LIST (data, cell) is the list containing the indices of reference regions for each atlas.
%%%% ¡default!
{}
%%%% ¡postset!
if ~isempty(roic.get('REF_REGION_LIST'))
    ba_list = roic.get('BA');
    ref_region_list = roic.get('REF_REGION_LIST');
    region_ids = roic.get('ATLAS_REGION_IDS');
    labels = roic.get('ATLAS_LABELS');
    ref_br_list = cell(0); % Initialize an empty cell array for reference brain regions
    % Iterate over each atlas in ref_region_list
    for atlas_idx = 1:length(ref_region_list)
        ba = ba_list{atlas_idx}; % Get the BrainAtlas for this atlas index
        br_dict = ba.get('BR_DICT');       % Get the brain region dictionary for this atlas
        indices = ref_region_list{atlas_idx}; % Numeric indices for this atlas
        % Iterate over each index in the current atlas's reference list
        for idx = 1:length(indices)
            % Find the position of the numeric index in region_ids
            pos = find(cellfun(@(x) x == indices(idx), labels));
            if ~isempty(pos)
                % Get the corresponding label using the position
                label = labels{pos}; % Access as cell element since labels is a cell array
                region_id = region_ids{pos};
                if ~isempty(region_id)
                    br = br_dict.get('IT', region_id); % Retrieve the brain region
                    ref_br_list{end+1} = br; % Add to the list
                end
            end
        end
    end
    if isempty(roic.get('REF_BR_DICT').get('IT_LIST'))
        % Set the REF_BR_DICT with the list of reference brain regions
        roic.set('REF_BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', ref_br_list));
    end
end

%%% ¡prop!
REF_BR_DICT (data, idict) contains the effective brain regions of the simulated network.
%%%% ¡settings!
'BrainRegion'
%%%% ¡postset!
Ref_region_list = roic.get('REF_REGION_LIST');
selected_br = roic.get('REF_BR_DICT').get('IT_LIST'); % List of selected BrainRegion objects
ba_list = roic.get('BA');
region_ids = roic.get('ATLAS_REGION_IDS');
labels = roic.get('ATLAS_LABELS');
ref_region_list = cell(length(ba_list), 1); % One cell per atlas
for atlas_idx = 1:length(ba_list)
    ba = ba_list{atlas_idx};
    br_dict = ba.get('BR_DICT');
    atlas_br_ids = cellfun(@(br) br.get('ID'), br_dict.get('IT_LIST'), 'UniformOutput', false);
    selected_br_ids = cellfun(@(br) br.get('ID'), selected_br, 'UniformOutput', false);
    [~, loc] = ismember(selected_br_ids, atlas_br_ids); % Find matches
    idx = find(loc > 0); % Indices of matches
    selected_br_ids = selected_br_ids(idx);
    if ~isempty(idx)
        [~, loc] = ismember(selected_br_ids, region_ids);
        ref_region = labels(loc);
        ref_region_list{atlas_idx} =  [ref_region{:}];
    end
end
if isempty(Ref_region_list)
    roic.set('REF_REGION_LIST', ref_region_list);
end
%%%% ¡gui!
pr = SUVRConstructorPP_BR_DICT('EL', roic, 'PROP', SUVRConstructor.REF_BR_DICT, ...
    'WAITBAR', roic.getCallback('WAITBAR'), ...
    varargin{:});

%%% ¡prop!
ATLAS_KIND (parameter, stringlist) is the list of atlas types needed for ROI analysis.
%%%% ¡default!
{"aal90", "TD"}

%%% ¡prop!
ATLAS_INDEX (parameter, scalar) is the index of the atlas defined by the user for SUVR ROI list.
%%%% ¡default!
1
%%%% ¡postset!
ba_list = roic.get('BA'); % Ensure brain atlas is obtained correctly
atlas_index = roic.get('ATLAS_INDEX');
ba = ba_list{atlas_index};
if isempty(roic.get('SUVR_REGION_SELECTION').get('IT_LIST')) && ~isempty(ba.get('BR_DICT').get('IT_LIST'))
    roic.set('SUVR_REGION_SELECTION', ba.get('BR_DICT'));
end

%%% ¡prop!
ATLAS_PATH_DICT (parameter, idict) is the dictionary containing the paths to atlas NIfTI files.
%%%% ¡settings!
'FILE_PATH'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'FILE_PATH')

%%% ¡prop!
GR_PET (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectNIfTI')

%%% ¡prop!
GR_T1 (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectNIfTI')

%%% ¡prop!
SUVR_REGION_SELECTION (parameter, idict) is the list of selected brain regions.
%%%% ¡settings!
'BrainRegion'
%%%% ¡gui!
pr = SUVRConstructorPP_BR_DICT('EL', roic, 'PROP', SUVRConstructor.SUVR_REGION_SELECTION, ...
    'WAITBAR', roic.getCallback('WAITBAR'), ...
    varargin{:});

%%% ¡prop!
CALC_SUBJ_SUVR (query, cell) generates SUVR vectors per subject using subject PET and T1 data.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
pet_data = varargin{1};
t1_data = varargin{2};
t1_data_union_mask = t1_data{1} > 0;
for i = 2:length(t1_data)
    t1_data_union_mask = t1_data_union_mask | (t1_data{i}>0);
end

% Constrain PET data within the T1 data
masked_pet_data = pet_data{1} .* int16(t1_data_union_mask);

% Calculate SUVR for reference regions
atlas_directories = roic.get('ATLAS_PATH_DICT').get('IT_LIST');
atlas_kind = roic.get('ATLAS_KIND');
ref_list = roic.get('REF_REGION_LIST');
atlas_suvr_index = roic.get('ATLAS_INDEX');
for directory_index = 1:length(atlas_directories)
    directory_dict = atlas_directories{directory_index};
    directory_path = directory_dict.get('PATH');
    atlas{directory_index} = niftiread(directory_path);
    ref_region_masks{directory_index} = ismember(atlas{directory_index}, ref_list{directory_index});
end
ref_region_union_mask = ref_region_masks{1};
for i = 2:length(ref_region_masks)
    ref_region_union_mask = ref_region_union_mask | ref_region_masks{i};
end
ref_region_meanvalue = mean(masked_pet_data(ref_region_union_mask));

% Calculate normalized SUVR for all unique regions
atlas_roi = atlas{atlas_suvr_index};
ROI_list = unique(atlas_roi);
ROI_list = ROI_list(ROI_list>0); % Remove background (label "0")
for roi_list_index = 1:length(ROI_list)
    roi_index = ROI_list(roi_list_index);
    roi_mask = atlas_roi == roi_index;
    roi_data = masked_pet_data .* int16(roi_mask);
    roi(roi_list_index) = mean(roi_data(roi_data>0)) / ref_region_meanvalue;
end

value = roi';

%%% ¡prop!
GR (result, item) is a group of subjects with SUVR analysis data.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))
%%%% ¡calculate!
% Create empty Group
gr_suvr = Group( ...
    'SUB_CLASS', 'SubjectST', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
);

gr_suvr.lock('SUB_CLASS');

gr_T1 = roic.get('GR_T1'); % Subject from NIfTI
gr_PET = roic.get('GR_PET'); % Subject from NIfTI

wb = braph2waitbar(roic.get('WAITBAR'), 0, ['Calculating SUVR for subjects ...']);
% Add subjects
sub_dict = gr_suvr.memorize('SUB_DICT');
for i = 1:1:gr_PET.get('SUB_DICT').get('LENGTH')
    sub_id_t1 = gr_T1.get('SUB_DICT').get('IT', i).get('ID'); % Subject ID
    sub_id_pet = gr_PET.get('SUB_DICT').get('IT', i).get('ID'); % Subject ID

    if isequal(sub_id_t1, sub_id_pet)
        t1_path = gr_T1.get('SUB_DICT').get('IT', i).get('NIFTI_PATH_DICT').get('IT_LIST'); % Subject T1 data path
        pet_path = gr_PET.get('SUB_DICT').get('IT', i).get('NIFTI_PATH_DICT').get('IT_LIST'); % Subject PET data path
        for j = 1:length(pet_path)
            pet_data{j} = niftiread(pet_path{j}.get('PATH'));
        end

        for j = 1:length(t1_path)
            t1_data{j} = niftiread(t1_path{j}.get('PATH'));
        end
        SUVR = roic.get('CALC_SUBJ_SUVR', pet_data, t1_data);

        % Use atlas with regions, update a list with brain regions
        ba_list = roic.get('BA');
        atlas_suvr_index = roic.get('ATLAS_INDEX');
        ba = ba_list{atlas_suvr_index};
        
        num_regions = ba.get('BR_DICT').get('LENGTH');
        region_names = cell(num_regions, 1);
        for j = 1:ba.get('BR_DICT').get('LENGTH')
            brain_region = ba.get('BR_DICT').get('IT', j);
            region_names{j} = brain_region.get('ID');
        end

        selected_suvr_region = cellfun(@(x) x.get('ID'), roic.get('SUVR_REGION_SELECTION').get('IT_LIST'),'UniformOutput',false);
        matched_indices = [];
        for j = 1:length(region_names)
            match_idx = find(strcmp(selected_suvr_region, region_names{j}));
            if ~isempty(match_idx)
                matched_indices = [matched_indices, match_idx];
            end
        end
        SUVR = SUVR(matched_indices);
        sub = SubjectST( ...
            'ID', sub_id_t1, ...
            'LABEL', ['Subject ST ' int2str(i)], ...
            'NOTES', ['Notes on subject ST ' int2str(i)], ...
            'BA', ba, ...
            'ST', SUVR);
        sub_dict.get('ADD', sub);
        braph2waitbar(wb, .15 + .85 * i / gr_PET.get('SUB_DICT').get('LENGTH'), ['Calculating SUVRs for subject ' num2str(i) ' of ' num2str(gr_PET.get('SUB_DICT').get('LENGTH')) ' ...'])
    end
end

braph2waitbar(wb, 'close')
value = gr_suvr;

%%% ¡prop!
WAITBAR (gui, logical) determines whether to show the waitbar.
%%%% ¡default!
true
%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectCON_XLS.GET_DIR]

%%% ¡test!
%%%% ¡name!
Verify SUVR Calculation from Example Data
%%%% ¡code!
% Generate example data
example_data_dir = fullfile(fileparts(which('SUVRConstructor')), 'Example data Nifti');
% Run the example data creation script
create_example_NIfTI();

im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [which('aal94_atlas.xlsx')], ...
    'WAITBAR', true ...
);

ba = im_ba.get('BA');

% Path to generated VOIs file
vois_file = fullfile(example_data_dir, 'Group1.vois.xlsx');

% Read the VOIs file
vois_table = readtable(vois_file);

im_gr1_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [example_data_dir filesep 'Group1'], ...
    'NIFTI_TYPE', {'T1'}, ...
    'WAITBAR', true);
gr1_WM_GM = im_gr1_WM_GM.get('GR');

im_gr1_PET = ImporterGroupSubjNIfTI('DIRECTORY', [example_data_dir filesep 'Group1'], ...
    'NIFTI_TYPE', {'PET'}, ...
    'WAITBAR', true);
gr1_PET = im_gr1_PET.get('GR');

path_dict = IndexedDictionary( ...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('upsampled_AAL2.nii'))} ...
);

mapping_path_dict = IndexedDictionary( ...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('AAL2_Atlas_Labels.csv'))} ...
);

ref_region_list = {[2001]}; % Reference region label
gr = SUVRConstructor('GR_PET', gr1_PET, ...
    'GR_T1', gr1_WM_GM, ...
    'BA', ba, ...
    'ATLAS_PATH_DICT', path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', ref_region_list, ...
    'ATLAS_KIND', {'AAL2'});
Con_gr = gr.get('GR');

for i = 1:Con_gr.get('SUB_DICT').get('LENGTH')
    subj = Con_gr.get('SUB_DICT').get('IT', i); % Get the subject
    suvr_data = subj.get('ST'); % Get the SUVR data for brain regions
    calculated_means(i, :) = suvr_data;
    calculated_subject_ids{i} = subj.get('ID'); % Store the subject ID
end

% Extract expected means from VOIs table
expected_means = table2array(vois_table(2:end, 5:(4 + length(subj.get('ST')))));

% Extract the headers for region columns
headers = vois_table.Properties.VariableNames;

% Find the column index corresponding to Region
region_col_idx = find(contains(headers, strcat(string(ref_region_list{1}), '_Mean')));

% Extract Region means for all subjects
region_means = table2array(vois_table(2:end, region_col_idx));

expected_subject_ids = vois_table.SubjectID(2:end); % Assuming 'SubjectID' column exists
% Initialize a matrix for reordered means
reordered_calculated_means = zeros(size(expected_means));

% Match and reorder based on subject IDs
for i = 1:length(expected_subject_ids)
    % Find the index of the expected subject ID in calculated_subject_ids
    calculated_idx = find(strcmp(calculated_subject_ids, expected_subject_ids{i}), 1);
    % Reorder calculated means to match expected order
    reordered_calculated_means(i, :) = calculated_means(calculated_idx, :);
end

% Normalize expected means by Region
normalized_means = expected_means ./ region_means;

% Calculate the ratio of matching elements within the threshold
acceptable_threshold = 2; % Define the threshold
difference_ratio = abs(reordered_calculated_means ./ normalized_means); % Element-wise ratio
within_threshold = difference_ratio < acceptable_threshold; % Logical matrix of valid values

% Calculate the percentage of valid values
percentage_within_threshold = sum(within_threshold(:)) / numel(within_threshold) * 100;

% Assert if less than 90% meet the threshold
assert(percentage_within_threshold >= 80, ...
    sprintf('Calculated means do not match expected values. Only %.2f%% are within the threshold.', percentage_within_threshold));

% Compare calculated and expected values
assert(isequal(size(calculated_means), size(normalized_means)), ...
    'Size mismatch between calculated and expected mean values.');