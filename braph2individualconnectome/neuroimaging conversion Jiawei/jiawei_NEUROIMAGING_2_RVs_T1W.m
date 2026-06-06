%EXAMPLE_NEUROIMGING_2_RVS_T1W
% Script example pipeline neuroimaing (T1w) conversion to
% regional values (VOLUME)
clear variables %#ok<*NASGU>

%% Create dataset
atlas_path = [fileparts(which('group_roi_means_mri.xlsx')) filesep 'BN_Atlas_246_1d5mm.nii'];
% example_data_dir = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example data NIfTI'];
% create_data_NIfTI_GMProb(atlas_path, example_data_dir)

%% Load BrainAtlases
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('group_roi_means_mri.xlsx')) filesep 'bna_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

bna_atlas = im_ba.get('BA');

%% Load Groups of SubjectNeuroimaging
im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', [fileparts(which('age-50-60.vois.xlsx')) filesep 'age-50-60'], ...
    'MODALITY', 'mri', ...
    'TARGET', 'sub', ...
    'WAITBAR', true ...
    );

age50_60 = im_gr_gm.get('GR');

im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', [fileparts(which('age-40-50.vois.xlsx')) filesep 'age-40-50'], ...
    'MODALITY', 'mri', ...
    'TARGET', 'sub', ...
    'WAITBAR', true ...
    );

age40_50 = im_gr_gm.get('GR');


im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', [fileparts(which('age-30-40.vois.xlsx')) filesep 'age-30-40'], ...
    'MODALITY', 'mri', ...
    'TARGET', 'sub', ...
    'WAITBAR', true ...
    );

age30_40 = im_gr_gm.get('GR');


im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', [fileparts(which('age-18-30.vois.xlsx')) filesep 'age-18-30'], ...
    'MODALITY', 'mri', ...
    'TARGET', 'sub', ...
    'WAITBAR', true ...
    );

age18_30 = im_gr_gm.get('GR');


%% Convert neuroimaging data to region-of-interest data
ba_nifti_files = {
    atlas_path
    };

ba_mapping_files = {
    [fileparts(which('group_roi_means_mri.xlsx')) filesep  'bna_atlas_mapping.xlsx']
    };

brain_regions_to_convert = {};
convert_brain_regions_idx = 1:246; % cerebral all regions in bnas
for i = 1:length(convert_brain_regions_idx)
    brain_regions_to_convert{i} = bna_atlas.get('BR_DICT').get('IT', convert_brain_regions_idx(i)).get('ID');
end 

age50_60_gr = ConverterNeuroimaging2RegionalValues( ...
    'BA_LIST', {bna_atlas}, ...
    'BA_NIFTI_FILES', ba_nifti_files, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'REF_BR', {}, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', age50_60);

gr5060_st = age50_60_gr.get('GR_ST');

age40_50_gr = ConverterNeuroimaging2RegionalValues( ...
    'BA_LIST', {bna_atlas}, ...
    'BA_NIFTI_FILES', ba_nifti_files, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'REF_BR', {}, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', age40_50);

gr4050_st = age40_50_gr.get('GR_ST');

age30_40_gr = ConverterNeuroimaging2RegionalValues( ...
    'BA_LIST', {bna_atlas}, ...
    'BA_NIFTI_FILES', ba_nifti_files, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'REF_BR', {}, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', age30_40);

gr3040_st = age30_40_gr.get('GR_ST');

age18_30_gr = ConverterNeuroimaging2RegionalValues( ...
    'BA_LIST', {bna_atlas}, ...
    'BA_NIFTI_FILES', ba_nifti_files, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'REF_BR', {}, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', age18_30);

gr1830_st = age18_30_gr.get('GR_ST');
ba_st = age50_60_gr.get('BA');
%% comparison


%% Export data
directory = [fileparts(which('age-18-30.vois.xlsx')) filesep 'Converted data structural T1w'];
if ~isfolder(directory)
    mkdir(directory);
end

file = [directory filesep 'group_subjects_VOLUME1830.xlsx'];
ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr1830_st ...
    );
ex.get('SAVE');

file = [directory filesep 'group_subjects_VOLUME3040.xlsx'];
ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr3040_st ...
    );
ex.get('SAVE');

file = [directory filesep 'group_subjects_VOLUME4050.xlsx'];
ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr4050_st ...
    );
ex.get('SAVE');

file = [directory filesep 'group_subjects_VOLUME5060.xlsx'];
ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr5060_st ...
    );
ex.get('SAVE');

file_ba = [directory filesep 'brain_atlas.xlsx'];
ex = ExporterBrainAtlasXLS( ...
    'FILE', file_ba, ...
    'BA', ba_st ...
    );
ex.get('SAVE');

%% Verification
groundtruth_file5060 = [fileparts(which('group_roi_means_mri_age-50-60.xls')) ...
    filesep 'group_roi_means_mri_age-50-60.xls'];

converted_file5060 = [directory filesep 'group_subjects_VOLUME5060.xlsx'];

