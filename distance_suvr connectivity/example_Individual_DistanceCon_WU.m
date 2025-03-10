% EXAMPLE_CON_WU
% Script example pipeline Distance CON WU

clear variables %#ok<*NASGU>
%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [which('aal94_atlas.xlsx')], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% load Nifty images
%%group1
im_gr1_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('AD_PositiveAmyloid.vois.xlsx')) filesep 'AD_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'WM','GM'},...
    'WAITBAR', true);
gr1_WM_GM = im_gr1_WM_GM.get('GR');

im_gr1_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('AD_PositiveAmyloid.vois.xlsx')) filesep 'AD_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'},...
    'WAITBAR', true);
gr1_PET = im_gr1_PET.get('GR');

%%group2
im_gr2_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY',[fileparts(which('Healthy_NegativeAmyloid.vois.xlsx')) filesep 'Healthy_NegativeAmyloid'], ...
    'NIFTI_TYPE', {'WM','GM'},...
    'WAITBAR', true);
gr2_WM_GM = im_gr2_WM_GM.get('GR');

im_gr2_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Healthy_NegativeAmyloid.vois.xlsx')) filesep 'Healthy_NegativeAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'},...
    'WAITBAR', true);
gr2_PET = im_gr2_PET.get('GR');

%%group3
im_gr3_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('MCI_PositiveAmyloid.vois.xlsx')) filesep 'MCI_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'WM','GM'},...
    'WAITBAR', true);
gr3_WM_GM = im_gr3_WM_GM.get('GR');

im_gr3_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('MCI_PositiveAmyloid.vois.xlsx')) filesep 'MCI_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'},...
    'WAITBAR', true);
gr3_PET = im_gr3_PET.get('GR');
%% ROI constructor

path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH',which('upsampled_AAL2.nii')),FILE_PATH('PATH', which('upsampled_TD.nii'))} ...
    );

gr1 = SUVRConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_KIND', {'AAL2','TD'});
SUVR_gr1 = gr1.get('GR');

