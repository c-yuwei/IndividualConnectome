% EXAMPLE_CON_WU
% Script example pipeline Distance CON WU

clear variables %#ok<*NASGU>
addpath(genpath('/home/hang/GitHub/Individual-connectome/group_data/ADNI_DATA/'));
addpath(genpath('/home/hang/GitHub/IndividualConnectome-WithYuwei/braph2individualconnectome'));

%% load Nifty images
%%group1
im_gr3_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/AD_PositiveAmyloid.vois.xlsx')) filesep 'AD_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'},...
    'WAITBAR', true);
gr3_WM_GM = im_gr3_WM_GM.get('GR');

im_gr3_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/AD_PositiveAmyloid.vois.xlsx')) filesep 'AD_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'},...
    'WAITBAR', true);
gr3_PET = im_gr3_PET.get('GR');

%%group2
im_gr1_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY',[fileparts(which('Withconverters/Healthy_NegativeAmyloid.vois.xlsx')) filesep 'Healthy_NegativeAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'},...
    'WAITBAR', true);
gr1_WM_GM = im_gr1_WM_GM.get('GR');

im_gr1_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/Healthy_NegativeAmyloid.vois.xlsx')) filesep 'Healthy_NegativeAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'},...
    'WAITBAR', true);
gr1_PET = im_gr1_PET.get('GR');

%%group3
im_gr2_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/MCI_PositiveAmyloid.vois.xlsx')) filesep 'MCI_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'},...
    'WAITBAR', true);
gr2_WM_GM = im_gr2_WM_GM.get('GR');

im_gr2_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/MCI_PositiveAmyloid.vois.xlsx')) filesep 'MCI_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'},...
    'WAITBAR', true);
gr2_PET = im_gr2_PET.get('GR');

%%group4
im_gr4_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY',[fileparts(which('Withconverters/Healthy_PositiveAmyloid.vois.xlsx')) filesep 'Healthy_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'},...
    'WAITBAR', true);
gr4_WM_GM = im_gr4_WM_GM.get('GR');

im_gr4_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/Healthy_PositiveAmyloid.vois.xlsx')) filesep 'Healthy_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'},...
    'WAITBAR', true);
gr4_PET = im_gr4_PET.get('GR');
%% ROI constructor


path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('upsampled_AAL2.nii')),FILE_PATH('PATH', which('upsampled_TD.nii'))} ...
    );

mapping_path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('AAL2_Atlas_Labels_Abbre.csv')),FILE_PATH('PATH', which('TD_Atlas_Labels.csv'))} ...
    );
% Import two brain atlases
im_ba1 = ImporterBrainAtlasXLS('FILE', which('aal120_atlas.xlsx'),  'WAITBAR', true);
ba1 = im_ba1.get('BA');
im_ba2 = ImporterBrainAtlasXLS('FILE', which('TD_atlas.xlsx'), 'WAITBAR', true);
ba2 = im_ba2.get('BA');

% Create ItemList for BA
ba_list = {ba1, ba2}; 
atlas = ba_list{1};
br_dict = atlas.get('BR_DICT');
selected_ids = num2cell(1:120);
selected_br = cellfun(@(id) br_dict.get('IT', id), selected_ids, 'UniformOutput', false);
selected_br_dict = IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST',  {selected_br{1:94}});
gr1 = SUVRConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'ATLAS_KIND', {'AAL2','TD'}, ...
    'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr1 = gr1.get('GR');

