%% ¡header!
PDFConstructor < ConcreteElement (pdfc, PDF analysis constructor) calculates probability density function of brain ROIs per subject.

%%% ¡description!
PDFConstructor calculates probability density function (PDF) of brain ROIs. It loads the brain atlas for ROI identification,
 and brain data to calculate PDF of brain regions.

%%% ¡seealso!
Group, SubjectNIfTI, ExporterGroupSubjectCON_XLS, SubjectST

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
PDFConstructor.ID
%%%% ¡title!
PDF Constructuor ID

%%% ¡prop!
%%%% ¡id!
PDFConstructor.LABEL
%%%% ¡title!
PDF Constructuor LABEL

%%% ¡prop!
%%%% ¡id!
PDFConstructor.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
PDFConstructor.REF_BR_DICT
%%%% ¡title!
Referece Regions

%%% ¡prop!
%%%% ¡id!
PDFConstructor.BA
%%%% ¡title!
Brain Atlas

%%% ¡prop!
%%%% ¡id!
PDFConstructor.ATLAS_PATH_DICT
%%%% ¡title!
Brain Atlas File Locations

%%% ¡prop!
%%%% ¡id!
PDFConstructor.GR_PET
%%%% ¡title!
Group PET

%%% ¡prop!
%%%% ¡id!
PDFConstructor.GR_T1
%%%% ¡title!
Group T1

%%% ¡prop!
%%%% ¡id!
PDFConstructor.PDF_REGION_SELECTION
%%%% ¡title!
Select Regions for Calculating PDF

%%% ¡prop!
%%%% ¡id!
PDFConstructor.GR
%%%% ¡title!
Group PDF

%%% ¡prop!
%%%% ¡id!
PDFConstructor.NOTES
%%%% ¡title!
PDF Constructuor NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject ROI constructor for Nifti.
%%%% ¡default!
'PDFConstructor'

%%% ¡prop!
NAME (constant, string) is the name of the subject ROI constructor for Nifti.
%%%% ¡default!
'PDF Constructor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject ROI constructor for Nifti.
%%%% ¡default!
'PDFConstructor calculates a group of subjects mean value of ROI from imaging data from a series of Nifti file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject ROI constructor for Nifti.
%%%% ¡settings!
'PDFConstructor'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject ROI constructor for Nifti.
%%%% ¡default!
'PDFConstructor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of subject ROI constructor for Nifti.
%%%% ¡default!
'PDFConstructor label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about subject ROI constructor for Nifti.
%%%% ¡default!
'PDFConstructor notes'

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
if pdfc.get('MAPPING_PATH_DICT').get('LENGTH') > 0
    mapping_files = pdfc.get('MAPPING_PATH_DICT').get('IT_LIST');
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
    pdfc.set('ATLAS_REGION_IDS', all_region_ids);
    pdfc.set('ATLAS_LABELS', all_atlas_labels);
end

%%% ¡prop!
REF_REGION_LIST (data, cell) is the list containing the indices of reference regions for each atlas.
%%%% ¡default!
{}
%%%% ¡postset!
if ~isempty(pdfc.get('REF_REGION_LIST'))
    ba_list = pdfc.get('BA');
    ref_region_list = pdfc.get('REF_REGION_LIST');
    region_ids = pdfc.get('ATLAS_REGION_IDS');
    labels = pdfc.get('ATLAS_LABELS');
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
    if isempty(pdfc.get('REF_BR_DICT').get('IT_LIST'))
        % Set the REF_BR_DICT with the list of reference brain regions
        pdfc.set('REF_BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', ref_br_list));
    end
end

%%% ¡prop!
REF_BR_DICT (data, idict) contains the effective brain regions of the simulated network.
%%%% ¡settings!
'BrainRegion'
%%%% ¡postset!
Ref_region_list = pdfc.get('REF_REGION_LIST');
selected_br = pdfc.get('REF_BR_DICT').get('IT_LIST'); % List of selected BrainRegion objects
ba_list = pdfc.get('BA');
region_ids = pdfc.get('ATLAS_REGION_IDS');
labels = pdfc.get('ATLAS_LABELS');
ref_region_list = cell(length(ba_list)); % One cell per atlas
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
if isempty(Ref_region_list) && ~isempty(ref_region_list)
    pdfc.set('REF_REGION_LIST', ref_region_list);
end
%%%% ¡gui!
pr = SUVRConstructorPP_BR_DICT('EL', pdfc, 'PROP', PDFConstructor.REF_BR_DICT, ...
    'WAITBAR', pdfc.getCallback('WAITBAR'), ...
    varargin{:});

% %%% ¡prop!
% ATLAS_KIND (parameter, stringlist) is the directory containing the Atlas needed for ROI analysis.
% %%% ¡default!
% {'aal90','TD'}


