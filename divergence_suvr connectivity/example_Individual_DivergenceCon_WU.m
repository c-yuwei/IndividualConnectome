% EXAMPLE_CON_WU
% Script example pipeline Divergence CON WU

clear variables %#ok<*NASGU>
addpath(genpath('/home/hang/GitHub/Individual-connectome/group_data/ADNI_DATA'));
addpath(genpath('/home/hang/GitHub/IndividualConnectome-WithYuwei/braph2individualconnectome'));
%% Load BrainAtlas
% im_ba = ImporterBrainAtlasXLS( ...
%     'FILE', [which('aal94_atlas.xlsx')], ...
%     'WAITBAR', true ...
%     );
% 
% ba = im_ba.get('BA');

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
%% PDF Construtor
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
gr1 = PDFConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'ATLAS_KIND', {'AAL2','TD'}, ...
    'PDF_REGION_SELECTION', selected_br_dict);
pdf_gr1 = gr1.get('GR');

gr2 = PDFConstructor('GR_PET',gr2_PET, ...
    'GR_T1',gr2_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'ATLAS_KIND', {'AAL2','TD'}, ...
    'PDF_REGION_SELECTION', selected_br_dict);
pdf_gr2 = gr2.get('GR');

gr3 = PDFConstructor('GR_PET',gr3_PET, ...
    'GR_T1',gr3_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'ATLAS_KIND', {'AAL2','TD'}, ...
    'PDF_REGION_SELECTION', selected_br_dict);
pdf_gr3 = gr3.get('GR');


gr4 = PDFConstructor('GR_PET',gr4_PET, ...
    'GR_T1',gr4_WM_GM, ...
    'BA', ba_list,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, ...
    'ATLAS_KIND', {'AAL2','TD'}, ...
    'PDF_REGION_SELECTION', selected_br_dict);
pdf_gr4 = gr4.get('GR');


%% Load Groups of SubjectCON divergence based
g_temp  = GraphWU('STANDARDIZE_RULE', 'range');
a_WU1 = AnalyzeEnsembleDivergence_FUN_WU( ...
    'GR', pdf_gr1);

a_WU2 = AnalyzeEnsembleDivergence_FUN_WU( ...
    'GR', pdf_gr2, ...
    'TEMPLATE', a_WU1);
a_WU3 = AnalyzeEnsembleDivergence_FUN_WU( ...
    'GR', pdf_gr3, ...
    'TEMPLATE', a_WU1);
a_WU4 = AnalyzeEnsembleDivergence_FUN_WU( ...
    'GR', pdf_gr4, ...
    'TEMPLATE', a_WU1);
a_WU1.memorize('G_DICT');
a_WU2.memorize('G_DICT');
a_WU3.memorize('G_DICT');
a_WU4.memorize('G_DICT');
% gr1_divergence = a_WU1.get('G_DICT');
% gr2_divergence = a_WU2.get('G_DICT');
% gr3_divergence = a_WU3.get('G_DICT');

%%
% ǵroup 1
[~, group_folder_name1] = fileparts(im_gr1_PET.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_CLASS', {group_folder_name1}), ...
     a_WU1.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% Get the subject dictionary and extract the list of subjects
sub_dict1 = gr1_WM_GM.get('SUB_DICT');
sub_list1 = sub_dict1.get('IT_LIST'); % Get all subjects as a cell array

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

% ǵroup 2
[~, group_folder_name2] = fileparts(im_gr2_PET.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_CLASS', {group_folder_name2}), ...
     a_WU2.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% Get the subject dictionary and extract the list of subjects
sub_dict2 = gr2_WM_GM.get('SUB_DICT');
sub_list2 = sub_dict2.get('IT_LIST'); % Get all subjects as a cell array

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

% ǵroup 3
[~, group_folder_name3] = fileparts(im_gr3_PET.get('DIRECTORY'));
it_list3 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_CLASS', {group_folder_name3}), ...
     a_WU3.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);
% Get the subject dictionary and extract the list of subjects
sub_dict3 = gr3_WM_GM.get('SUB_DICT');
sub_list3 = sub_dict3.get('IT_LIST'); % Get all subjects as a cell array

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


% ǵroup 4
[~, group_folder_name4] = fileparts(im_gr4_PET.get('DIRECTORY'));
it_list4 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_CLASS', {group_folder_name4}), ...
     a_WU4.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);