gr2 = SUVRConstructor('GR_PET',gr2_PET, ...
    'GR_T1',gr2_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'ATLAS_KIND', {'AAL2','TD'}, ...
    'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr2 = gr2.get('GR');

gr3 = SUVRConstructor('GR_PET',gr3_PET, ...
    'GR_T1',gr3_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'ATLAS_KIND', {'AAL2','TD'}, ...
    'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr3 = gr3.get('GR');

gr4 = SUVRConstructor('GR_PET',gr4_PET, ...
    'GR_T1',gr4_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'ATLAS_KIND', {'AAL2','TD'}, ...
    'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr4 = gr4.get('GR');
%% Load Groups of SubjectCON Distance based
im_gr1 = IndividualDistanceConConstructor( ...
    'GR_SUVR', SUVR_gr1);

Con_gr1 = im_gr1.get('GR');

im_gr2 = IndividualDistanceConConstructor( ...
    'GR_SUVR', SUVR_gr2);

Con_gr2 = im_gr2.get('GR');

im_gr3 = IndividualDistanceConConstructor( ...
    'GR_SUVR', SUVR_gr3);

Con_gr3 = im_gr3.get('GR');

im_gr4 = IndividualDistanceConConstructor( ...
    'GR_SUVR', SUVR_gr4);

Con_gr4 = im_gr4.get('GR');

%% Analysis CON WU
a_WU1 = AnalyzeEnsemble_CON_WU( ...
    'GR', Con_gr1 ...
    );

a_WU2 = AnalyzeEnsemble_CON_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', Con_gr2 ...
    );

a_WU3 = AnalyzeEnsemble_CON_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', Con_gr3 ...
    );

a_WU1.memorize('G_DICT');
a_WU2.memorize('G_DICT');
a_WU3.memorize('G_DICT');

% a_WU1.get('MEASUREENSEMBLE', 'Degree').get('M');
% a_BUD1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
% a_BUD1.get('MEASUREENSEMBLE', 'Distance').get('M');

% a_WU2.get('MEASUREENSEMBLE', 'Degree').get('M');
% a_BUD2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
% a_BUD2.get('MEASUREENSEMBLE', 'Distance').get('M');

% a_WU3.get('MEASUREENSEMBLE', 'Degree').get('M');
% a_BUD3.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
% a_BUD3.get('MEASUREENSEMBLE', 'Distance').get('M');
% c_WU = CompareEnsemble('P', 1000, 'A1', a_WU1, 'A2', a_WU2, 'MEMORIZE', true); % Compare Groups % Group Comparison
% 
% degree_WU_diff = c_WU.get('COMPARISON', 'Degree').get('DIFF');
% degree_WU_p1 = c_WU.get('COMPARISON', 'Degree').get('P1');
% degree_WU_p2 = c_WU.get('COMPARISON', 'Degree').get('P2');
% degree_WU_cil = c_WU.get('COMPARISON', 'Degree').get('CIL');
% degree_WU_ciu = c_WU.get('COMPARISON', 'Degree').get('CIU');
suvr_data1 = cell2mat(cellfun(@(x) x.get('ST'), SUVR_gr1.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false));
suvr_data2 = cell2mat(cellfun(@(x) x.get('ST'), SUVR_gr2.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false));
suvr_data3 = cell2mat(cellfun(@(x) x.get('ST'), SUVR_gr3.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false));

% Combine all SUVR values into vectors for each group
suvr_vec1 = suvr_data1(:);
suvr_vec2 = suvr_data2(:);
suvr_vec3 = suvr_data3(:);
all_suvr = [suvr_vec1; suvr_vec2; suvr_vec3];

% Create a grouping variable matching each value to its group
group_labels = [repmat({'CN'}, length(suvr_vec1), 1); ...
                repmat({'MCI'}, length(suvr_vec2), 1); ...
                repmat({'AD'}, length(suvr_vec3), 1)];

% Create the boxplot
figure;
boxplot(all_suvr, group_labels);
title('Boxplot of SUVR Values by Group');
xlabel('Group');
ylabel('SUVR');
grid on;
% Step 1: Get the cell array of vectorized connectivity data
vec_cell1 = cellfun(@(x) x.get('CON'), Con_gr1.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
vec_cell2 = cellfun(@(x) x.get('CON'), Con_gr2.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
vec_cell3 = cellfun(@(x) x.get('CON'), Con_gr3.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);


% Step 2: Initialize variables
N1 = length(vec_cell1);  % Number of subjects
N2 = length(vec_cell2);  % Number of subjects
N3 = length(vec_cell3);  % Number of subjects
n_regions = 94;        % Number of regions (adjust if different)

% Initialize arrays to store mean connectivity for each subject
CN_mean_list = zeros(N1, 1);
for i = 1:N1
    vec = vec_cell1{i};  % Vectorized upper triangular data for subject i
    CN_mean_list(i) = mean(vec,'all');  % Calculate mean connectivity
end

MCI_mean_list = zeros(N2, 1);
for i = 1:N2
    vec = vec_cell2{i};  % Vectorized upper triangular data for subject i
    MCI_mean_list(i) = mean(vec,'all');  % Calculate mean connectivity
end

AD_mean_list = zeros(N3, 1);
for i = 1:N3
    vec = vec_cell3{i};  % Vectorized upper triangular data for subject i
    AD_mean_list(i) = mean(vec,'all');  % Calculate mean connectivity
end

% Prepare data for boxplot
% Create a matrix where each column corresponds to a group's means
max_subjects = max([N1, N2, N3]);  % Find the largest group size
data = NaN(max_subjects, 3);       % Initialize matrix with NaN
data(1:N1, 1) = CN_mean_list;      % Fill CN group data
data(1:N2, 2) = MCI_mean_list;     % Fill MCI group data
data(1:N3, 3) = AD_mean_list;      % Fill AD group data

% Generate boxplot
figure;
boxplot(data, 'Labels', {'CN', 'MCI', 'AD'});
title('Boxplot of Mean Connectivity by Group');
xlabel('Group');
ylabel('Mean Connectivity');
grid on;

%% NN DATASET

it_list1 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {gr1_PET.get('ID')}), ...
    Con_gr1.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% Get the subject dictionary and extract the list of subjects
sub_dict1 = gr1_WM_GM.get('SUB_DICT');
sub_list1 = sub_dict1.get('IT_LIST'); % Get all subjects as a cell array
[~, group_folder_name1] = fileparts(im_gr1_PET.get('DIRECTORY'));
% Use cellfun to create NNDataPoint_VOIs for each subject
it_list_voi1 = cellfun(@(sub) NNDataPoint_VOIs( ...
    'ID', sub.get('ID'), ...
    'VOI_DICT', IndexedDictionary( ...
        'ID', 'subject_idict', ...
        'IT_CLASS', 'SubjectNIfTI', ...
        'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
        'IT_LIST', sub.get('VOI_DICT').get('IT_LIST') ...
        ), ...
    'TARGET_CLASS', {group_folder_name1} ...
    ), sub_list1, 'UniformOutput', false);


it_list2 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {gr2_PET.get('ID')}), ...
    Con_gr2.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);