%%% ¡prop!
ATLAS_INDEX (parameter, scalar) is the index of the atlas defined by the user for PDF ROI list.
%%%% ¡default!
1;
%%%% ¡postset!
ba_list = pdfc.get('BA'); % Ensure brain atlas is obtained correctly
if isempty(ba_list)
    br = BrainRegion('ID', 'SingleRegion');
    ba = BrainAtlas('ID', 'Atlas', 'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', {br}));
    ba_list = {ba};
end
atlas_index = pdfc.get('ATLAS_INDEX');
ba = ba_list{atlas_index};
if isempty(pdfc.get('PDF_REGION_SELECTION').get('IT_LIST')) && ~isempty(ba.get('BR_DICT').get('IT_LIST'))
    pdfc.set('PDF_REGION_SELECTION', ba.get('BR_DICT'));
end

%%% ¡prop!
ATLAS_PATH_DICT (parameter, idict) is the directory containing the Atlas needed for ROI analysis.
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
PDF_REGION_SELECTION (parameter, idict) is the list of selected brain regions.
%%%% ¡settings!
'BrainRegion'
%%%% ¡gui!
pr = SUVRConstructorPP_BR_DICT('EL', pdfc, 'PROP', PDFConstructor.PDF_REGION_SELECTION, ...
    'WAITBAR', pdfc.getCallback('WAITBAR'), ...
    varargin{:});

%%% ¡prop!
CALC_SUBJ_PDF (query, cell) generates pdf vectors per subject using subject PET and T1 data.
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

% calculate pdf for ref region

atlas_directories = pdfc.get('ATLAS_PATH_DICT').get('IT_LIST');
% atlas_kind = pdfc.get('ATLAS_KIND');
Ref_list = pdfc.get('REF_REGION_LIST');
atlas_pdf_index = pdfc.get('ATLAS_INDEX');
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

pdf_values_ref = masked_pet_data(ref_region_union_mask);

% % Sort the values in descending order
sorted_values = sort(pdf_values_ref, 'descend');

% Calculate the number of values that constitute the top 50%
num_values = length(sorted_values);
top_50_percent_count = ceil(num_values / 2);

% Select the top 50% of the values
top_50_percent_values = sorted_values(1:top_50_percent_count);

ref_region_meanvalue = mean(top_50_percent_values);

% atlas_index = find(contains(atlas_kind{atlas_pdf{1}}));% here user can define refine the atlas_pdf option
% atlas_roi = atlas{atlas_index};
atlas_roi = atlas{atlas_pdf_index};
% calculate normalized pdf for all unique regions
ROI_list = unique(atlas_roi);
ROI_list = ROI_list(ROI_list>0);% remove background which is represented by label "0"
parfor roi_list_index = 1:length(ROI_list)
    roi_index = ROI_list(roi_list_index);
    roi_mask = atlas_roi==roi_index;
    roi_data = masked_pet_data.*int16(roi_mask);
    roi = double(roi_data(roi_data>0))/ref_region_meanvalue;

    [f, xf] = kde(roi, 'Bandwidth', 'plug-in', 'NumPoints', 500);
    kde_results(:,roi_list_index) = f;  % Store both the density estimate and evaluation points
end

value = kde_results;

%%% ¡prop!
GR (result, item) is a group of subjects with PDF analysis data.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'))
%%%% ¡calculate!
% creates empty Group
gr_pdf = Group( ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
    );

gr_pdf.lock('SUB_CLASS');

gr_T1 = pdfc.get('GR_T1');% subject from Nifti
gr_PET = pdfc.get('GR_PET');% subject from Nifti

