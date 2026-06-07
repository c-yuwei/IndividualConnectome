%EXAMPLE_NEUROIMGING_2_RVS_T1W
% Script example pipeline neuroimaing (T1w) conversion to
% regional values (VOLUME)
clear variables %#ok<*NASGU>

%% Create dataset
%group_names = {'Group1' 'Group2'};
atlas_path = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.nii'];
example_data_dir = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example data NIfTI'];
create_data_NIfTI_GMProb(atlas_path, example_data_dir,group_names)

%% Load BrainAtlases
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba_aal120 = im_ba.get('BA');

%% Load Groups of SubjectNeuroimaging
im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example data NIfTI'], ...
    'MODALITY', 'anat', ...
    'TARGET', 'gmprob', ...
    'WAITBAR', true ...
    );

gr_anat_gmprob = im_gr_gm.get('GR');

%% Convert neuroimaging data to region-of-interest data
ba_nifti_files = {
    [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.nii']
    };

ba_mapping_files = {
    [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas_mapping.csv']
    };

brain_regions_to_convert = {};
convert_brain_regions_idx = 1:94; % cerebral all regions in aal120
for i = 1:length(convert_brain_regions_idx)
    brain_regions_to_convert{i} = ba_aal120.get('BR_DICT').get('IT', convert_brain_regions_idx(i)).get('ID');
end 

cn = ConverterNeuroimaging2RegionalValues( ...
    'BA_LIST', {ba_aal120}, ...
    'BA_NIFTI_FILES', ba_nifti_files, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'REF_BR', {}, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', gr_anat_gmprob);

gr_st = cn.get('GR_ST');
ba_st = cn.get('BA');

%% Export data
directory = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Converted data structural T1w'];
if ~isfolder(directory)
    mkdir(directory);
end

file = [directory filesep 'group_subjects_VOLUME.xlsx'];
ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr_st ...
    );
ex.get('SAVE');

file_ba = [directory filesep 'brain_atlas.xlsx'];
ex = ExporterBrainAtlasXLS( ...
    'FILE', file_ba, ...
    'BA', ba_st ...
    );
ex.get('SAVE');

%% Verification
groundtruth_file = [fileparts(which('ConverterNeuroimaging2RegionalValues')) ...
    filesep 'Example data NIfTI' ...
    filesep 'reference_data' ...
    filesep 'group_roi_means_gmprob.xlsx'];

converted_file = [directory filesep 'group_subjects_VOLUME.xlsx'];

groundtruth_table = readtable(groundtruth_file, 'VariableNamingRule', 'preserve');
converted_table = readtable(converted_file, 'VariableNamingRule', 'preserve');

% The first three columns are assumed to be:
%   ID, Label, Notes
%
% The next 94 columns correspond to the selected AAL120 cerebral regions.
num_regions_to_check = 94;
region_col_start = 4;
region_col_end = region_col_start + num_regions_to_check - 1;

groundtruth_values = table2array(groundtruth_table(:, region_col_start:region_col_end));
converted_values = table2array(converted_table(:, region_col_start:region_col_end));

% Check size consistency.
assert(isequal(size(groundtruth_values), size(converted_values)), ...
    'Verification failed: ground-truth and converted matrices have different sizes.')

% Check converted brain region number consistency.
assert(isequal(size(converted_values, 2), numel(brain_regions_to_convert)), ...
    'Verification failed: intended converted brain regions and converted matrices have different sizes.')

% Check numerical agreement.
tol = 1e-6;
abs_diff = abs(groundtruth_values - converted_values);
max_abs_diff = max(abs_diff(:));

assert(max_abs_diff < tol, ...
    'Verification failed: maximum absolute difference %.6g exceeds tolerance %.6g.', ...
    max_abs_diff, tol)

fprintf('Verification passed: converted GM probability regional values match ground truth within tolerance %.1e.\n', tol);
fprintf('Maximum absolute difference: %.6g\n', max_abs_diff);
