%% ¡header!
PDFConstructor < ConcreteElement (pdfc, PDF analysis constructor) calculates probability density function of brain ROIs per subject.

%%% ¡description!
PDFConstructor calculates probability density function (PDF) of brain ROIs. It loads the brain atlas for ROI identification,
 and brain data to calculate PDF of brain regions.

%%% ¡seealso!
Group, SubjectNIfTI, ExporterGroupSubjectCON_XLS, SubjectST

%%% ¡build!
1

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
% pdfc.get('ATLAS_KIND')
% %%%% ¡default!
% pdfc.get('ATLAS_KIND'){1} % Default to the first atlas in ATLAS_KIND

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
ba = pdfc.get('BA'); % Ensure brain atlas is obtained correctly
if isempty(pdfc.get('SUVR_REGION_SELECTION'))  && ~isempty(ba.get('BR_DICT').get('IT_LIST'))
    regions = ba.get('BR_DICT').get('LENGTH');
    IT_LIST = cell(regions, 1); % Preallocate cell array
    for i = 1:regions
        IT_LIST{i} = ba.get('BR_DICT').get('IT', i).get('ID'); % Correct appending
    end
    pdfc.set('SUVR_REGION_SELECTION', IT_LIST)
end

%%% ¡prop!
CALC_SUBJ_PDF (query, cell) generates suvr vectors per subject using subject PET and T1 data.
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

atlas_directories = pdfc.get('ATLAS_PATH_DICT').get('IT_LIST');
atlas_kind = pdfc.get('ATLAS_KIND');
Ref_list = pdfc.get('REF_REGION_LIST');
atlas_suvr_index = pdfc.get('ATLAS_INDEX');
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
    roi = double(roi_data(roi_data>0))/ref_region_meanvalue;

    [f, xf] = kde(roi, 'Bandwidth', 'plug-in', 'NumPoints', 500);
    kde_results(:,roi_list_index) = f;  % Store both the density estimate and evaluation points
 end

value = kde_results;

%%% ¡prop!
GR (result, item) is a group of subjects with SUVR analysis data.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'))
%%%% ¡calculate!
% creates empty Group
gr_suvr = Group( ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
    );

gr_suvr.lock('SUB_CLASS');

gr_T1 = pdfc.get('GR_T1');% subject from Nifti
gr_PET = pdfc.get('GR_PET');% subject from Nifti

wb = braph2waitbar(pdfc.get('WAITBAR'), 0, ['Calculating PDF for subjects ...']);
% adds subjects
sub_dict = gr_suvr.memorize('SUB_DICT');
for i = 1:1:gr_PET.get('SUB_DICT').get('LENGTH')
    sub_id_t1 = gr_T1.get('SUB_DICT').get('IT', i).get('ID');% subject ID
    sub_id_pet = gr_PET.get('SUB_DICT').get('IT', i).get('ID');% subject ID

    if isequal(sub_id_t1, sub_id_pet)
        braph2waitbar(wb, .15 + .85 * i / gr_PET.get('SUB_DICT').get('LENGTH'), ['Calculating PDFs for subject ' num2str(i) ' of ' num2str(gr_PET.get('SUB_DICT').get('LENGTH')) ' ...'])
        t1_path = gr_T1.get('SUB_DICT').get('IT', i).get('NIFTI_PATH_DICT').get('IT_LIST');% subject T1 data path
        pet_path = gr_PET.get('SUB_DICT').get('IT', i).get('NIFTI_PATH_DICT').get('IT_LIST');% subject PET data path
        for i = 1:length(pet_path)
            pet_data{i} = niftiread(pet_path{i}.get('PATH'));
        end

        for i = 1:length(t1_path)
            t1_data{i} = niftiread(t1_path{i}.get('PATH'));
        end
        PDF = pdfc.get('CALC_SUBJ_PDF', pet_data, t1_data);

        % use aal2 with 90 regions, update a list with brain regions of aal120 (stringlist)
        ba = pdfc.get('BA');

        % Get the number of brain regions in the atlas
        num_regions = ba.get('BR_DICT').get('LENGTH');

        % Initialize a cell array to store the names of the brain regions
        region_names = cell(num_regions, 1);

        % Iterate through each region and get its name
        for i = 1:ba.get('BR_DICT').get('LENGTH')
            % Get the brain region element from the BrainAtlas
            brain_region = ba.get('BR_DICT').get('IT', i);

            % Get the name of the brain region
            region_names{i} = brain_region.get('ID');
        end

        selected_suvr_region = pdfc.get('SUVR_REGION_SELECTION');
        matched_indices = [];
        for i = 1:length(region_names)
            match_idx = find(strcmp(selected_suvr_region, region_names{i}));
            if ~isempty(match_idx)
                matched_indices = [matched_indices, match_idx];
            end
        end
        PDF = PDF(:,matched_indices);
        sub = SubjectFUN( ...
            'ID', sub_id_t1, ...
            'LABEL', ['Subejct FUN ' int2str(i)], ...
            'NOTES', ['Notes on subject FUN ' int2str(i)], ...
            'BA', ba,...
            'FUN', PDF);
        sub_dict.get('ADD', sub);
    end
end

braph2waitbar(wb, 'close')
value = gr_suvr;

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example data
%%%% ¡code!
create_example_NIfTI()

%%% ¡test!
%%%% ¡name!
Compare Mathematical Expectation with VOIs Table (Using PDFConstructor)
%%%% ¡code!
% Step 1: Generate Simulated Data
output_dir = fullfile(fileparts(which('PDFConstructor')), 'Example data Nifti');

% Step 2: Load Brain Atlas
im_ba = ImporterBrainAtlasXLS('FILE', which('aal94_atlas.xlsx'));
ba = im_ba.get('BA');

% Step 3: Load PET and T1 Data
group_dir = fullfile(output_dir, 'Group1');
im_gr1_PET = ImporterGroupSubjNIfTI('DIRECTORY', group_dir, 'NIFTI_TYPE', {'PET'}, 'WAITBAR', true);
gr1_PET = im_gr1_PET.get('GR');

im_gr1_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', group_dir, 'NIFTI_TYPE', {'T1'}, 'WAITBAR', true);
gr1_WM_GM = im_gr1_WM_GM.get('GR');

% Step 4: Create PDFConstructor
path_dict = IndexedDictionary('IT_CLASS', 'FILE_PATH', 'IT_LIST', {FILE_PATH('PATH', which('upsampled_AAL2.nii'))});
% suvr_brain_label = readtable(which('AAL2_Atlas_Labels.csv')).Var4;
ref_region_list = [2001]; % Reference region label

im_gr_pdf = PDFConstructor('GR_PET', gr1_PET, 'GR_T1', gr1_WM_GM, 'BA', ba, ...
    'ATLAS_PATH_DICT', path_dict, 'REF_REGION_LIST', {ref_region_list}, ...
    'ATLAS_KIND', {'AAL2'});
gr1 = im_gr_pdf.get('GR');


% Step 6: Calculate Means by Subject and Region
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