wb = braph2waitbar(pdfc.get('WAITBAR'), 0, ['Calculating PDF for subjects ...']);
% adds subjects
sub_dict = gr_pdf.memorize('SUB_DICT');
for i = 1:1:gr_PET.get('SUB_DICT').get('LENGTH')
    sub_id_t1 = gr_T1.get('SUB_DICT').get('IT', i).get('ID');% subject ID atlas_pdf_index
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
        PDF = pdfc.get('CALC_SUBJ_PDF', pet_data, t1_data);

        % Use atlas with regions, update a list with brain regions
        ba_list = pdfc.get('BA');
        atlas_pdf_index = pdfc.get('ATLAS_INDEX');
        ba = ba_list{atlas_pdf_index};

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

        selected_pdf_region = cellfun(@(x) x.get('ID'), pdfc.get('PDF_REGION_SELECTION').get('IT_LIST'),'UniformOutput',false);
        matched_indices = [];
        for j = 1:length(region_names)
            match_idx = find(strcmp(selected_pdf_region, region_names{j}));
            if ~isempty(match_idx)
                matched_indices = [matched_indices, match_idx];
            end
        end
        PDF = PDF(:,matched_indices);
        % Create a new BrainAtlas with only selected regions
        selected_br_list = cellfun(@(idx) ba.get('BR_DICT').get('IT', idx), num2cell(matched_indices), 'UniformOutput', false);
        br_dict_filtered = IndexedDictionary( ...
            'IT_CLASS', 'BrainRegion', ...
            'IT_LIST', selected_br_list ...
            );
        ba_filtered = BrainAtlas( ...
            'ID', [ba.get('ID') '_filtered'], ...
            'LABEL', ba.get('LABEL'), ...
            'NOTES', [ba.get('NOTES') ' - Filtered to selected regions'], ...
            'BR_DICT', br_dict_filtered ...
            );        
        sub = SubjectFUN( ...
            'ID', sub_id_t1, ...
            'LABEL', ['Subejct FUN ' int2str(i)], ...
            'NOTES', ['Notes on subject FUN ' int2str(i)], ...
            'BA', ba_filtered,...
            'FUN', PDF, ...
            'VOI_DICT', gr_PET.get('SUB_DICT').get('IT', i).get('VOI_DICT')...
            );
        sub_dict.get('ADD', sub);
        braph2waitbar(wb, .15 + .85 * i / gr_PET.get('SUB_DICT').get('LENGTH'), ['Calculating PDFs for subject ' num2str(i) ' of ' num2str(gr_PET.get('SUB_DICT').get('LENGTH')) ' ...'])
    end
end

braph2waitbar(wb, 'close')
value = gr_pdf;

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example data
%%%% ¡code!
output_dir = fullfile(fileparts(which('PDFConstructor')), 'Example data Nifti');
if ~exist(output_dir)
    create_example_NIfTI([],output_dir) % only creates files if the example folder doesn't already exist
end

%%% ¡test!
%%%% ¡name!
Compare Mathematical Expectation with VOIs Table (Using PDFConstructor)
%%%% ¡code!
example_data_dir = fullfile(fileparts(which('PDFConstructor')), 'Example data Nifti');
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [which('aal94_atlas.xlsx')], ...
    'WAITBAR', true ...
);

ba = im_ba.get('BA');

% Path to generated VOIs file
vois_file = fullfile(example_data_dir, 'Group1.vois.xlsx');

% Read the VOIs file
vois_table = readtable(vois_file,'ReadVariableNames',false);

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

atlas = ba;
br_dict = atlas.get('BR_DICT');
selected_ids = num2cell(1:94);
selected_br = cellfun(@(id) br_dict.get('IT', id), selected_ids, 'UniformOutput', false);
selected_br_dict = IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', selected_br);
gr = PDFConstructor('GR_PET', gr1_PET, ...
    'GR_T1', gr1_WM_GM, ...
    'BA', {ba}, ...
    'ATLAS_PATH_DICT', path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', ref_region_list, ...
    'PDF_REGION_SELECTION', selected_br_dict);
gr1 = gr.get('GR');


num_subjects = gr1.get('SUB_DICT').get('LENGTH');
num_regions = size(gr1.get('SUB_DICT').get('IT', 1).get('FUN'), 2);
calculated_subject_ids = cell(num_subjects, 1);

for subj_idx = 1:num_subjects
    % Retrieve subject-specific data
    subj_data = gr1.get('SUB_DICT').get('IT', subj_idx).get('FUN');
    calculated_subject_ids{subj_idx} = gr1.get('SUB_DICT').get('IT', subj_idx).get('ID');

    % Calculate means for the first 20 regions and other regions
    mean_first20 = mean(subj_data(:, 1:20), 'all');  % Mean of first 20 regions
    mean_others = mean(subj_data(:, 21:end), 'all'); % Mean of other regions

    % Assert that mean of first 20 regions is smaller
    assert(mean_first20 > mean_others, ...
        sprintf('Subject %s: Mean of first 20 regions is not larger than other regions.', calculated_subject_ids{subj_idx}));
end

% varify if regions have been selected correctly
selected_br_dict = IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', {selected_br{1:5}});
gr = PDFConstructor('GR_PET', gr1_PET, ...
    'GR_T1', gr1_WM_GM, ...
    'BA', {ba}, ...
    'ATLAS_PATH_DICT', path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', ref_region_list, ...
    'PDF_REGION_SELECTION', selected_br_dict);
gr1 = gr.get('GR');

subj_list_length = cellfun(@(x) size(x.get('FUN'),2), gr1.get('SUB_DICT').get('IT_LIST'), 'UniformOutput',false);
subj_list_lengths = cell2mat(subj_list_length);
selected_region_num = length({selected_br{1:5}});

% Check if each element in subj_list_lengths equals selected_region_num
all_match = all(subj_list_lengths == selected_region_num);

% Assert the comparison
assert(all_match, ...
    'Mismatch: Not all subject list lengths (%s) equal selected_region_num (%d).', ...
    num2str(subj_list_lengths), selected_region_num);