% Get the subject dictionary and extract the list of subjects
sub_dict2 = gr2_WM_GM.get('SUB_DICT');
sub_list2 = sub_dict2.get('IT_LIST'); % Get all subjects as a cell array
[~, group_folder_name2] = fileparts(im_gr2_PET.get('DIRECTORY'));
% Use cellfun to create NNDataPoint_VOIs for each subject
it_list_voi2 = cellfun(@(sub) NNDataPoint_VOIs( ...
    'ID', sub.get('ID'), ...
    'VOI_DICT', IndexedDictionary( ...
        'ID', 'subject_idict', ...
        'IT_CLASS', 'SubjectNIfTI', ...
        'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
        'IT_LIST', sub.get('VOI_DICT').get('IT_LIST') ...
        ), ...
    'TARGET_CLASS', {group_folder_name2} ...
    ), sub_list2, 'UniformOutput', false);

it_list3 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {gr3_PET.get('ID')}), ...
    Con_gr3.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);
% Get the subject dictionary and extract the list of subjects
sub_dict3 = gr3_WM_GM.get('SUB_DICT');
sub_list3 = sub_dict3.get('IT_LIST'); % Get all subjects as a cell array
[~, group_folder_name3] = fileparts(im_gr3_PET.get('DIRECTORY'));
% Use cellfun to create NNDataPoint_VOIs for each subject
it_list_voi3 = cellfun(@(sub) NNDataPoint_VOIs( ...
    'ID', sub.get('ID'), ...
    'VOI_DICT', IndexedDictionary( ...
        'ID', 'subject_idict', ...
        'IT_CLASS', 'SubjectNIfTI', ...
        'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
        'IT_LIST', sub.get('VOI_DICT').get('IT_LIST') ...
        ), ...
    'TARGET_CLASS', {group_folder_name3} ...
    ), sub_list3, 'UniformOutput', false);

