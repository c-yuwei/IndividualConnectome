%% ¡header!
SUVRConstructor < ConcreteElement (roic, SUVR analysis constructor) calculates mean SUVR value of brain ROIs per subject.

%%% ¡description!
SUVRConstructor calculates mean value of brain ROIs. It loads the brain atlas for ROI identification,
 and ROI wisely calculate mean value.

%%% ¡seealso!
Group, SubjectNIfTI, ExporterGroupSubjectCON_XLS, SubjectST

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject ROI constructor for Nifti.
%%%% ¡default!
'SUVRConstructor'

%%% ¡prop!
NAME (constant, string) is the name of the subject ROI constructor for Nifti.
%%%% ¡default!
'SUVR Constructor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject ROI constructor for Nifti.
%%%% ¡default!
'SUVRConstructor calculates a group of subjects mean value of ROI from imaging data from a series of Nifti file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject ROI constructor for Nifti.
%%%% ¡settings!
'SUVRConstructor'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject ROI constructor for Nifti.
%%%% ¡default!
'SUVRConstructor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of subject ROI constructor for Nifti.
%%%% ¡default!
'SUVRConstructor label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about subject ROI constructor for Nifti.
%%%% ¡default!
'SUVRConstructor notes'

%% ¡props!

%%% ¡prop!
REF_REGION_LIST (data, cell) is the list containing the label list of reference region of brain Atlas for ROI constructor.

%%% ¡prop!
ATLAS_KIND (parameter, stringlist) is the directory containing the Atlas needed for ROI analysis.
%%% ¡default!
{"aal90","TD"}

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
ATLAS_INDEX (parameter, scalar) is the index of the atlas defined by the user for SUVR ROI list.
%%%% ¡default!
1;

% %%% ¡prop! % yuwei check this
% ATLAS_SUVR_LABEL (parameter, option) is the atlas defined by the user for SUVR ROI list, selected from ATLAS_KIND.
% %%%% ¡settings!
% roic.get('ATLAS_KIND')
% %%%% ¡default!
% roic.get('ATLAS_KIND'){1} % Default to the first atlas in ATLAS_KIND

%%% ¡prop!
ATLAS_PATH_DICT (parameter, idict) is the directory containing the Atlas needed for ROI analysis.

%%% ¡prop!
GR_PET (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectNIfTI')

%%% ¡prop!
GR_T1 (data, item) is the subject group, which also defines the subject class SubjectNIfTI.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectNIfTI')

%%% ¡prop!
SUVR_REGION_SELECTION (parameter, stringlist) is the list of selected brain regions.
%%%% ¡default!
{}
%%%% ¡postprocessing!
ba = roic.get('BA'); % Ensure brain atlas is obtained correctly
if isempty(roic.get('SUVR_REGION_SELECTION')) && ~isempty(ba.get('BR_DICT').get('IT_LIST'))
    regions = ba.get('BR_DICT').get('LENGTH');
    IT_LIST = cell(regions, 1); % Preallocate cell array
    for i = 1:regions
        IT_LIST{i} = ba.get('BR_DICT').get('IT', i).get('ID'); % Correct appending
    end
    roic.set('SUVR_REGION_SELECTION', IT_LIST)
end



%%% ¡prop!
CALC_SUBJ_SUVR (query, cell) generates suvr vectors per subject using subject PET and T1 data.
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

% contrain my pet data within the T1 data
masked_pet_data = pet_data{1}.* int16(t1_data_union_mask);

% calculate suvr for ref region

atlas_directories = roic.get('ATLAS_PATH_DICT').get('IT_LIST');
atlas_kind = roic.get('ATLAS_KIND');
Ref_list = roic.get('REF_REGION_LIST');
atlas_suvr_index = roic.get('ATLAS_INDEX');
for directory_index = 1: length(atlas_directories)
    directory_dict = atlas_directories{directory_index};
    directory_path = directory_dict.get('PATH');
    atlas{directory_index} = niftiread(directory_path);
    ref_region_masks{directory_index} = ismember(atlas{directory_index} ,Ref_list{directory_index});
end
ref_region_union_mask = ref_region_masks{1};
for i = 2:length(ref_region_masks)
    ref_region_union_mask = ref_region_union_mask | ref_region_masks{i};
end
ref_region_meanvalue = mean(masked_pet_data(ref_region_union_mask));

% atlas_index = find(contains(atlas_kind{atlas_suvr{1}}));% here user can define refine the atlas_suvr option
% atlas_roi = atlas{atlas_index};
atlas_roi = atlas{atlas_suvr_index};
% calculate normalized suvr for all unique regions
ROI_list = unique(atlas_roi);
ROI_list = ROI_list(ROI_list>0);% remove background which is represented by label "0"
for roi_list_index = 1:length(ROI_list)
    roi_index = ROI_list(roi_list_index);
    roi_mask = atlas_roi==roi_index;
    roi_data = masked_pet_data.*int16(roi_mask);
    roi(roi_list_index) = mean(roi_data(roi_data>0))/ref_region_meanvalue;
end

value = roi';

%%% ¡prop!
GR (result, item) is a group of subjects with SUVR analysis data.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))
%%%% ¡calculate!
% creates empty Group
gr_suvr = Group( ...
    'SUB_CLASS', 'SubjectST', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
    );

