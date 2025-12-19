% EXAMPLE_CON_WU
% Script example pipeline Distance CON WU

clear variables
%% load group data
im_gr3_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('AD_PositiveAmyloid.vois.xlsx')) filesep 'AD_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'},...
    'WAITBAR', true);
gr3_WM_GM = im_gr3_WM_GM.get('GR');

im_gr3_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('AD_PositiveAmyloid.vois.xlsx')) filesep 'AD_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'},...
    'WAITBAR', true);
gr3_PET = im_gr3_PET.get('GR');

%%group1
im_gr1_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY',[fileparts(which('Healthy_PositiveAmyloid.vois.xlsx')) filesep 'Healthy_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'},...
    'WAITBAR', true);
gr1_WM_GM = im_gr1_WM_GM.get('GR');

im_gr1_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Healthy_PositiveAmyloid.vois.xlsx')) filesep 'Healthy_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'},...
    'WAITBAR', true);
gr1_PET = im_gr1_PET.get('GR');

%%group2
im_gr2_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('MCI_PositiveAmyloid.vois.xlsx')) filesep 'MCI_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'},...
    'WAITBAR', true);
gr2_WM_GM = im_gr2_WM_GM.get('GR');

im_gr2_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('MCI_PositiveAmyloid.vois.xlsx')) filesep 'MCI_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'},...
    'WAITBAR', true);
gr2_PET = im_gr2_PET.get('GR');

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
selected_ids = num2cell(1:94);
selected_br = cellfun(@(id) br_dict.get('IT', id), selected_ids, 'UniformOutput', false);
selected_br_dict = IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', {selected_br{1:94}});
gr1 = SUVRConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr1 = gr1.get('GR');