it_list4 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {gr4_PET.get('ID')}), ...
    Con_gr4.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);
% Get the subject dictionary and extract the list of subjects
sub_dict4 = gr4_WM_GM.get('SUB_DICT');
sub_list4 = sub_dict4.get('IT_LIST'); % Get all subjects as a cell array
[~, group_folder_name4] = fileparts(im_gr4_PET.get('DIRECTORY'));
% Use cellfun to create NNDataPoint_VOIs for each subject
it_list_voi4 = cellfun(@(sub) NNDataPoint_VOIs( ...
    'ID', sub.get('ID'), ...
    'VOI_DICT', IndexedDictionary( ...
        'ID', 'subject_idict', ...
        'IT_CLASS', 'SubjectNIfTI', ...
        'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
        'IT_LIST', sub.get('VOI_DICT').get('IT_LIST') ...
        ), ...
    'TARGET_CLASS', {group_folder_name4} ...
    ), sub_list4, 'UniformOutput', false);


% create NNDataPoint_CON_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_CLA', ...
        'IT_LIST', it_list2 ...
        );

dp_list3 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_CLA', ...
        'IT_LIST', it_list3 ...
        );

dp_list4 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_CLA', ...
        'IT_LIST', it_list4 ...
        );

dp_list_voi1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_VOIs', ...
        'IT_LIST', it_list_voi1 ...
        );

dp_list_voi2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_VOIs', ...
        'IT_LIST', it_list_voi2 ...
        );

dp_list_voi3 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_VOIs', ...
        'IT_LIST', it_list_voi3 ...
        );

dp_list_voi4 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_VOIs', ...
        'IT_LIST', it_list_voi4 ...
        );

d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Graph_CLA', ...
    'DP_DICT', dp_list1 ...
    );
d1_vois = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_VOIs', ...
    'DP_DICT', dp_list_voi1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Graph_CLA', ...
    'DP_DICT', dp_list2 ...
    );
d2_vois = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_VOIs', ...
    'DP_DICT', dp_list_voi2 ...
    );

d3 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Graph_CLA', ...
    'DP_DICT', dp_list3 ...
    );
d3_vois = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_VOIs', ...
    'DP_DICT', dp_list_voi3 ...
    );
d4 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Graph_CLA', ...
    'DP_DICT', dp_list4 ...
    );
d4_vois = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_VOIs', ...
    'DP_DICT', dp_list_voi4 ...
    );
