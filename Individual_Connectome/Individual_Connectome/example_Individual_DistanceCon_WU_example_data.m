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
group_dir = fullfile(fileparts(which('IndividualDeviationConConstructor')),'Example data Nifti', 'Group1');
im_gr1_WM_GM = ImporterGroupSubjNifti( ...
    'DIRECTORY', group_dir, ...
    'NIFTI_TYPE', {'T1'}, ...
    'WAITBAR', true ...
    );
gr1_WM_GM = im_gr1_WM_GM.get('GR');

im_gr1_PET = ImporterGroupSubjNifti( ...
    'DIRECTORY', group_dir, ...
    'NIFTI_TYPE', {'PET'}, ...
    'WAITBAR', true ...
    );
gr1_PET = im_gr1_PET.get('GR');

%%group2
group_dir = fullfile(fileparts(which('IndividualDeviationConConstructor')),'Example data Nifti', 'Group2');
im_gr2_WM_GM = ImporterGroupSubjNifti( ...
    'DIRECTORY', group_dir, ...
    'NIFTI_TYPE', {'T1'}, ...
    'WAITBAR', true ...
    );
gr2_WM_GM = im_gr2_WM_GM.get('GR');

im_gr2_PET = ImporterGroupSubjNifti( ...
    'DIRECTORY', group_dir, ...
    'NIFTI_TYPE', {'PET'}, ...
    'WAITBAR', true ...
    );
gr2_PET = im_gr2_PET.get('GR');


%% ROI constructor
path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', '/home/hang/GitHub/Individual-connectome/group_data/test/atlas/upsampled_AAL2.nii'),FILE_PATH('PATH', '/home/hang/GitHub/Individual-connectome/group_data/test/atlas/upsampled_TD.nii')} ...
    );

suvr_brain_label = readtable('group_data/test/atlas/AAL2_Atlas_Labels.csv');
suvr_brain_label = suvr_brain_label.Var4;
gr1 = SUVRConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_KIND', {'AAL2','TD'},...
    'SUVR_REGION_SELECTION',suvr_brain_label);
SUVR_gr1 = gr1.get('GR');

gr2 = SUVRConstructor('GR_PET',gr2_PET, ...
    'GR_T1',gr2_WM_GM, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_KIND', {'AAL2','TD'},...
    'SUVR_REGION_SELECTION',suvr_brain_label);
SUVR_gr2 = gr2.get('GR');


%% Load Groups of SubjectCON Distance based
im_gr1 = IndividualDistanceConConsturctor( ...
    'GR_SUVR', Con_gr1 );

gr1 = im_gr1.get('GR');

im_gr2 = IndividualDistanceConConsturctor( ...
    'GR_SUVR', Con_gr2 );

gr2 = im_gr2.get('GR');

%%
% Create the IndexedDictionary for SUVR groups
SUVR_gr_dict = IndexedDictionary('IT_CLASS', 'Group', ...
                                  'IT_LIST', {SUVR_gr1, SUVR_gr2});

% Create the IndexedDictionary for VOIS groups
VOI_gr_dict = IndexedDictionary('IT_CLASS', 'Group', ...
                                 'IT_LIST', {gr1_WM_GM, gr2_WM_GM});




%% Analysis CON WU
a_WU1 = AnalyzeEnsemble_CON_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_CON_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );


a_WU1.memorize('G_DICT');
a_WU2.memorize('G_DICT');

%% NN CV classification on 2 classes

% create item lists of NNDataPoint_Graph_CLA
it_list1 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_CLASS', {gr1_PET.get('ID')}), ...
    a_WU1.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

it_list2 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_CLASS', {gr2_PET.get('ID')}), ...
    a_WU2.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);


% create NNDataPoint_Graph_CLA DICT items
it_class = 'NNDataPoint_Graph_CLA';
dp_list1 = IndexedDictionary(...
        'IT_CLASS', it_class, ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', it_class, ...
        'IT_LIST', it_list2 ...
        );


% create a NNDataset containing the NNDataPoint_Graph_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', it_class, ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', it_class, ...
    'DP_DICT', dp_list2 ...
    );

%% Create a classifier cross-validation
nncv = NNClassifierMLP_CrossValidation('D', {d1, d2}, 'KFOLDS', 2);
nncv.get('TRAIN');
%% Evaluate the performance
confusion_matrix = nncv.get('C_MATRIX');
av_auc = nncv.get('AV_AUC');
av_macro_auc = nncv.get('AV_MACRO_AUC');
