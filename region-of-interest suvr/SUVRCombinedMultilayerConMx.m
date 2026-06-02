%% Combined multilayer classification script integrating Perturbation, Correlation, Deviation, Distance, and Divergence methods
clear; clc;

% Add paths to necessary toolboxes
addpath(genpath('/home/hang/GitHub/IndividualConnectome-WithYuwei/braph2individualconnectome'));
addpath(genpath('/home/hang/GitHub/Individual-connectome/group_data/ADNI_DATA'));

% Load VOI Table for MetaROI Extraction (optional)
voi_table = readtable('/media/hang/EXTERNAL_US/Data/1_HANG_FDG_PET/demographic/UCBERKELEYFDG_8mm_02_17_23_19Jun2024.csv');
bl_meta_rows = voi_table(strcmp(voi_table.VISCODE2, 'bl') & strcmp(voi_table.ROINAME, 'MetaROI'), :);
rid_list = bl_meta_rows.RID;
mean_list = bl_meta_rows.MEAN;

% Function to extract RID from subject ID
extract_rid = @(id) str2double(extractAfter(id,'_S_'));

% Load group data for CN (gr1), MCI (gr2), AD (gr3), CN_pos (gr4)
im_gr1_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/Healthy_NegativeAmyloid.vois.xlsx')) filesep 'Healthy_NegativeAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'}, 'WAITBAR', true);
gr1_WM_GM = im_gr1_WM_GM.get('GR');
im_gr1_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/Healthy_NegativeAmyloid.vois.xlsx')) filesep 'Healthy_NegativeAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'}, 'WAITBAR', true);
gr1_PET = im_gr1_PET.get('GR');

im_gr2_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/MCI_PositiveAmyloid.vois.xlsx')) filesep 'MCI_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'}, 'WAITBAR', true);
gr2_WM_GM = im_gr2_WM_GM.get('GR');
im_gr2_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/MCI_PositiveAmyloid.vois.xlsx')) filesep 'MCI_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'}, 'WAITBAR', true);
gr2_PET = im_gr2_PET.get('GR');

im_gr3_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/AD_PositiveAmyloid.vois.xlsx')) filesep 'AD_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'}, 'WAITBAR', true);
gr3_WM_GM = im_gr3_WM_GM.get('GR');
im_gr3_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/AD_PositiveAmyloid.vois.xlsx')) filesep 'AD_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'}, 'WAITBAR', true);
gr3_PET = im_gr3_PET.get('GR');

im_gr4_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/Healthy_PositiveAmyloid.vois.xlsx')) filesep 'Healthy_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wc1','wc2'}, 'WAITBAR', true);
gr4_WM_GM = im_gr4_WM_GM.get('GR');
im_gr4_PET = ImporterGroupSubjNIfTI('DIRECTORY', [fileparts(which('Withconverters/Healthy_PositiveAmyloid.vois.xlsx')) filesep 'Healthy_PositiveAmyloid'], ...
    'NIFTI_TYPE', {'wroriented_raw_pet'}, 'WAITBAR', true);
gr4_PET = im_gr4_PET.get('GR');

%% Set up atlases and dictionaries
path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('upsampled_AAL2.nii')), FILE_PATH('PATH', which('upsampled_TD.nii'))} ...
);

mapping_path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('AAL2_Atlas_Labels_Abbre.csv')), FILE_PATH('PATH', which('TD_Atlas_Labels.csv'))} ...
);

% Import brain atlases
im_ba1 = ImporterBrainAtlasXLS('FILE', which('aal120_atlas.xlsx'), 'WAITBAR', true);
ba1 = im_ba1.get('BA');
im_ba2 = ImporterBrainAtlasXLS('FILE', which('TD_atlas.xlsx'), 'WAITBAR', true);
ba2 = im_ba2.get('BA');
ba_list = {ba1, ba2};
atlas = ba_list{1};
br_dict = atlas.get('BR_DICT');
selected_ids = num2cell(1:120);
selected_br = cellfun(@(id) br_dict.get('IT', id), selected_ids, 'UniformOutput', false);
selected_br_dict = IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', {selected_br{1:94}});