% %% Create a classifier cross-validation and compute metrics
% num_runs = 100;
% confusion_matrix_mci = cell(num_runs, 1);
% av_macro_auc_mci = zeros(num_runs, 1);
% sensitivity_mci = zeros(num_runs, 1);
% specificity_mci = zeros(num_runs, 1);
% 
% confusion_matrix_ad = cell(num_runs, 1);
% av_macro_auc_ad = zeros(num_runs, 1);
% sensitivity_ad = zeros(num_runs, 1);
% specificity_ad = zeros(num_runs, 1);
% 
% parfor run = 1:num_runs
%     rng(run)
%     % CN vs. MCI Classification
%     nn_template = NNClassifierMLP_VOIs('EPOCHS', 50, 'LAYERS', [128 128]);
%     num_dp_d1 = d1.get('DP_DICT').get('LENGTH');
%     num_dp_d2 = d2.get('DP_DICT').get('LENGTH');
%     shuffled_indices_d1 = randperm(num_dp_d1);
%     shuffled_indices_d2 = randperm(num_dp_d2);
%     split_points_d1 = round(linspace(0, num_dp_d1, 6));
%     split_points_d2 = round(linspace(0, num_dp_d2, 6));
%     SPLIT_cn_mci = cell(2, 5);
%     for i = 1:5
%         SPLIT_cn_mci{1, i} = shuffled_indices_d1(split_points_d1(i)+1:split_points_d1(i+1));
%         SPLIT_cn_mci{2, i} = shuffled_indices_d2(split_points_d2(i)+1:split_points_d2(i+1));
%     end
%     nncv_mci = NNClassifierMLP_CrossValidation_VOIs('D', {d1, d2}, 'D_VOIS', {d1_vois, d2_vois}, ...
%         'KFOLDS', 5, 'NN_TEMPLATE', nn_template, 'SPLIT', SPLIT_cn_mci);
%     nncv_mci.get('TRAIN');
% 
%     % Evaluate performance for CN vs. MCI
%     cm_mci = nncv_mci.get('C_MATRIX');
%     confusion_matrix_mci{run} = cm_mci;
%     av_macro_auc_mci(run) = nncv_mci.get('AV_MACRO_AUC');
%     TP = cm_mci(2,2); TN = cm_mci(1,1); FP = cm_mci(1,2); FN = cm_mci(2,1);
%     sensitivity_mci(run) = TP / (TP + FN);
%     specificity_mci(run) = TN / (TN + FP);
%     rng(run)
%     % CN vs. AD Classification
%     nn_template = NNClassifierMLP_VOIs('EPOCHS', 50, 'LAYERS', [128 128]);
%     num_dp_d3 = d3.get('DP_DICT').get('LENGTH');
%     num_dp_d1 = d1.get('DP_DICT').get('LENGTH');
%     shuffled_indices_d3 = randperm(num_dp_d3);
%     shuffled_indices_d1 = randperm(num_dp_d1);
%     split_points_d3 = round(linspace(0, num_dp_d3, 6));
%     split_points_d1 = round(linspace(0, num_dp_d1, 6));
%     SPLIT_cn_ad = cell(2, 5);
%     for i = 1:5
%         SPLIT_cn_ad{1, i} = shuffled_indices_d1(split_points_d1(i)+1:split_points_d1(i+1));
%         SPLIT_cn_ad{2, i} = shuffled_indices_d3(split_points_d3(i)+1:split_points_d3(i+1));
%     end
%     nncv_ad = NNClassifierMLP_CrossValidation_VOIs('D', {d1, d3}, 'D_VOIS', {d1_vois, d3_vois}, ...
%         'KFOLDS', 5, 'NN_TEMPLATE', nn_template, 'SPLIT', SPLIT_cn_ad);
%     nncv_ad.get('TRAIN');
% 
%     % Evaluate performance for CN vs. AD
%     cm_ad = nncv_ad.get('C_MATRIX');
%     confusion_matrix_ad{run} = cm_ad;
%     av_macro_auc_ad(run) = nncv_ad.get('AV_MACRO_AUC');
%     TP = cm_ad(2,2); TN = cm_ad(1,1); FP = cm_ad(1,2); FN = cm_ad(2,1);
%     sensitivity_ad(run) = TP / (TP + FN);
%     specificity_ad(run) = TN / (TN + FP);
% end
% 
% %% Save Results
% results.CN_vs_MCI.Confusion = confusion_matrix_mci;
% results.CN_vs_MCI.AUC = av_macro_auc_mci(av_macro_auc_mci~=0);
% results.CN_vs_MCI.Spe = specificity_mci(specificity_mci~=0);
% results.CN_vs_MCI.Sen = sensitivity_mci(sensitivity_mci~=0);
% results.CN_vs_AD.Confusion = confusion_matrix_ad;
% results.CN_vs_AD.AUC = av_macro_auc_ad(av_macro_auc_ad~=0);
% results.CN_vs_AD.Spe = specificity_ad(specificity_ad~=0);
% results.CN_vs_AD.Sen = sensitivity_ad(sensitivity_ad~=0);
% save('classification_results_distance_matrixClassification.mat', 'results');
% 
% %% Generate Boxplots for CN vs. MCI
% figure('Name', 'Performance Metrics for CN vs. MCI', 'NumberTitle', 'off');
% sgtitle('Performance Metrics for CN vs. MCI', 'FontSize', 14);
% 
% % AUC Boxplot
% subplot(1, 3, 1);
% boxplot(av_macro_auc_mci);
% title('AUC');
% xlabel('Runs');
% ylabel('Score');
% ylim([0 1]);
% grid on;
% 
% % Sensitivity Boxplot
% subplot(1, 3, 2);
% boxplot(sensitivity_mci);
% title('Sensitivity');
% xlabel('Runs');
% ylabel('Score');
% ylim([0 1]);
% grid on;
% 
% % Specificity Boxplot
% subplot(1, 3, 3);
% boxplot(specificity_mci);
% title('Specificity');
% xlabel('Runs');
% ylabel('Score');
% ylim([0 1]);
% grid on;
% 
% % Adjust layout
% set(gcf, 'Position', [100, 100, 800, 300]);
% 
% %% Generate Boxplots for CN vs. AD
% figure('Name', 'Performance Metrics for CN vs. AD', 'NumberTitle', 'off');
% sgtitle('Performance Metrics for CN vs. AD', 'FontSize', 14);
% 
% % AUC Boxplot
% subplot(1, 3, 1);
% boxplot(av_macro_auc_ad);
% title('AUC');
% xlabel('Runs');
% ylabel('Score');
% ylim([0 1]);
% grid on;
% 
% % Sensitivity Boxplot
% subplot(1, 3, 2);
% boxplot(sensitivity_ad);
% title('Sensitivity');
% xlabel('Runs');
% ylabel('Score');
% ylim([0 1]);
% grid on;
% 
% % Specificity Boxplot
% subplot(1, 3, 3);
% boxplot(specificity_ad);
% title('Specificity');
% xlabel('Runs');
% ylabel('Score');
% ylim([0 1]);
% grid on;
% 
% % Adjust layout
% set(gcf, 'Position', [100, 100, 800, 300]);