gr2 = SUVRConstructor('GR_PET',gr2_PET, ...
    'GR_T1',gr2_WM_GM, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_KIND', {'AAL2','TD'});
SUVR_gr2 = gr2.get('GR');

gr3 = SUVRConstructor('GR_PET',gr3_PET, ...
    'GR_T1',gr3_WM_GM, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_KIND', {'AAL2','TD'});
SUVR_gr3 = gr3.get('GR');

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

%% Analysis CON WU
a_WU1 = AnalyzeEnsemble_CON_WU( ...
    'GR', Con_gr1 ...
    );

a_WU2 = AnalyzeEnsemble_CON_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', Con_gr2 ...
    );

a_WU1.memorize('G_DICT');
a_WU2.memorize('G_DICT');

c_WU = CompareEnsemble('P', 1000, 'A1', a_WU1, 'A2', a_WU2, 'MEMORIZE', true); % Compare Groups % Group Comparison

degree_WU_diff = c_WU.get('COMPARISON', 'Degree').get('DIFF');
degree_WU_p1 = c_WU.get('COMPARISON', 'Degree').get('P1');
degree_WU_p2 = c_WU.get('COMPARISON', 'Degree').get('P2');
degree_WU_cil = c_WU.get('COMPARISON', 'Degree').get('CIL');
degree_WU_ciu = c_WU.get('COMPARISON', 'Degree').get('CIU');
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

%% Create a classifier cross-validation
nn_template = NNClassifierMLP_VOIs('EPOCHS', 50, 'LAYERS', [128 128]);
num_dp_d1 = d1.get('DP_DICT').get('LENGTH'); % Number of data points in d1 (assumed same as d1_vois)
num_dp_d2 = d2.get('DP_DICT').get('LENGTH'); % Number of data points in d2 (assumed same as d2_vois)
% Generate shuffled split indices for 5 folds
shuffled_indices_d1 = randperm(num_dp_d1); % Random permutation of indices for d1
shuffled_indices_d2 = randperm(num_dp_d2); % Random permutation of indices for d2
% Calculate split points for 5 equal parts
split_points_d1 = round(linspace(0, num_dp_d1, 6)); % 6 points to define 5 segments
split_points_d2 = round(linspace(0, num_dp_d2, 6)); % 6 points to define 5 segments
SPLIT = cell(2, 5);
for i = 1:5
    SPLIT{1, i} = shuffled_indices_d1(split_points_d1(i)+1:split_points_d1(i+1));
    SPLIT{2, i} = shuffled_indices_d2(split_points_d2(i)+1:split_points_d2(i+1));
end
nncv_ad = NNClassifierMLP_CrossValidation_VOIs('D', {d1, d2}, 'D_VOIS', {d1_vois, d2_vois}, 'KFOLDS', 5, 'NN_TEMPLATE', nn_template, 'SPLIT', SPLIT); % d2 healthy, d1 AD
nncv_ad.get('TRAIN');



%% Evaluate the performance
confusion_matrix_ad = nncv_ad.get('C_MATRIX');
av_auc_ad = nncv_ad.get('AV_AUC');
av_macro_auc_ad = nncv_ad.get('AV_MACRO_AUC');
sensitivity_ad = confusion_matrix_ad(1,1)/ sum(confusion_matrix_ad(:,1));
specificity_ad = confusion_matrix_ad(2,2)/ sum(confusion_matrix_ad(:,2));


%% Create a classifier cross-validation
nn_template = NNClassifierMLP_VOIs('EPOCHS', 50, 'LAYERS', [128 128]);
num_dp_d3 = d3.get('DP_DICT').get('LENGTH'); % Number of data points in d1 (assumed same as d1_vois)
num_dp_d2 = d2.get('DP_DICT').get('LENGTH'); % Number of data points in d2 (assumed same as d2_vois)
% Generate shuffled split indices for 5 folds
shuffled_indices_d3 = randperm(num_dp_d3); % Random permutation of indices for d1
shuffled_indices_d2 = randperm(num_dp_d2); % Random permutation of indices for d2
% Calculate split points for 5 equal parts
split_points_d3 = round(linspace(0, num_dp_d3, 6)); % 6 points to define 5 segments
split_points_d2 = round(linspace(0, num_dp_d2, 6)); % 6 points to define 5 segments
SPLIT = cell(2, 5);
for i = 1:5
    SPLIT{1, i} = shuffled_indices_d3(split_points_d3(i)+1:split_points_d3(i+1));
    SPLIT{2, i} = shuffled_indices_d2(split_points_d2(i)+1:split_points_d2(i+1));
end
nncv_mci = NNClassifierMLP_CrossValidation_VOIs('D', {d3, d2},'D_VOIS', {d3_vois, d2_vois}, 'KFOLDS', 5, 'NN_TEMPLATE', nn_template, 'SPLIT', SPLIT);%d2 healthy, d3 MCI, d1 AD
nncv_mci.get('TRAIN');

%% Evaluate the performance
confusion_matrix_mci = nncv_mci.get('C_MATRIX');
av_auc_mci = nncv_mci.get('AV_AUC');
av_macro_auc_mci = nncv_mci.get('AV_MACRO_AUC');
specificity_mci  = confusion_matrix_mci(1,1)/ sum(confusion_matrix_mci(:,1));
sensitivity_mci = confusion_matrix_mci(2,2)/ sum(confusion_matrix_mci(:,2));

%% Calculate Baseline with ADNI meanROI data
% Load VOI data
voi_table = readtable('/media/hang/EXTERNAL_US/Data/1_HANG_FDG_PET/demographic/UCBERKELEYFDG_8mm_02_17_23_19Jun2024.csv');
bl_meta_rows = voi_table(strcmp(voi_table.VISCODE, 'bl') & strcmp(voi_table.ROINAME, 'MetaROI'), :);
rid_list = bl_meta_rows.RID; % 807×1 double vector
mean_list = bl_meta_rows.MEAN; % 807×1 double vector


nncv_tol = {nncv_ad , nncv_mci};
for h = 1:length(nncv_tol)
    nncv = nncv_tol{h};
    % Get D_LIST and D_VOIS_LIST from nncv
    D_LIST = nncv.get('D_LIST'); % 1×5 cell array of test datasets
    D_VOIS_LIST = nncv.get('D_VOIS_LIST'); % 1×5 cell array of test VOI datasets

    % Initialize arrays to store results for each fold
    auc_scores = zeros(5, 1);
    sensitivity_scores = zeros(5, 1);
    specificity_scores = zeros(5, 1);
    models = cell(5, 1); % To save trained models

    % Perform 5-fold cross-validation
    for i = 1:5
        % Define training folds (all except fold i)
        train_fold_indices = setdiff(1:5, i);

        % Collect training data from 4 folds
        train_subject_ids = {};
        train_target_classes = {};
        train_feature_values = []; % Will store [MetaROI, Age, Sex, Education]
        for k = train_fold_indices
            % Get D and D_VOIS for training fold k
            d_fold = D_LIST{k};
            d_vois_fold = D_VOIS_LIST{k};

            % Extract from D
            dp_dict = d_fold.get('DP_DICT');
            dp_list = dp_dict.get('IT_LIST');

            fold_subject_ids = cellfun(@(dp) dp.get('ID'), dp_list, 'UniformOutput', false);
            fold_target_classes = cellfun(@(dp) dp.get('TARGET_CLASS'), dp_list, 'UniformOutput', false);
            fold_target_classes = cellfun(@(dp) dp{1}, fold_target_classes, 'UniformOutput', false);

            % Extract MetaROI from voi_table
            fold_meta_roi = nan(length(dp_list), 1);
            for j = 1:length(dp_list)
                rid_num = extract_rid(fold_subject_ids{j});
                idx = find(rid_list == rid_num, 1);
                if ~isempty(idx)
                    fold_meta_roi(j) = mean_list(idx);
                end
            end

            % Extract from D_VOIS
            vois_dp_dict = d_vois_fold.get('DP_DICT');
            vois_dp_list = vois_dp_dict.get('IT_LIST');

            fold_age = nan(length(vois_dp_list), 1);
            fold_sex = nan(length(vois_dp_list), 1);

            fold_education = nan(length(vois_dp_list), 1);
            for j = 1:length(vois_dp_list)
                voi_dict = vois_dp_list{j}.get('VOI_DICT');
                voi_items = voi_dict.get('IT_LIST');
                for v = 1:length(voi_items)
                    voi_id = voi_items{v}.get('ID');
                    voi_value = voi_items{v}.get('V');
                    switch voi_id
                        case 'Age'
                            fold_age(j) = voi_value;
                        case 'Sex'
                            fold_sex(j) = voi_value; % Assuming 0 = Female, 1 = Male
                        case 'Education'
                            fold_education(j) = voi_value;
                    end
                end
            end

            % Combine features into a matrix [MetaROI, Age, Sex, Education]
            fold_features = [fold_meta_roi, fold_age, fold_sex, fold_education];

            % Remove NaN values (any row with NaN in any feature)
            valid_idx = ~any(isnan(fold_features), 2);
            fold_subject_ids = fold_subject_ids(valid_idx);
            fold_target_classes = fold_target_classes(valid_idx);
            fold_features = fold_features(valid_idx, :);

            % Append to training data
            train_subject_ids = [train_subject_ids, fold_subject_ids];
            train_target_classes = [train_target_classes, fold_target_classes];
            train_feature_values = [train_feature_values; fold_features];
        end

        % Shuffle training data
        n_train = length(train_subject_ids);
        train_shuffle_idx = randperm(n_train);
        train_subject_ids = train_subject_ids(train_shuffle_idx);
        train_target_classes = train_target_classes(train_shuffle_idx);
        train_feature_values = train_feature_values(train_shuffle_idx, :);

        % Get test data from fold i
        test_d = D_LIST{i};
        test_d_vois = D_VOIS_LIST{i};

        test_dp_dict = test_d.get('DP_DICT');
        test_dp_list = test_dp_dict.get('IT_LIST');

        test_subject_ids = cellfun(@(dp) dp.get('ID'), test_dp_list, 'UniformOutput', false);
        test_target_classes = cellfun(@(dp) dp.get('TARGET_CLASS'), test_dp_list, 'UniformOutput', false);
        test_target_classes = cellfun(@(dp) dp{1}, test_target_classes, 'UniformOutput', false);

        % Extract MetaROI for test data
        test_meta_roi = nan(length(test_dp_list), 1);
        for j = 1:length(test_dp_list)
            rid_num = extract_rid(test_subject_ids{j});
            idx = find(rid_list == rid_num, 1);
            if ~isempty(idx)
                test_meta_roi(j) = mean_list(idx);
            end
        end

        % Extract from D_VOIS for test data
        test_vois_dp_dict = test_d_vois.get('DP_DICT');
        test_vois_dp_list = test_vois_dp_dict.get('IT_LIST');

        test_age = nan(length(test_vois_dp_list), 1);
        test_sex = nan(length(test_vois_dp_list), 1);
        test_education = nan(length(test_vois_dp_list), 1);
        for j = 1:length(test_vois_dp_list)
            voi_dict = test_vois_dp_list{j}.get('VOI_DICT');
            voi_items = voi_dict.get('IT_LIST');
            for v = 1:length(voi_items)
                voi_id = voi_items{v}.get('ID');
                voi_value = voi_items{v}.get('V');
                switch voi_id
                    case 'Age'
                        test_age(j) = voi_value;
                    case 'Sex'
                        test_sex(j) = voi_value; % Assuming 0 = Female, 1 = Male
                    case 'Education'
                        test_education(j) = voi_value;
                end
            end
        end

        % Combine test features
        test_feature_values = [test_meta_roi, test_age, test_sex, test_education];

        % Remove NaN values from test data
        valid_test_idx = ~any(isnan(test_feature_values), 2);
        test_subject_ids = test_subject_ids(valid_test_idx);
        test_target_classes = test_target_classes(valid_test_idx);
        test_feature_values = test_feature_values(valid_test_idx, :);

        % Shuffle test data
        n_test = length(test_subject_ids);
        test_shuffle_idx = randperm(n_test);
        test_subject_ids = test_subject_ids(test_shuffle_idx);
        test_target_classes = test_target_classes(test_shuffle_idx);
        test_feature_values = test_feature_values(test_shuffle_idx, :);

        % Train KNN classifier on shuffled training data
        mdl = fitcknn(train_feature_values, train_target_classes, 'NumNeighbors', 15);
        models{i} = mdl; % Save the trained model

        % Predict probabilities on shuffled test data
        [~, scores] = predict(mdl, test_feature_values);

        % Convert labels to binary (assuming binary classification)
        unique_labels = unique(train_target_classes);
        if length(unique_labels) ~= 2
            error('This script assumes binary classification.');
        end
        positive_class = unique_labels{1}; % Adjust based on your data (e.g., 'AD_PositiveAmyloid')
        test_labels_binary = strcmp(test_target_classes, positive_class);

        % Calculate AUC using positive class probabilities
        [~, ~, ~, auc] = perfcurve(test_labels_binary, scores(:, 1), true);
        auc_scores(i) = auc;

        % Predict on test data for sensitivity and specificity
        predictions = predict(mdl, test_feature_values);
        tp = sum(strcmp(predictions, positive_class) & test_labels_binary);
        tn = sum(~strcmp(predictions, positive_class) & ~test_labels_binary);
        fp = sum(strcmp(predictions, positive_class) & ~test_labels_binary);
        fn = sum(~strcmp(predictions, positive_class) & test_labels_binary);

        sensitivity_scores(i) = tp / (tp + fn);
        specificity_scores(i) = tn / (tn + fp);
    end

    % Calculate average metrics
    avg_auc = mean(auc_scores);
    avg_sensitivity = mean(sensitivity_scores);
    avg_specificity = mean(specificity_scores);

    % Retrieve MLP performance (assuming AUC is available)
    mlp_auc = nncv.get('AV_AUC'); % Adjust property name if needed

    % Display results
    fprintf('Baseline KNN (k=15):\n');
    fprintf('Average AUC: %.4f\n', avg_auc);
    fprintf('Average Sensitivity: %.4f\n', avg_sensitivity);
    fprintf('Average Specificity: %.4f\n', avg_specificity);
    fprintf('MLPclassifier_VOIs AUC: %.4f\n', mlp_auc);
    fprintf('Difference (Baseline AUC - MLP AUC): %.4f\n', avg_auc - mlp_auc);

    fprintf('Average AUC CN VS AD: %.4f\n', av_macro_auc_ad);
    fprintf('Average Sensitivity AD: %.4f\n', sensitivity_ad);
    fprintf('Average Specificity AD: %.4f\n', specificity_ad);

    fprintf('Average AUC CN VS MCI: %.4f\n', av_macro_auc_mci);
    fprintf('Average Sensitivity MCI: %.4f\n', sensitivity_mci);
    fprintf('Average Specificity MCI: %.4f\n', specificity_mci);
end
% Function to extract RID from subject ID
function rid_num = extract_rid(subject_id)
parts = strsplit(subject_id, '_S_');
rid_str = parts{1}; % e.g., '002'
rid_num = str2double(rid_str); % e.g., 2
end