gr2 = SUVRConstructor('GR_PET',gr2_PET, ...
    'GR_T1',gr2_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr2 = gr2.get('GR');

gr3 = SUVRConstructor('GR_PET',gr3_PET, ...
    'GR_T1',gr3_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr3 = gr3.get('GR');


%% Define number of runs and folds
num_runs = 100;
num_folds = 5;

% Define tasks
tasks = {'CN_pos_vs_MCI', 'CN_pos_vs_AD'};

% Define group lists and features including VOI subjects
group_list = {
    'MCI', SUVR_gr2.get('SUB_DICT').get('IT_LIST'), gr2_WM_GM.get('SUB_DICT').get('IT_LIST');
    'AD', SUVR_gr3.get('SUB_DICT').get('IT_LIST'), gr3_WM_GM.get('SUB_DICT').get('IT_LIST');
    'CN_pos', SUVR_gr1.get('SUB_DICT').get('IT_LIST'), gr1_WM_GM.get('SUB_DICT').get('IT_LIST');
};


% Neural network template
nn_template = NNClassifierMLP_VOIs('EPOCHS', 50, 'LAYERS', [128 128]);

results = struct();

% Loop over tasks
for h = 1:length(tasks)
    task_name = tasks{h};
    disp(task_name)
    groups = strsplit(task_name, '_vs_');
    group_A_name = groups{1};
    group_B_name = groups{2};
    
    % Find group indices
    idx_A = find(strcmp({group_list{:,1}}, group_A_name));
    idx_B = find(strcmp({group_list{:,1}}, group_B_name));
    
    sub_list_A = group_list{idx_A, 2};
    sub_list_B = group_list{idx_B, 2};
    
    sub_list_A_voi = group_list{idx_A, 3};
    sub_list_B_voi = group_list{idx_B, 3};

    auc_scores = zeros(num_runs, 1);
    sensitivity_scores = zeros(num_runs, 1);
    specificity_scores = zeros(num_runs, 1);
    confusion_matrixs = cell(num_runs, 1);
    PFROCXs = cell(num_runs, 1); % Initialize to store PFROCX for each run
    PFROCYs = cell(num_runs, 1); % Initialize to store PFROCY for each run
    

    parfor run = 1:num_runs
        % Set random seed for reproducibility
        rng(run);
        
        % Determine the size of the smaller group
        num_A = length(sub_list_A);
        num_B = length(sub_list_B);
        min_group_size = min(num_A, num_B);
        
        % Randomly sample subjects from both groups to balance them
        idx_A_bal = randperm(num_A, min_group_size);
        idx_B_bal = randperm(num_B, min_group_size);

        % Create balanced subsets
        sub_list_A_bal = sub_list_A(idx_A_bal);
        sub_list_B_bal = sub_list_B(idx_B_bal);

        sub_list_A_bal_voi = sub_list_A_voi(idx_A_bal);
        sub_list_B_bal_voi = sub_list_B_voi(idx_B_bal);
        % Create data points for connectivity using NNDataPoint_Graph_CLA
        dp_list1_ST = cellfun(@(sub) NNDataPoint_ST_CLA('ID', sub.get('ID'), ...
            'SUB', sub, 'TARGET_CLASS', {'negative'}), ...
            sub_list_A_bal, 'UniformOutput', false);
        dp_list2_ST = cellfun(@(sub) NNDataPoint_ST_CLA('ID', sub.get('ID'), ...
            'SUB', sub, 'TARGET_CLASS', {'positive'}), ...
            sub_list_B_bal, 'UniformOutput', false);

        % Create data points for VOIs using NNDataPoint_VOIs
        dp_list1_voi = cellfun(@(sub) NNDataPoint_VOIs('ID', sub.get('ID'), ...
            'VOI_DICT', IndexedDictionary( ...
            'ID', 'subject_voidict', ...
            'IT_CLASS', 'SubjectNIfTI', ...
            'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
            'IT_LIST', sub.get('VOI_DICT').get('IT_LIST') ...
            ), 'TARGET_CLASS', {'negative'}), ...
            sub_list_A_bal_voi, 'UniformOutput', false);
        % Create data points for VOIs using NNDataPoint_VOIs
        dp_list2_voi = cellfun(@(sub) NNDataPoint_VOIs('ID', sub.get('ID'), ...
            'VOI_DICT', IndexedDictionary( ...
            'ID', 'subject_voidict', ...
            'IT_CLASS', 'SubjectNIfTI', ...
            'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
            'IT_LIST', sub.get('VOI_DICT').get('IT_LIST') ...
            ), 'TARGET_CLASS', {'positive'}), ...
            sub_list_B_bal_voi, 'UniformOutput', false);

        % Define split indices for cross-validation
        split_indices_d1 = randperm(min_group_size);
        split_indices_d2 = randperm(min_group_size);
        split_points_d1 = round(linspace(0, min_group_size, num_folds + 1));
        split_points_d2 = round(linspace(0, min_group_size, num_folds + 1));
        SPLIT = cell(2, num_folds);
        for i = 1:num_folds
            SPLIT{1, i} = split_indices_d1(split_points_d1(i)+1:split_points_d1(i+1));
            SPLIT{2, i} = split_indices_d2(split_points_d2(i)+1:split_points_d2(i+1));
        end
        
        % Create datasets for connectivity
        d1_st = NNDataset('DP_CLASS', 'NNDataPoint_ST_CLA', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_ST_CLA', 'IT_LIST', dp_list1_ST));
        d2_st = NNDataset('DP_CLASS', 'NNDataPoint_ST_CLA', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_ST_CLA', 'IT_LIST', dp_list2_ST));
         % Create datasets for VOIs
        d1_vois = NNDataset('DP_CLASS', 'NNDataPoint_VOIs', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_VOIs', 'IT_LIST', dp_list1_voi));
        d2_vois = NNDataset('DP_CLASS', 'NNDataPoint_VOIs', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_VOIs', 'IT_LIST', dp_list2_voi));
               
        % Train MLP classifier without VOI input
        nncv = NNClassifierMLP_CrossValidation_VOIs('D', {d1_st, d2_st},'D_VOIS', {d1_vois, d2_vois}, 'KFOLDS', num_folds, 'NN_TEMPLATE', nn_template, 'SPLIT', SPLIT);
        nncv.get('TRAIN');
        % Evaluate performance
        confusion_matrix = nncv.get('C_MATRIX');
        auc = nncv.get('AV_MACRO_AUC');
        % Calculate sensitivity and specificity
        tp = confusion_matrix(2,2);
        tn = confusion_matrix(1,1);
        fp = confusion_matrix(1,2);
        fn = confusion_matrix(2,1);
        sensitivity = tp / (tp + fn);
        specificity = tn / (tn + fp);
        
        % Store results
        auc_scores(run) = auc;
        sensitivity_scores(run) = sensitivity;
        specificity_scores(run) = specificity;
        confusion_matrixs{run} = confusion_matrix;

    end

    results.(task_name).Confusion = {confusion_matrixs};
    results.(task_name).AUC = auc_scores(auc_scores~=0);
    results.(task_name).specificity = specificity_scores(specificity_scores~=0);
    results.(task_name).sensitivity = sensitivity_scores(sensitivity_scores~=0);
    
    % Plot performance metrics
    figure('Name', ['Performance Metrics with MultiplexWU for ' task_name], 'NumberTitle', 'off');
    sgtitle(['Performance Metrics with MultiplexWU for ' task_name], 'FontSize', 14);
    
    subplot(1, 3, 1);
    boxplot(auc_scores);
    title('AUC');
    xlabel('Runs');
    ylabel('Score');
    ylim([0 1]);
    grid on;
    
    subplot(1, 3, 2);
    boxplot(sensitivity_scores);
    title('Sensitivity');
    xlabel('Runs');
    ylabel('Score');
    ylim([0 1]);
    grid on;
    
    subplot(1, 3, 3);
    boxplot(specificity_scores);
    title('Specificity');
    xlabel('Runs');
    ylabel('Score');
    ylim([0 1]);
    grid on;
    
    set(gcf, 'Position', [100, 100, 800, 300]);
end

% save('/home/hang/GitHub/IndividualConnectome-WithYuwei/Results/FDG PET/matrix/withConverters/BaselineAsSUVRVector/Classification_SUVRVectorWithoutStandardizeAndSemipositiveBalanced(CNpos)WithVOI.mat', 'results');