%% Balanced Classification

% Define neural network template
nn_template = NNClassifierMLP_VOIs('EPOCHS', 50, 'LAYERS', [128 128]);

% Define tasks and corresponding group pairs
tasks = {'CN_vs_MCI', 'CN_vs_AD', 'CN_vs_CN_POS'};
group_pairs = {{d1, d2}, {d1, d3}, {d1, d4}};
dp_lists = {{dp_list1, dp_list2}, {dp_list1, dp_list3}, {dp_list1, dp_list4}};
dp_list_vois = {{dp_list_voi1, dp_list_voi2}, {dp_list_voi1, dp_list_voi3}, {dp_list_voi1, dp_list_voi4}};

% Number of runs
num_runs = 100;

% Initialize results structure
results = struct();
x_mean = {};
y_mean = {};
% Start timing
tic

% Perform classification for each task
for task_idx = 1:length(tasks)
    task_name = tasks{task_idx};
    disp(task_name)
    group1 = group_pairs{task_idx}{1};
    group2 = group_pairs{task_idx}{2};
    dp_list1_task = dp_lists{task_idx}{1};
    dp_list2_task = dp_lists{task_idx}{2};
    dp_list_voi1_task = dp_list_vois{task_idx}{1};
    dp_list_voi2_task = dp_list_vois{task_idx}{2};
    
    % Get group sizes
    num_dp1 = group1.get('DP_DICT').get('LENGTH');
    num_dp2 = group2.get('DP_DICT').get('LENGTH');
    if num_dp1 == 0 || num_dp2 == 0
        error([task_name ' task failed: One of the groups has no subjects.']);
    end
    min_size = min(num_dp1, num_dp2);
    
    % Parallel loop over runs
    parfor run = 1:num_runs
        rng(run); % Set random seed for reproducibility
        
        % Balance groups by sampling
        shuffled_indices1 = randperm(num_dp1, min_size);
        shuffled_indices2 = randperm(num_dp2, min_size);
        
        % Create data subsets
        dp_subset1 = arrayfun(@(idx) dp_list1_task.get('IT', idx), shuffled_indices1, 'UniformOutput', false);
        dp_subset2 = arrayfun(@(idx) dp_list2_task.get('IT', idx), shuffled_indices2, 'UniformOutput', false);
        dp_voi_subset1 = arrayfun(@(idx) dp_list_voi1_task.get('IT', idx), shuffled_indices1, 'UniformOutput', false);
        dp_voi_subset2 = arrayfun(@(idx) dp_list_voi2_task.get('IT', idx), shuffled_indices2, 'UniformOutput', false);
        
        % Create balanced datasets
        d_balanced1 = NNDataset('DP_CLASS', 'NNDataPoint_Graph_CLA', ...
            'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_Graph_CLA', 'IT_LIST', dp_subset1));
        d_balanced2 = NNDataset('DP_CLASS', 'NNDataPoint_Graph_CLA', ...
            'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_Graph_CLA', 'IT_LIST', dp_subset2));
        d_vois_balanced1 = NNDataset('DP_CLASS', 'NNDataPoint_VOIs', ...
            'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_VOIs', 'IT_LIST', dp_voi_subset1));
        d_vois_balanced2 = NNDataset('DP_CLASS', 'NNDataPoint_VOIs', ...
            'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_VOIs', 'IT_LIST', dp_voi_subset2));
        
        % Set up cross-validation splits
        split_indices1 = randperm(min_size);
        split_indices2 = randperm(min_size);
        split_points1 = round(linspace(0, min_size, 6));
        split_points2 = round(linspace(0, min_size, 6));
        SPLIT = cell(2, 5);
        for i = 1:5
            SPLIT{1, i} = split_indices1(split_points1(i)+1:split_points1(i+1));
            SPLIT{2, i} = split_indices2(split_points2(i)+1:split_points2(i+1));
        end
        
        % Train and evaluate classifier
        nncv = NNClassifierMLP_CrossValidation_VOIs('D', {d_balanced1, d_balanced2}, ...
            'D_VOIS', {d_vois_balanced1, d_vois_balanced2}, 'KFOLDS', 5, ...
            'NN_TEMPLATE', nn_template, 'SPLIT', SPLIT);
        nncv.get('TRAIN');
        %%
        [x_mean{run}, y_mean{run}] = get_roc(nncv);
        % Extract metrics
        cm = nncv.get('C_MATRIX');
        av_macro_auc = nncv.get('AV_MACRO_AUC');
        TP = cm(2,2); TN = cm(1,1); FP = cm(1,2); FN = cm(2,1);
        sensitivity = TP / (TP + FN);
        specificity = TN / (TN + FP);
        % Store results for this run
        cm_scores{run} = cm;
        auc_scores(run) = av_macro_auc;
        sensitivity_scores(run) = sensitivity;
        specificity_scores(run) = specificity;

    end

    results.(task_name).confusion_matrix = cm_scores;
    results.(task_name).av_macro_auc = auc_scores;
    results.(task_name).sensitivity = sensitivity_scores;
    results.(task_name).specificity = specificity_scores;
    results.(task_name).ROC_X = x_mean;
    results.(task_name).ROC_Y = y_mean;

