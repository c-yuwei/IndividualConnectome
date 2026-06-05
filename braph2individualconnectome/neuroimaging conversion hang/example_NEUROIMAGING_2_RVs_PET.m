%EXAMPLE_NEUROIMGING_2_RVS_PET
% Script example pipeline neuroimaing (PET) conversion to
% regional values (SUVR)
clear variables %#ok<*NASGU>

%% Create dataset
example_data_dir =  [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example data NIfTI'];

atlas_path = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.nii'];
create_data_NIfTI_GMProb(atlas_path, example_data_dir)

atlas_path = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases NIfTI' filesep 'td_atlas.nii'];
create_data_NIfTI_WMProb(atlas_path, example_data_dir)

atlas_path = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.nii'];
create_data_NIfTI_PET(atlas_path, example_data_dir)

%% Load BrainAtlases
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('SubjectNeuroimaging')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba_aal120 = im_ba.get('BA');

im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('SubjectNeuroimaging')) filesep 'Example atlases NIfTI' filesep 'td_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba_td = im_ba.get('BA');

%% Load Groups of SubjectNeuroimaging
im_gr_pet = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', '/home/hang/GitHub/IndividualConnectome-WithYuwei/group_data/HangFDG_dataBIDS/AD_PositiveAmyloid', ...
    'MODALITY', 'pet', ...
     'TARGET', 'pet', ...
    'WAITBAR', true ...
    );

gr_pet = im_gr_pet.get('GR');

im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', '/home/hang/GitHub/IndividualConnectome-WithYuwei/group_data/HangFDG_dataBIDS/AD_PositiveAmyloid', ...
    'MODALITY', 'anat', ...
    'TARGET', 'gmprob', ...
    'WAITBAR', true ...
    );

gr_anat_gmprob = im_gr_gm.get('GR');

im_gr_wm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', '/home/hang/GitHub/IndividualConnectome-WithYuwei/group_data/HangFDG_dataBIDS/AD_PositiveAmyloid', ...
    'MODALITY', 'anat', ...
    'TARGET', 'wmprob', ...
    'WAITBAR', true ...
    );

gr_anat_wmprob = im_gr_wm.get('GR');