gr_suvr.lock('SUB_CLASS');

gr_T1 = roic.get('GR_T1');% subject from Nifti
gr_PET = roic.get('GR_PET');% subject from Nifti


wb = braph2waitbar(roic.get('WAITBAR'), 0, ['Calculating SUVR for subjects ...']);
% adds subjects
sub_dict = gr_suvr.memorize('SUB_DICT');
for i = 1:1:gr_PET.get('SUB_DICT').get('LENGTH')
    % braph2waitbar(wb, .15 + .85 * i / gr_sub.get('SUB_DICT').get('LENGTH'), ['Loading subject directory' num2str(i) ' of ' num2str(length(files)) ' ...'])
    sub_id_t1 = gr_T1.get('SUB_DICT').get('IT', i).get('ID');% subject ID
    sub_id_pet = gr_PET.get('SUB_DICT').get('IT', i).get('ID');% subject ID

    if isequal(sub_id_t1, sub_id_pet)
        t1_path = gr_T1.get('SUB_DICT').get('IT', i).get('NIFTI_PATH_DICT').get('IT_LIST');% subject T1 data path
        pet_path = gr_PET.get('SUB_DICT').get('IT', i).get('NIFTI_PATH_DICT').get('IT_LIST');% subject PET data path
        for j = 1:length(pet_path)
            pet_data{j} = niftiread(pet_path{j}.get('PATH'));
        end

        for j = 1:length(t1_path)
            t1_data{j} = niftiread(t1_path{j}.get('PATH'));
        end
        SUVR = roic.get('CALC_SUBJ_SUVR', pet_data, t1_data);

        % use aal2 with 90 regions, update a list with brain regions of aal120 (stringlist)
        ba = roic.get('BA');

        % Get the number of brain regions in the atlas
        num_regions = ba.get('BR_DICT').get('LENGTH');

        % Initialize a cell array to store the names of the brain regions
        region_names = cell(num_regions, 1);

        % Iterate through each region and get its name
        for j = 1:ba.get('BR_DICT').get('LENGTH')
            % Get the brain region element from the BrainAtlas
            brain_region = ba.get('BR_DICT').get('IT', j);

            % Get the name of the brain region
            region_names{j} = brain_region.get('ID');
        end

        selected_suvr_region = roic.get('SUVR_REGION_SELECTION');
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
            'LABEL', ['Subejct ST ' int2str(i)], ...
            'NOTES', ['Notes on subject ST ' int2str(i)], ...
            'BA', roic.get('BA'),...
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
if ~exist(example_data_dir, 'dir')
    create_example_NIfTI([], example_data_dir);
end

im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [which('aal94_atlas.xlsx')], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Read the VOIs file while preserving original column headers
vois_table = readtable(vois_file, 'VariableNamingRule', 'preserve');

im_gr1_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY',[example_data_dir filesep 'Group1'], ...
    'NIFTI_TYPE', {'T1'},...
    'WAITBAR', true);
gr1_WM_GM = im_gr1_WM_GM.get('GR');

im_gr1_PET = ImporterGroupSubjNIfTI('DIRECTORY', [example_data_dir filesep 'Group1'], ...
    'NIFTI_TYPE', {'PET'},...
    'WAITBAR', true);
gr1_PET = im_gr1_PET.get('GR');

path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('upsampled_AAL2.nii'))} ...
    );

% suvr_brain_label = readtable('group_data/test/atlas/AAL2_Atlas_Labels.csv');
% suvr_brain_label = suvr_brain_label.Var4;
ref_region_list = [2001];% reference region label
gr = SUVRConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{ref_region_list}, ...
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
region_col_idx = find(contains(headers, strcat(string(ref_region_list),'_Mean')));


% Extract Region means for all subjects
region_means = table2array(vois_table(2:end, region_col_idx));

expected_subject_ids = vois_table.("Subject ID")(2:end); % Assuming 'SubjectID' column exists
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