end

% End timing
toc
%% Save Results

save('Results/matrix/withConverters/classification_results_distance_matrixClassification_Balanced.mat', 'results');
%% figure for cn vs cn pos
figure('Name', 'Performance Metrics of perturbation for CN vs. CN pos', 'NumberTitle', 'off');
sgtitle('Performance Metrics for of perturbation CN vs. CN pos', 'FontSize', 14);

% AUC Boxplot
subplot(1, 3, 1);
boxplot(results.CN_vs_CN_POS.av_macro_auc);
title('AUC');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

% Sensitivity Boxplot
subplot(1, 3, 2);
boxplot(results.CN_vs_CN_POS.av_macro_auc);
title('Sensitivity');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

% Specificity Boxplot
subplot(1, 3, 3);
boxplot(results.CN_vs_CN_POS.av_macro_auc);
title('Specificity');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

%% Generate Boxplots for CN vs. MCI
figure('Name', 'Performance Metrics of perturbation for CN vs. MCI', 'NumberTitle', 'off');
sgtitle('Performance Metrics of perturbation for CN vs. MCI', 'FontSize', 14);

% AUC Boxplot
subplot(1, 3, 1);
boxplot(results.CN_vs_MCI.av_macro_auc);
title('AUC');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

% Sensitivity Boxplot
subplot(1, 3, 2);
boxplot(results.CN_vs_MCI.sensitivity);
title('Sensitivity');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

% Specificity Boxplot
subplot(1, 3, 3);
boxplot(results.CN_vs_MCI.specificity);
title('Specificity');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

% Adjust layout
set(gcf, 'Position', [100, 100, 800, 300]);

%% Generate Boxplots for CN vs. AD
figure('Name', 'Performance Metrics of perturbation for CN vs. AD', 'NumberTitle', 'off');
sgtitle('Performance Metrics for of perturbation CN vs. AD', 'FontSize', 14);