groundtruth5060_table = readtable(groundtruth_file5060, 'VariableNamingRule', 'preserve');
converted_table5060 = readtable(converted_file5060, 'VariableNamingRule', 'preserve');

groundtruth_file4050 = [fileparts(which('group_roi_means_mri_age-40-50.xls')) ...
    filesep 'group_roi_means_mri_age-40-50.xls'];

converted_file4050 = [directory filesep 'group_subjects_VOLUME4050.xlsx'];

groundtruth4050_table = readtable(groundtruth_file4050, 'VariableNamingRule', 'preserve');
converted_table4050 = readtable(converted_file4050, 'VariableNamingRule', 'preserve');

groundtruth_file3040 = [fileparts(which('group_roi_means_mri_age-30-40.xls')) ...
    filesep 'group_roi_means_mri_age-30-40.xls'];

converted_file3040 = [directory filesep 'group_subjects_VOLUME3040.xlsx'];
groundtruth3040_table = readtable(groundtruth_file3040, 'VariableNamingRule', 'preserve');
converted_table3040 = readtable(converted_file3040, 'VariableNamingRule', 'preserve');


groundtruth_file1830 = [fileparts(which('group_roi_means_mri_age-18-30.xls')) ...
    filesep 'group_roi_means_mri_age-18-30.xls'];

converted_file1830 = [directory filesep 'group_subjects_VOLUME1830.xlsx'];

groundtruth1830_table = readtable(groundtruth_file1830, 'VariableNamingRule', 'preserve');
converted_table1830 = readtable(converted_file1830, 'VariableNamingRule', 'preserve');

num_regions_to_check = 246;
region_col_start = 4;
region_col_end = region_col_start + num_regions_to_check - 1;

groundtruth_values5060 = table2array(groundtruth5060_table(:, region_col_start:region_col_end));
converted_values5060 = table2array(converted_table5060(:, region_col_start:region_col_end));

groundtruth_values4050 = table2array(groundtruth4050_table(:, region_col_start:region_col_end));
converted_values4050 = table2array(converted_table4050(:, region_col_start:region_col_end));

groundtruth_values3040 = table2array(groundtruth3040_table(:, region_col_start:region_col_end));
converted_values3040 = table2array(converted_table3040(:, region_col_start:region_col_end));

groundtruth_values1830 = table2array(groundtruth1830_table(:, region_col_start:region_col_end));
converted_values1830 = table2array(converted_table1830(:, region_col_start:region_col_end));
% Check size consistency.
assert(isequal(size(groundtruth_values1830), size(converted_values1830)), ...
    'Verification failed: ground-truth and converted matrices have different sizes.')


% Check converted brain region number consistency.
assert(isequal(size(groundtruth_values5060, 2), numel(brain_regions_to_convert)), ...
    'Verification failed: intended converted brain regions and converted matrices have different sizes.')

% Check numerical agreement.
tol = 1e-6;
abs_diff = abs(groundtruth_values5060 - converted_values5060);
max_abs_diff = max(abs_diff(:));

assert(max_abs_diff < tol, ...
    'Verification failed: maximum absolute difference %.6g exceeds tolerance %.6g.', ...
    max_abs_diff, tol)

fprintf('Verification passed: converted GM probability regional values match ground truth within tolerance %.1e.\n', tol);
fprintf('Maximum absolute difference: %.6g\n', max_abs_diff);

% Check numerical agreement.
tol = 1e-6;
abs_diff = abs(groundtruth_values4050 - converted_values4050);
max_abs_diff = max(abs_diff(:));

assert(max_abs_diff < tol, ...
    'Verification failed: maximum absolute difference %.6g exceeds tolerance %.6g.', ...
    max_abs_diff, tol)

fprintf('Verification passed: converted GM probability regional values match ground truth within tolerance %.1e.\n', tol);
fprintf('Maximum absolute difference: %.6g\n', max_abs_diff);

% Check numerical agreement.
tol = 1e-6;
abs_diff = abs(groundtruth_values3040 - converted_values3040);
max_abs_diff = max(abs_diff(:));

assert(max_abs_diff < tol, ...
    'Verification failed: maximum absolute difference %.6g exceeds tolerance %.6g.', ...
    max_abs_diff, tol)

fprintf('Verification passed: converted GM probability regional values match ground truth within tolerance %.1e.\n', tol);
fprintf('Maximum absolute difference: %.6g\n', max_abs_diff);

% Check numerical agreement.
tol = 1e-6;
abs_diff = abs(groundtruth_values1830 - converted_values1830);
max_abs_diff = max(abs_diff(:));

assert(max_abs_diff < tol, ...
    'Verification failed: maximum absolute difference %.6g exceeds tolerance %.6g.', ...
    max_abs_diff, tol)

fprintf('Verification passed: converted GM probability regional values match ground truth within tolerance %.1e.\n', tol);
fprintf('Maximum absolute difference: %.6g\n', max_abs_diff);