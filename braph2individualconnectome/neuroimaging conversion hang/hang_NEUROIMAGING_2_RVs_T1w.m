%EXAMPLE_NEUROIMGING_2_RVS_PET
% Script example pipeline neuroimaing (PET) conversion to
% regional values (SUVR)
clear variables %#ok<*NASGU>

%% Create dataset
% example_data_dir =  [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example data NIfTI'];

% atlas_path = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.nii'];
% create_data_NIfTI_GMProb(atlas_path, example_data_dir)
% 
% atlas_path = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases NIfTI' filesep 'td_atlas.nii'];
% create_data_NIfTI_WMProb(atlas_path, example_data_dir)
% 
% atlas_path = [fileparts(which('ConverterNeuroimaging2RegionalValues')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.nii'];
% create_data_NIfTI_PET(atlas_path, example_data_dir)

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
base_Dir = '/home/hang/GitHub/IndividualConnectome-YuweiHangRefator/group_data/HangFDG_dataBIDS';
im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', [base_Dir, '/AD_PositiveAmyloid'], ...
    'MODALITY', 'anat', ...
    'TARGET', 'gmprob', ...
    'WAITBAR', true ...
    );

grad_anat_gmprob = im_gr_gm.get('GR');

im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', [base_Dir, '/MCI_PositiveAmyloid'], ...
    'MODALITY', 'anat', ...
    'TARGET', 'gmprob', ...
    'WAITBAR', true ...
    );

grmci_anat_gmprob = im_gr_gm.get('GR');

im_gr_gm = ImporterGroupSubjectNeuroimaging_NIfTI( ...
    'DIRECTORY', [base_Dir, '/Healthy_PositiveAmyloid'], ...
    'MODALITY', 'anat', ...
    'TARGET', 'gmprob', ...
    'WAITBAR', true ...
    );

grcn_anat_gmprob = im_gr_gm.get('GR');

%% Convert neuroimaging data to region-of-interest data
ba_nifti_files = {
    [fileparts(which('SubjectNeuroimaging')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas.nii']};
ba_mapping_files = {
    [fileparts(which('SubjectNeuroimaging')) filesep 'Example atlases NIfTI' filesep 'aal120_atlas_mapping.csv']};

% set the brain regions to convert the regional values (aal120 + TD)
brain_regions_to_convert = {};
convert_brain_regions_idx = 1:94; % cerebral all regions in aal120
for i = 1:length(convert_brain_regions_idx)
    brain_regions_to_convert{i} = ba_aal120.get('BR_DICT').get('IT', convert_brain_regions_idx(i)).get('ID');
end 

% for i = 1:ba_td.get('BR_DICT').get('LENGTH') % all regions in TD
%     brain_regions_to_convert{end + 1} = ba_td.get('BR_DICT').get('IT', i).get('ID');
% end

ad = ConverterNeuroimaging2RegionalValues( ...
    'ID','AD',...
    'BA_LIST', {ba_aal120}, ...
    'BA_NIFTI_FILES', ba_nifti_files, ...
    'REF_BR', {}, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', grad_anat_gmprob);

gr1 = ad.get('GR_ST');

mci = ConverterNeuroimaging2RegionalValues( ...
    'ID','MCI',...
    'BA_LIST', {ba_aal120}, ...
    'BA_NIFTI_FILES', ba_nifti_files, ...
    'REF_BR', {}, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', grmci_anat_gmprob);

gr2 = mci.get('GR_ST');

cn = ConverterNeuroimaging2RegionalValues( ...
    'ID','CN',...
    'BA_LIST', {ba_aal120}, ...
    'BA_NIFTI_FILES', ba_nifti_files, ...
    'BA_MAPPING_FILES', ba_mapping_files, ...
    'REF_BR', {}, ...
    'CONVERT_BR', brain_regions_to_convert, ...
    'GR_NEUROIMAGING', grcn_anat_gmprob);

gr3 = cn.get('GR_ST');
ba_st = cn.get('BA');
%% comparison
%% Analysis ST WU
a_WUAD = AnalyzeGroup_ST_WU( ...
    'GR', gr1, ...
    'CORRELATION_RULE', Correlation.PEARSON ...
    );

a_WUMCI = AnalyzeGroup_ST_WU( ...
    'TEMPLATE',a_WUAD , ...
    'GR', gr2 ...
    );

a_WUCN = AnalyzeGroup_ST_WU( ...
    'TEMPLATE',a_WUAD , ...
    'GR', gr3 ...
    );


% comparison
c_WU = CompareGroup( ...
    'P', 100, ...
    'A1', a_WUMCI, ...
    'A2', a_WUCN, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

Clustering_WU_diff = c_WU.get('COMPARISON', 'Clustering').get('DIFF');
Clustering_WU_p1 = c_WU.get('COMPARISON', 'Clustering').get('P1');
Clustering_WU_p2 = c_WU.get('COMPARISON', 'Clustering').get('P2');
Clustering_WU_cil = c_WU.get('COMPARISON', 'Clustering').get('CIL');
Clustering_WU_ciu = c_WU.get('COMPARISON', 'Clustering').get('CIU');

GlobalEfficiency_av_WU_diff = c_WU.get('COMPARISON', 'GlobalEfficiency').get('DIFF');
GlobalEfficiency_av_WU_p1 = c_WU.get('COMPARISON', 'GlobalEfficiency').get('P1');
GlobalEfficiency_av_WU_p2 = c_WU.get('COMPARISON', 'GlobalEfficiency').get('P2');
GlobalEfficiency_av_WU_cil = c_WU.get('COMPARISON', 'GlobalEfficiency').get('CIL');
GlobalEfficiency_av_WU_ciu = c_WU.get('COMPARISON', 'GlobalEfficiency').get('CIU');

distance_WU_diff = c_WU.get('COMPARISON', 'Distance').get('DIFF');
distance_WU_p1 = c_WU.get('COMPARISON', 'Distance').get('P1');
distance_WU_p2 = c_WU.get('COMPARISON', 'Distance').get('P2');
distance_WU_cil = c_WU.get('COMPARISON', 'Distance').get('CIL');
distance_WU_ciu = c_WU.get('COMPARISON', 'Distance').get('CIU');
%% VISUALIZATION
c_WU.get('COMPARISON', 'Clustering').get('PFBG').set('VIEW',[0 90])
c_WU.get('COMPARISON', 'Clustering').get('PFBG').get('DRAWN')
c_WU.get('COMPARISON', 'Clustering').get('PFBG').get('DRAW')
c_WU.get('COMPARISON', 'Clustering').get('PFBG').get('SHOW')
% 
c_WU.get('COMPARISON', 'GlobalEfficiency').get('PFBG').set('VIEW',[0 90])
c_WU.get('COMPARISON', 'GlobalEfficiency').get('PFBG').get('DRAWN')
c_WU.get('COMPARISON', 'GlobalEfficiency').get('PFBG').get('DRAW')
c_WU.get('COMPARISON', 'GlobalEfficiency').get('PFBG').get('SHOW')

c_WU.get('COMPARISON', 'Strength').get('PFBG').get('DRAWN')
c_WU.get('COMPARISON', 'Strength').get('PFBG').get('DRAW')
c_WU.get('COMPARISON', 'Strength').get('PFBG').get('SHOW')

%% Export data
directory = [fileparts(which('hang_NNCV_PET_ST_CLA')) filesep 'Converted data structural T1w ST'];
mkdir(directory);
file = [directory filesep 'group_subjects_GMV_AD.xlsx'];
ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr1 ...
    );
ex.get('SAVE');
file = [directory filesep 'group_subjects_GMV_MCI.xlsx'];
ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr2 ...
    );
ex.get('SAVE');
file = [directory filesep 'group_subjects_GMV_CN.xlsx'];
ex = ExporterGroupSubjectST_XLS( ...
    'FILE', file, ...
    'GR', gr3 ...
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

% tol = 1e-2;
% 
% old_file = 'group_subjects_SUVR.xlsx';
% new_file = 'group_roi_means_pet_suvr_aal120_ref_gm_vermis_wm_pons.xlsx';
% map_file = '/home/hang/GitHub/IndividualConnectome-WithYuwei/group_data/HangFDG_SUVR_output/old_new_roi_name_mapping.csv';
% 
% oldT = readtable(old_file, 'VariableNamingRule', 'preserve');
% newT = readtable(new_file, 'VariableNamingRule', 'preserve');
% mapT = readtable(map_file, 'VariableNamingRule', 'preserve');
% 
% oldT.ID = string(oldT.ID);
% newT.ID = string(newT.ID);
% 
% %% Match subjects
% [okSub, newIdx] = ismember(oldT.ID, newT.ID);
% assert(all(okSub), 'Some old-file subjects are missing in the new file.');
% 
% %% Keep matched ROIs, excluding cerebellum/vermis
% oldNameCol = mapT.Properties.VariableNames{1};
% newNameCol = mapT.Properties.VariableNames{2};
% 
% old_roi = string(mapT.(oldNameCol));
% new_roi = string(mapT.(newNameCol));
% 
% keep = old_roi ~= "" & new_roi ~= "" & ...
%        ~contains(new_roi, "Cerebelum", "IgnoreCase", true) & ...
%        ~contains(new_roi, "Vermis", "IgnoreCase", true);
% 
% old_roi = old_roi(keep);
% new_roi = new_roi(keep);
% 
% assert(all(ismember(old_roi, string(oldT.Properties.VariableNames))), 'Some old ROI names are missing.');
% assert(all(ismember(new_roi, string(newT.Properties.VariableNames))), 'Some new ROI names are missing.');
% 
% %% Compare values
% A = double(oldT{:, old_roi});
% B = double(newT{newIdx, new_roi});
% 
% D = abs(A - B);
% pass = D <= tol | (isnan(A) & isnan(B));
% 
% fprintf('Matched subjects: %d\n', height(oldT));
% fprintf('Matched ROIs after exclusion: %d\n', numel(old_roi));
% fprintf('Max abs diff: %.6g\n', max(D(:), [], 'omitnan'));
% fprintf('Mean abs diff: %.6g\n', mean(D(:), 'omitnan'));
% fprintf('Median abs diff: %.6g\n', median(D(:), 'omitnan'));
% fprintf('Mismatch rate at tol %.g: %.2f%%\n', tol, 100 * nnz(~pass) / numel(pass));
% 
% assert(all(pass(:)), 'Some SUVR values differ more than tolerance.');
% disp('All matched SUVR values are within tolerance.');