% AUC Boxplot
subplot(1, 3, 1);
boxplot(results.CN_vs_AD.av_macro_auc);
title('AUC');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

% Sensitivity Boxplot
subplot(1, 3, 2);
boxplot(results.CN_vs_AD.av_macro_auc);
title('Sensitivity');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

% Specificity Boxplot
subplot(1, 3, 3);
boxplot(results.CN_vs_AD.av_macro_auc);
title('Specificity');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

% Adjust layout
set(gcf, 'Position', [100, 100, 800, 300]);

function [x_mean, y_mean] = get_roc(nncv)
    % GET_ROC Computes mean ROC curve values (FPR and TPR) across folds for a given classifier.
    %
    % Inputs:
    %   nncv - The cross-validation object containing neural networks and evaluators.
    %
    % Outputs:
    %   x_mean - Mean false positive rates (FPR) across all folds.
    %   y_mean - Mean true positive rates (TPR) across all folds.
    class_names = {};
    D = nncv.get('D');
    for ld = 1:length(D)
        dataset = D{ld}; % Assuming classes are same across folds
        dp_dict = dataset.get('DP_DICT');
        items = dp_dict.get('IT_LIST'); % Get all items
        target_classes = cellfun(@(dp) dp.get('TARGET_CLASS'), items, 'UniformOutput', false);
        class_name = unique(cellfun(@unique, target_classes));
        class_names{ld} = class_name{1};
    end
    % Retrieve class names and lists of neural networks and evaluators
    % class_names = {'negative', 'positive'};%nncv.get('PFROC').get('CLASSNAMES');
    NN_LIST = nncv.get('NN_LIST');
    EVALUATOR_LIST = nncv.get('EVALUATOR_LIST');
    
    % Determine the number of folds
    num_folds = length(NN_LIST);
    
    % Initialize cell arrays to store predictions and ground truths
    predictions_folds = cell(1, num_folds);
    ground_truth_folds = cell(1, num_folds);
    
    % Compute predictions for each fold
    for i = 1:num_folds
        nn = NN_LIST{i};
        nne = EVALUATOR_LIST{i};
        predictions_folds{i} = cell2mat(nn.get('PREDICT', nne.get('D'), nne.get('D_VOIS')));
    end
    
    % Retrieve ground truth for each fold
    for i = 1:num_folds
        nne = EVALUATOR_LIST{i};
        ground_truth_folds{i} = nne.get('GROUND_TRUTH');
    end
    
    % Initialize arrays to store ROC curve points
    x_val_run = [];
    y_val_run = [];
    counter = 0;
    
    % Compute ROC curves for each fold and class
    for k = 1:num_folds
        predictions_fold = predictions_folds{k};
        ground_truth_fold = ground_truth_folds{k};
        rocNet = rocmetrics(ground_truth_fold, predictions_fold, class_names);
        for j = 1:length(class_names)
            counter = counter + 1;
            idx_class = strcmp(rocNet.Metrics.ClassName, class_names{j});
            y_val_class = rocNet.Metrics(idx_class,:).TruePositiveRate;
            x_val_class = rocNet.Metrics(idx_class,:).FalsePositiveRate;
            
            % Ensure consistent length for ROC curves
            if counter == 1
                % Use the first curve as the reference
                y_val_run = y_val_class;
                x_val_run = x_val_class;
            else
                % Interpolate subsequent curves to match the reference length
                fixed_length = length(x_val_run);
                x_val_class_interp = interp1(linspace(0, 1, length(x_val_class)), x_val_class, linspace(0, 1, fixed_length), 'linear');
                y_val_class_interp = interp1(linspace(0, 1, length(y_val_class)), y_val_class, linspace(0, 1, fixed_length), 'linear');
                
                % Append interpolated values
                x_val_run = [x_val_run, x_val_class_interp'];
                y_val_run = [y_val_run, y_val_class_interp'];
            end
        end
    end
    
    % Compute the mean FPR and TPR across all folds
    x_mean = mean(x_val_run, 2);
    y_mean = mean(y_val_run, 2);
end