%% Convert neuroimaging data to region-of-interest data
ba_nifti_files = {
    [fileparts(which('SubjectNeuroimaging')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.nii']
    [fileparts(which('SubjectNeuroimaging')) filesep 'Example atlases NIfTI' filesep 'td_atlas.nii']
    };

ba_mapping_files = {
    [fileparts(which('SubjectNeuroimaging')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas_mapping.csv']
    [fileparts(which('SubjectNeuroimaging')) filesep 'Example atlases NIfTI' filesep 'td_atlas_mapping.csv']
    };

% set the reference brain regions for PET normalization
ref_brain_regions = {};
ref_brain_regions_idx = 120-7:120; % cerebellum all regions in aal120
for i = 1:length(ref_brain_regions_idx)
    ref_brain_regions{i} = ba_aal120.get('BR_DICT').get('IT', ref_brain_regions_idx(i)).get('ID');
end
ref_brain_regions_idx_tds = 7;
for i = 1:length(ref_brain_regions_idx_tds)
    ref_brain_regions{end + 1} = ba_td.get('BR_DICT').get('IT', ref_brain_regions_idx_tds).get('ID');
end

% set the brain regions to convert the regional values (aal120 + TD)
brain_regions_to_convert = {};
convert_brain_regions_idx = 1:94; % cerebral all regions in aal120
for i = 1:length(convert_brain_regions_idx)
    brain_regions_to_convert{i} = ba_aal120.get('BR_DICT').get('IT', convert_brain_regions_idx(i)).get('ID');
end 

for i = 1:ba_td.get('BR_DICT').get('LENGTH') % all regions in TD
    brain_regions_to_convert{end + 1} = ba_td.get('BR_DICT').get('IT', i).get('ID');
end

cn = ConverterNeuroimaging2RegionalValues( ...
    'BA_LIST', {ba_aal120, ba_td}, ...
    'BA_NIFTI_FILES', ba_nifti_files, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'REF_BR', ref_brain_regions, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', gr_pet, ...
    'GR_LIST_ANAT_REF', {gr_anat_gmprob, gr_anat_wmprob}, ...
    'THRESHOLD_ANAT_REF', 0.5);

gr_st = cn.get('GR_ST');
ba_st = cn.get('BA');

%% Export data
directory = [fileparts(which('SubjectNeuroimaging')) filesep 'Converted data structural PET'];
mkdir(directory);
file = [directory filesep 'group_subjects_SUVR.xlsx'];
ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr_st ...
    );
ex.get('SAVE');

file = [directory filesep 'brain_atlas.xlsx'];
ex = ExporterBrainAtlasXLS( ...
    'FILE', file, ...
    'BA', ba_st ...
    );
ex.get('SAVE');

%% Verification
% groundtruth_file = [directory ...
%     filesep 'group_roi_means_pet_suvr_aal120_ref_gm_vermis_wm_pons.xlsx'];
% 
% converted_file = [directory filesep 'group_subjects_SUVR.xlsx'];
% 
% groundtruth_table = readtable(groundtruth_file, 'VariableNamingRule', 'preserve');
% converted_table = readtable(converted_file, 'VariableNamingRule', 'preserve');
% 
% % The first three columns are assumed to be:
% %   ID, Label, Notes
% %
% % This verification checks:
% %   1. The exported table contains all requested converted regions
% %      in CONVERT_BR, including AAL120 and TD regions.
% %   2. The first 94 exported values, corresponding to AAL120 cerebral
% %      regions, match the generated PET ground-truth ROI means within
% %      tolerance.
% region_col_start = 4;
% 
% all_converted_values = table2array(converted_table(:, region_col_start:end));
% 
% assert(isequal(size(all_converted_values, 2), numel(brain_regions_to_convert)), ...
%     'Verification failed: total number of converted regions does not match CONVERT_BR.')
% 
% assert(isequal(size(all_converted_values, 1), gr_st.get('SUB_DICT').get('LENGTH')), ...
%     'Verification failed: exported table and GR_ST have different numbers of subjects.')
% 
% assert(all(~isnan(all_converted_values(:))), ...
%     'Verification failed: converted PET SUVR table contains NaN values.')
% 
% % Check only the AAL120 cerebral regions against the PET ground truth.
% num_regions_to_check = numel(convert_brain_regions_idx);
% region_col_end = region_col_start + num_regions_to_check - 1;
% 
% groundtruth_values = table2array(groundtruth_table(:, region_col_start:region_col_end));
% converted_values = table2array(converted_table(:, region_col_start:region_col_end));
% 
% % Check subject and region matrix consistency.
% assert(isequal(size(groundtruth_values), size(converted_values)), ...
%     'Verification failed: ground-truth and converted AAL120 matrices have different sizes.')
% 
% assert(isequal(size(converted_values, 2), num_regions_to_check), ...
%     'Verification failed: converted PET matrix has a different number of checked AAL120 regions.')
% 
% % Check numerical agreement.
% %
% % PET verification is less strict than GMprob because the converter applies
% % anatomical GM/WM masking before averaging, while the generated PET
% % ground-truth means are calculated directly from the atlas ROI support.
% % Therefore, values should be close but not necessarily identical.
% tol = 0.15;
% abs_diff = abs(groundtruth_values - converted_values);
% max_abs_diff = max(abs_diff(:));
% 
% assert(max_abs_diff < tol, ...
%     'Verification failed: maximum absolute difference %.6g exceeds tolerance %.6g.', ...
%     max_abs_diff, tol)
% 
% fprintf('Verification passed: exported PET table contains all %d converted regions, including AAL120 and TD regions.\n', ...
%     numel(brain_regions_to_convert));
% 
% fprintf('Verification passed: converted PET SUVR values match AAL120 ground truth within tolerance %.2f.\n', tol);
% fprintf('Maximum absolute difference: %.6g\n', max_abs_diff);

%%
%% Compare old and new SUVR files, excluding Cerebelum/Vermis

tol = 1e-2;

old_file = 'group_subjects_SUVR.xlsx';
new_file = 'group_roi_means_pet_suvr_aal120_ref_gm_vermis_wm_pons.xlsx';
map_file = '/home/hang/GitHub/IndividualConnectome-WithYuwei/group_data/HangFDG_SUVR_output/old_new_roi_name_mapping.csv';

oldT = readtable(old_file, 'VariableNamingRule', 'preserve');
newT = readtable(new_file, 'VariableNamingRule', 'preserve');
mapT = readtable(map_file, 'VariableNamingRule', 'preserve');

oldT.ID = string(oldT.ID);
newT.ID = string(newT.ID);

%% Match subjects
[okSub, newIdx] = ismember(oldT.ID, newT.ID);
assert(all(okSub), 'Some old-file subjects are missing in the new file.');

%% Keep matched ROIs, excluding cerebellum/vermis
oldNameCol = mapT.Properties.VariableNames{1};
newNameCol = mapT.Properties.VariableNames{2};

old_roi = string(mapT.(oldNameCol));
new_roi = string(mapT.(newNameCol));

keep = old_roi ~= "" & new_roi ~= "" & ...
       ~contains(new_roi, "Cerebelum", "IgnoreCase", true) & ...
       ~contains(new_roi, "Vermis", "IgnoreCase", true);

old_roi = old_roi(keep);
new_roi = new_roi(keep);

assert(all(ismember(old_roi, string(oldT.Properties.VariableNames))), 'Some old ROI names are missing.');
assert(all(ismember(new_roi, string(newT.Properties.VariableNames))), 'Some new ROI names are missing.');

%% Compare values
A = double(oldT{:, old_roi});
B = double(newT{newIdx, new_roi});

D = abs(A - B);
pass = D <= tol | (isnan(A) & isnan(B));

fprintf('Matched subjects: %d\n', height(oldT));
fprintf('Matched ROIs after exclusion: %d\n', numel(old_roi));
fprintf('Max abs diff: %.6g\n', max(D(:), [], 'omitnan'));
fprintf('Mean abs diff: %.6g\n', mean(D(:), 'omitnan'));
fprintf('Median abs diff: %.6g\n', median(D(:), 'omitnan'));
fprintf('Mismatch rate at tol %.g: %.2f%%\n', tol, 100 * nnz(~pass) / numel(pass));

assert(all(pass(:)), 'Some SUVR values differ more than tolerance.');
disp('All matched SUVR values are within tolerance.');