% Get the subject dictionary and extract the list of subjects
sub_dict4 = gr4_WM_GM.get('SUB_DICT');
sub_list4 = sub_dict4.get('IT_LIST'); % Get all subjects as a cell array

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

dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Graph_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Graph_CLA', ...
        'IT_LIST', it_list2 ...
        );

dp_list3 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Graph_CLA', ...
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



%% Balanced Classification

% Define neural network template
nn_template = NNClassifierMLP_VOIs('EPOCHS', 50, 'LAYERS', [128 128]);

% Define tasks and corresponding group pairs
tasks = {'CN_vs_MCI', 'CN_vs_AD', 'CN_vs_CN_POS'};
group_pairs = {{d1, d2}, {d1, d3}, {d1, d4}};
dp_lists = {{dp_list1, dp_list2}, {dp_list1, dp_list3}, {dp_list1, dp_list4}};
dp_list_vois = {{dp_list_voi1, dp_list_voi2}, {dp_list_voi1, dp_list_voi3}, {dp_list_voi1, dp_list_voi4}};
% tasks  = {'CN_vs_AD'};
% group_pairs = { {d1, d3}};
% dp_lists = {{dp_list1, dp_list3}};
% dp_list_vois = {{dp_list_voi1, dp_list_voi3}};

% Number of runs
num_runs = 100;
% Initialize results structure
results = struct();

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

    x_mean = {};
    y_mean = {};
    cm_scores = {};
    sensitivity_scores = [];
    specificity_scores = [];
    auc_scores = [];
    % Get group sizes
    num_dp1 = group1.get('DP_DICT').get('LENGTH');
    num_dp2 = group2.get('DP_DICT').get('LENGTH');
    if num_dp1 == 0 || num_dp2 == 0
        error([task_name ' task failed: One of the groups has no subjects.']);
    end
    min_size = min(num_dp1, num_dp2);
    
    % Parallel loop over runs
    parfor run = 1:num_runs
        rng(run); %Set random seed for reproducibility
        
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

save('Results/matrix/withConverters/classification_results_divergence_matrixClassification_Balanced.mat', 'results');

%% Generate Boxplots for CN vs. AD
figure('Name', 'Performance Metrics of divergence for CN vs. AD', 'NumberTitle', 'off');
sgtitle('Performance Metrics for of divergence CN vs. AD', 'FontSize', 14);

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
boxplot(results.CN_vs_AD.sensitivity);
title('Sensitivity');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

% Specificity Boxplot
subplot(1, 3, 3);
boxplot(results.CN_vs_AD.specificity);
title('Specificity');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;


%% Generate Boxplots for CN vs. MCI
figure('Name', 'Performance Metrics of divergence for CN vs. MCI', 'NumberTitle', 'off');
sgtitle('Performance Metrics of divergence for CN vs. MCI', 'FontSize', 14);

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

%% Generate Boxplots for CN vs. CN pos
figure('Name', 'Performance Metrics of divergence for CN vs. MCI', 'NumberTitle', 'off');
sgtitle('Performance Metrics of divergence for CN vs. MCI', 'FontSize', 14);

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
boxplot(results.CN_vs_CN_POS.sensitivity);
title('Sensitivity');
xlabel('Runs');
ylabel('Score');
ylim([0 1]);
grid on;

% Specificity Boxplot
subplot(1, 3, 3);
boxplot(results.CN_vs_CN_POS.specificity);
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