%% Compute SUVR and PDF for each group
% CN (gr1)
gr1_suvr = SUVRConstructor('GR_PET', gr1_PET, 'GR_T1', gr1_WM_GM, 'BA', ba_list, ...
    'ATLAS_PATH_DICT', path_dict, 'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', {[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, 'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr1 = gr1_suvr.get('GR');
gr1_pdf = PDFConstructor('GR_PET', gr1_PET, 'GR_T1', gr1_WM_GM, 'BA', ba_list, ...
    'ATLAS_PATH_DICT', path_dict, 'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', {[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, 'PDF_REGION_SELECTION', selected_br_dict);
pdf_gr1 = gr1_pdf.get('GR');

% MCI (gr2)
gr2_suvr = SUVRConstructor('GR_PET', gr2_PET, 'GR_T1', gr2_WM_GM, 'BA', ba_list, ...
    'ATLAS_PATH_DICT', path_dict, 'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', {[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, 'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr2 = gr2_suvr.get('GR');
gr2_pdf = PDFConstructor('GR_PET', gr2_PET, 'GR_T1', gr2_WM_GM, 'BA', ba_list, ...
    'ATLAS_PATH_DICT', path_dict, 'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', {[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, 'PDF_REGION_SELECTION', selected_br_dict);
pdf_gr2 = gr2_pdf.get('GR');

% AD (gr3)
gr3_suvr = SUVRConstructor('GR_PET', gr3_PET, 'GR_T1', gr3_WM_GM, 'BA', ba_list, ...
    'ATLAS_PATH_DICT', path_dict, 'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', {[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, 'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr3 = gr3_suvr.get('GR');
gr3_pdf = PDFConstructor('GR_PET', gr3_PET, 'GR_T1', gr3_WM_GM, 'BA', ba_list, ...
    'ATLAS_PATH_DICT', path_dict, 'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', {[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, 'PDF_REGION_SELECTION', selected_br_dict);
pdf_gr3 = gr3_pdf.get('GR');

% CN_pos (gr4)
gr4_suvr = SUVRConstructor('GR_PET', gr4_PET, 'GR_T1', gr4_WM_GM, 'BA', ba_list, ...
    'ATLAS_PATH_DICT', path_dict, 'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', {[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, 'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr4 = gr4_suvr.get('GR');
gr4_pdf = PDFConstructor('GR_PET', gr4_PET, 'GR_T1', gr4_WM_GM, 'BA', ba_list, ...
    'ATLAS_PATH_DICT', path_dict, 'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', {[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_INDEX', 1, 'PDF_REGION_SELECTION', selected_br_dict);
pdf_gr4 = gr4_pdf.get('GR');

%% Compute all five connectome types for each group
% Perturbation Connectomes
Con_gr1_pert = IndividualPerturbationConConstructor('GR_SUVR', SUVR_gr1, 'GR_SUVR_REF', SUVR_gr1).get('GR');
Con_gr2_pert = IndividualPerturbationConConstructor('GR_SUVR', SUVR_gr2, 'GR_SUVR_REF', SUVR_gr1).get('GR');
Con_gr3_pert = IndividualPerturbationConConstructor('GR_SUVR', SUVR_gr3, 'GR_SUVR_REF', SUVR_gr1).get('GR');
Con_gr4_pert = IndividualPerturbationConConstructor('GR_SUVR', SUVR_gr4, 'GR_SUVR_REF', SUVR_gr1).get('GR');

% Correlation Connectomes
g_temp = GraphWU('STANDARDIZE_RULE', 'range');
a_WU1_corr = AnalyzeEnsemble_FUN_WU('GR', pdf_gr1, 'REPETITION', 0, 'GRAPH_TEMPLATE', g_temp);
gr1_corr = a_WU1_corr.get('G_DICT');
a_WU2_corr = AnalyzeEnsemble_FUN_WU('GR', pdf_gr2, 'TEMPLATE', a_WU1_corr);
gr2_corr = a_WU2_corr.get('G_DICT');
a_WU3_corr = AnalyzeEnsemble_FUN_WU('GR', pdf_gr3, 'TEMPLATE', a_WU1_corr);
gr3_corr = a_WU3_corr.get('G_DICT');
a_WU4_corr = AnalyzeEnsemble_FUN_WU('GR', pdf_gr4, 'TEMPLATE', a_WU1_corr);
gr4_corr = a_WU4_corr.get('G_DICT');

% Distance Connectomes
im_gr1 = IndividualDistanceConConstructor('GR_SUVR', SUVR_gr1,'GR_SUVR_REF',SUVR_gr1);
Con_gr1_dist = im_gr1.get('GR');
im_gr2 = IndividualDistanceConConstructor('GR_SUVR', SUVR_gr2,'GR_SUVR_REF',SUVR_gr1);
Con_gr2_dist = im_gr2.get('GR');
im_gr3 = IndividualDistanceConConstructor('GR_SUVR', SUVR_gr3,'GR_SUVR_REF',SUVR_gr1);
Con_gr3_dist = im_gr3.get('GR');
im_gr4 = IndividualDistanceConConstructor('GR_SUVR', SUVR_gr4,'GR_SUVR_REF',SUVR_gr1);
Con_gr4_dist = im_gr4.get('GR');
% Divergence Connectomes
a_WU1_div = AnalyzeEnsembleDivergence_FUN_WU('GR', pdf_gr1);
gr1_div = a_WU1_div.get('G_DICT');
a_WU2_div = AnalyzeEnsembleDivergence_FUN_WU('GR', pdf_gr2, 'TEMPLATE', a_WU1_div);
gr2_div = a_WU2_div.get('G_DICT');
a_WU3_div = AnalyzeEnsembleDivergence_FUN_WU('GR', pdf_gr3, 'TEMPLATE', a_WU1_div);
gr3_div = a_WU3_div.get('G_DICT');
a_WU4_div = AnalyzeEnsembleDivergence_FUN_WU('GR', pdf_gr4, 'TEMPLATE', a_WU1_div);
gr4_div = a_WU4_div.get('G_DICT');

%% Create SubjectCON_MP with six-layer MultiplexWU for each group
% CN (gr1)
gr_CN = Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'));
sub_list_CN = SUVR_gr1.get('SUB_DICT').get('IT_LIST');
suvr_CN = cellfun(@(sub) sub.get('ST'), sub_list_CN, 'UniformOutput', false);
for i = 1:length(sub_list_CN)
    connectome_pert = Con_gr1_pert.get('SUB_DICT').get('IT', i).get('CON');
    subid = Con_gr1_pert.get('SUB_DICT').get('IT', i).get('ID');
    subid_a = ['g ',subid];
    A_corr = gr1_corr.get('IT', subid_a);
    connectome_corr = A_corr.get('A');
    connectome_dist = Con_gr1_dist.get('SUB_DICT').get('IT', subid).get('CON');
    A_div = gr1_div.get('IT', subid_a);
    connectome_div = A_div.get('A');
    suvr_vector = SUVR_gr1.get('SUB_DICT').get('IT', subid).get('ST');
    baseline_matrix = repmat(suvr_vector', size(connectome_pert,2),1);
    
    sub = SubjectCON_MP( ...
        'ID', sub_list_CN{i}.get('ID'), ...
        'LABEL', ['Subject ' sub_list_CN{i}.get('ID')], ...
        'NOTES', ['Notes on ' sub_list_CN{i}.get('ID')], ...
        'BA', sub_list_CN{i}.get('BA'), ...
        'L', 5, ...
        'LAYERLABELS', {'bl' 'Perturbation', 'Correlation', 'Distance', 'Divergence'}, ...
        'CON_MP', {baseline_matrix, connectome_pert, connectome_corr{1}, connectome_dist, connectome_div{1}});
    gr_CN.get('SUB_DICT').get('ADD', sub);
end
a_CN = AnalyzeEnsemble_CON_MP_WU('GR', gr_CN);

% MCI (gr2)
gr_MCI = Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'));
sub_list_MCI = SUVR_gr2.get('SUB_DICT').get('IT_LIST');
suvr_MCI = cellfun(@(sub) sub.get('ST'), sub_list_MCI, 'UniformOutput', false);
for i = 1:length(sub_list_MCI)
    connectome_pert = Con_gr2_pert.get('SUB_DICT').get('IT', i).get('CON');
    subid = Con_gr2_pert.get('SUB_DICT').get('IT', i).get('ID');
    subid_a = ['g ',subid];
    A_corr = gr2_corr.get('IT', subid_a);
    connectome_corr = A_corr.get('A');
    connectome_dist = Con_gr2_dist.get('SUB_DICT').get('IT', subid).get('CON');
    A_div = gr2_div.get('IT', subid_a);
    connectome_div = A_div.get('A');
    suvr_vector = SUVR_gr2.get('SUB_DICT').get('IT', subid).get('ST');
    baseline_matrix = repmat(suvr_vector', size(connectome_pert,2),1);
    
    sub = SubjectCON_MP( ...
        'ID', sub_list_MCI{i}.get('ID'), ...
        'LABEL', ['Subject ' sub_list_MCI{i}.get('ID')], ...
        'NOTES', ['Notes on ' sub_list_MCI{i}.get('ID')], ...
        'BA', sub_list_MCI{i}.get('BA'), ...
        'L', 5, ...
        'LAYERLABELS', {'bl' 'Perturbation', 'Correlation', 'Distance', 'Divergence'}, ...
        'CON_MP', {baseline_matrix, connectome_pert, connectome_corr{1}, connectome_dist, connectome_div{1}});
    gr_MCI.get('SUB_DICT').get('ADD', sub);
end
a_MCI = AnalyzeEnsemble_CON_MP_WU('GR', gr_MCI);

% AD (gr3)
gr_AD = Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'));
sub_list_AD = SUVR_gr3.get('SUB_DICT').get('IT_LIST');
suvr_AD = cellfun(@(sub) sub.get('ST'), sub_list_AD, 'UniformOutput', false);
for i = 1:length(sub_list_AD)
    connectome_pert = Con_gr3_pert.get('SUB_DICT').get('IT', i).get('CON');
    subid = Con_gr3_pert.get('SUB_DICT').get('IT', i).get('ID');
    subid_a = ['g ',subid];
    A_corr = gr3_corr.get('IT', subid_a);
    connectome_corr = A_corr.get('A');
    connectome_dist = Con_gr3_dist.get('SUB_DICT').get('IT', subid).get('CON');
    A_div = gr3_div.get('IT', subid_a);
    connectome_div = A_div.get('A');
    suvr_vector = SUVR_gr3.get('SUB_DICT').get('IT', subid).get('ST');
    baseline_matrix = repmat(suvr_vector', size(connectome_pert,2),1);
    
    sub = SubjectCON_MP( ...
        'ID', sub_list_AD{i}.get('ID'), ...
        'LABEL', ['Subject ' sub_list_AD{i}.get('ID')], ...
        'NOTES', ['Notes on ' sub_list_AD{i}.get('ID')], ...
        'BA', sub_list_AD{i}.get('BA'), ...
        'L', 5, ...
        'LAYERLABELS', {'bl' 'Perturbation', 'Correlation', 'Distance', 'Divergence'}, ...
        'CON_MP', {baseline_matrix, connectome_pert, connectome_corr{1}, connectome_dist, connectome_div{1}});
    gr_AD.get('SUB_DICT').get('ADD', sub);
end
a_AD = AnalyzeEnsemble_CON_MP_WU('GR', gr_AD);

% CN_pos (gr4)
gr_CNpos = Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'));
sub_list_CNpos = SUVR_gr4.get('SUB_DICT').get('IT_LIST');
suvr_CNpos = cellfun(@(sub) sub.get('ST'), sub_list_CNpos, 'UniformOutput', false);
for i = 1:length(sub_list_CNpos)
    connectome_pert = Con_gr4_pert.get('SUB_DICT').get('IT', i).get('CON');
    subid = Con_gr4_pert.get('SUB_DICT').get('IT', i).get('ID');
    subid_a = ['g ',subid];
    A_corr = gr4_corr.get('IT', subid_a);
    connectome_corr = A_corr.get('A');
    connectome_dist = Con_gr4_dist.get('SUB_DICT').get('IT', subid).get('CON');
    A_div = gr4_div.get('IT', subid_a);
    connectome_div = A_div.get('A');
    suvr_vector = SUVR_gr4.get('SUB_DICT').get('IT', subid).get('ST');
    baseline_matrix = repmat(suvr_vector', size(connectome_pert,2),1);
    
    sub = SubjectCON_MP( ...
        'ID', sub_list_CNpos{i}.get('ID'), ...
        'LABEL', ['Subject ' sub_list_CNpos{i}.get('ID')], ...
        'NOTES', ['Notes on ' sub_list_CNpos{i}.get('ID')], ...
        'BA', sub_list_CNpos{i}.get('BA'), ...
        'L', 5, ...
        'LAYERLABELS', {'bl' 'Perturbation', 'Correlation', 'Distance', 'Divergence'}, ...
        'CON_MP', {baseline_matrix, connectome_pert, connectome_corr{1}, connectome_dist, connectome_div{1}});
    gr_CNpos.get('SUB_DICT').get('ADD', sub);
end
a_CNpos = AnalyzeEnsemble_CON_MP_WU('GR', gr_CNpos);

%% Classification setup
num_runs = 100;
num_folds = 5;
tasks = {'CN_pos_vs_MCI', 'CN_pos_vs_AD'};
group_list = {
    'CN', a_CN.get('G_DICT').get('IT_LIST'), gr1_WM_GM.get('SUB_DICT').get('IT_LIST');
    'MCI', a_MCI.get('G_DICT').get('IT_LIST'), gr2_WM_GM.get('SUB_DICT').get('IT_LIST');
    'AD', a_AD.get('G_DICT').get('IT_LIST'), gr3_WM_GM.get('SUB_DICT').get('IT_LIST');
    'CN_pos', a_CNpos.get('G_DICT').get('IT_LIST'), gr4_WM_GM.get('SUB_DICT').get('IT_LIST')
};
nn_template = NNClassifierMLP_VOIs('EPOCHS', 50, 'LAYERS', [128 128]);
results = struct();

%% Perform classification
for h = 1:length(tasks)
    task_name = tasks{h};
    groups = strsplit(task_name, '_vs_');
    group_A_name = groups{1};
    group_B_name = groups{2};
    
    idx_A = find(strcmp({group_list{:,1}}, group_A_name));
    idx_B = find(strcmp({group_list{:,1}}, group_B_name));
    
    sub_list_A = group_list{idx_A, 2};
    sub_list_A_voi = group_list{idx_A, 3};
    sub_list_B = group_list{idx_B, 2};
    sub_list_B_voi = group_list{idx_B, 3};
    
    auc_scores = zeros(num_runs, 1);
    sensitivity_scores = zeros(num_runs, 1);
    specificity_scores = zeros(num_runs, 1);
    confusion_matrixs = cell(num_runs, 1);
    
    parfor run = 1:num_runs
        rng(run);
        num_A = length(sub_list_A);
        num_B = length(sub_list_B);
        min_group_size = min(num_A, num_B);
        
        idx_A_bal = randperm(num_A, min_group_size);
        idx_B_bal = randperm(num_B, min_group_size);
        
        sub_list_A_bal = sub_list_A(idx_A_bal);
        sub_list_A_bal_voi = sub_list_A_voi(idx_A_bal);
        sub_list_B_bal = sub_list_B(idx_B_bal);
        sub_list_B_bal_voi = sub_list_B_voi(idx_B_bal);
        
        dp_list1_con = cellfun(@(sub) NNDataPoint_Graph_CLA('ID', sub.get('ID'), ...
            'G', sub, 'TARGET_CLASS', {'negative'}), sub_list_A_bal, 'UniformOutput', false);
        dp_list2_con = cellfun(@(sub) NNDataPoint_Graph_CLA('ID', sub.get('ID'), ...
            'G', sub, 'TARGET_CLASS', {'positive'}), sub_list_B_bal, 'UniformOutput', false);
        
        dp_list1_voi = cellfun(@(sub) NNDataPoint_VOIs('ID', sub.get('ID'), ...
            'VOI_DICT', IndexedDictionary('ID', 'subject_voidict', 'IT_CLASS', 'SubjectNIfTI', ...
            'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
            'IT_LIST', sub.get('VOI_DICT').get('IT_LIST')), 'TARGET_CLASS', {'negative'}), ...
            sub_list_A_bal_voi, 'UniformOutput', false);
        dp_list2_voi = cellfun(@(sub) NNDataPoint_VOIs('ID', sub.get('ID'), ...
            'VOI_DICT', IndexedDictionary('ID', 'subject_voidict', 'IT_CLASS', 'SubjectNIfTI', ...
            'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
            'IT_LIST', sub.get('VOI_DICT').get('IT_LIST')), 'TARGET_CLASS', {'positive'}), ...
            sub_list_B_bal_voi, 'UniformOutput', false);
        
        split_indices_d1 = randperm(min_group_size);
        split_indices_d2 = randperm(min_group_size);
        split_points_d1 = round(linspace(0, min_group_size, num_folds + 1));
        split_points_d2 = round(linspace(0, min_group_size, num_folds + 1));
        SPLIT = cell(2, num_folds);
        for i = 1:num_folds
            SPLIT{1, i} = split_indices_d1(split_points_d1(i)+1:split_points_d1(i+1));
            SPLIT{2, i} = split_indices_d2(split_points_d2(i)+1:split_points_d2(i+1));
        end
        
        d1_con = NNDataset('DP_CLASS', 'NNDataPoint_Graph_CLA', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_Graph_CLA', 'IT_LIST', dp_list1_con));
        d2_con = NNDataset('DP_CLASS', 'NNDataPoint_Graph_CLA', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_Graph_CLA', 'IT_LIST', dp_list2_con));
        d1_voi = NNDataset('DP_CLASS', 'NNDataPoint_VOIs', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_VOIs', 'IT_LIST', dp_list1_voi));
        d2_voi = NNDataset('DP_CLASS', 'NNDataPoint_VOIs', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint_VOIs', 'IT_LIST', dp_list2_voi));
        
        nncv = NNClassifierMLP_CrossValidation_VOIs('D', {d1_con, d2_con}, 'D_VOIS', {d1_voi, d2_voi}, ...
            'KFOLDS', num_folds, 'NN_TEMPLATE', nn_template, 'SPLIT', SPLIT);
        nncv.get('TRAIN');

        
        confusion_matrix = nncv.get('C_MATRIX');
        auc = nncv.get('AV_MACRO_AUC');
        tp = confusion_matrix(2,2);
        tn = confusion_matrix(1,1);
        fp = confusion_matrix(1,2);
        fn = confusion_matrix(2,1);
        sensitivity = tp / (tp + fn);
        specificity = tn / (tn + fp);
        
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
    figure('Name', ['Performance Metrics with Combined MultiplexWU for ' task_name], 'NumberTitle', 'off');
    sgtitle(['Performance Metrics with Combined MultiplexWU for ' task_name], 'FontSize', 14);
    
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

%% Save results
save('Results/classification_CombinedMultilayerConMx_SUVR_BalancedNewDistance.mat', 'results');

