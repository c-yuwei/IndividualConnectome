%EXAMPLE_CON_WU
% Script example pipeline CON WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [which('aal94_atlas.xlsx')], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');



%% load Nifty images
im_gr1_WM_GM = ImporterGroupSubjNifti('DIRECTORY', ['/home/hang/GitHub/Individual-connectome/group_data/test/test'], ...
    'NIFTI_TYPE', {'WM','GM'},...
    'WAITBAR', true);
gr1_WM_GM = im_gr1_WM_GM.get('GR');

im_gr1_PET = ImporterGroupSubjNifti('DIRECTORY', ['/home/hang/GitHub/Individual-connectome/group_data/test/test'], ...
    'NIFTI_TYPE', {'PET'},...
    'WAITBAR', true);
gr1_PET = im_gr1_PET.get('GR');
%% load Nifty images from healthy 
im_gr1_WM_GM_healthy = ImporterGroupSubjNifti('DIRECTORY', ['/home/hang/GitHub/Individual-connectome/group_data/Healthy/Healthy'], ...
    'NIFTI_TYPE', {'WM','GM'},...
    'WAITBAR', true);
gr1_WM_GM_healthy = im_gr1_WM_GM_healthy.get('GR');

im_gr1_PET_healthy = ImporterGroupSubjNifti('DIRECTORY', ['/home/hang/GitHub/Individual-connectome/group_data/Healthy/Healthy'], ...
    'NIFTI_TYPE', {'PET'},...
    'WAITBAR', true);
gr1_PET_healthy = im_gr1_PET_healthy.get('GR');
%% ROI constructor
path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', '/home/hang/GitHub/Individual-connectome/group_data/test/atlas/AAL2_registered.nii'),FILE_PATH('PATH', '/home/hang/GitHub/Individual-connectome/group_data/test/atlas/TD_lobe_registered.nii')} ...
    );

suvr_brain_label = readtable('group_data/test/atlas/AAL2_Atlas_Labels.csv');
suvr_brain_label = suvr_brain_label.Var4;
gr = SUVRConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_KIND', {'AAL2','TD'},...
    'SUVR_REGION_SELECTION',suvr_brain_label);
Con_gr = gr.get('GR');
%% healthy suvr
gr_healthy = SUVRConstructor('GR_PET',gr1_PET_healthy, ...
    'GR_T1',gr1_WM_GM_healthy, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_KIND', {'AAL2','TD'},...
    'SUVR_REGION_SELECTION',suvr_brain_label);
Con_gr_healthy = gr_healthy.get('GR');



%% Load Groups of SubjectCON Distance based
im_gr1 = IndividualDistanceConConsturctor( ...
    'GR_SUVR', Con_gr );

gr1 = im_gr1.get('GR');


%% Load Groups of SubjectCON Deviation based
im_gr1 = IndividualDeviationConConstructor( ...
    'GR_SUVR', Con_gr,...
    'GR_SUVR_REF', Con_gr_healthy);

gr1 = im_gr1.get('GR');

%% PDF Construtor
path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', '/home/hang/GitHub/Individual-connectome/group_data/test/atlas/AAL2_registered.nii'),FILE_PATH('PATH', '/home/hang/GitHub/Individual-connectome/group_data/test/atlas/TD_lobe_registered.nii')} ...
    );
suvr_brain_label = readtable('group_data/test/atlas/AAL2_Atlas_Labels.csv');
suvr_brain_label = suvr_brain_label.Var4;
im_gr_pdf = PDFConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{[9100,9110,9120,9130,9140,9150,9160,9170], 7}, ...
    'ATLAS_KIND', {'AAL2','TD'},...
    'SUVR_REGION_SELECTION',suvr_brain_label);
gr1 = im_gr_pdf.get('GR');

%% Load Groups of SubjectCON Divergence based
im_gr1_dev = IndividualDivergenceConConstructor( ...
    'GR_SUVR', gr1 );

gr1_dev = im_gr1_dev.get('GR');

%% Load Groups of SubjectCON Correlation based
im_gr1_corr = IndividualCorrelationConConstructor( ...
    'GR_SUVR', gr1 );

gr1_corr = im_gr1_dev.get('GR');
%% Analysis CON WU
a_WU1 = AnalyzeEnsemble_CON_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_CON_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );

%% measure calculation
% % % strength_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Strength').get('M');
% % % strength_av_WU1 = a_WU1.get('MEASUREENSEMBLE', 'StrengthAv').get('M');
degree_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Degree').get('M');
distance_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Distance').get('M');
Clustering_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Clustering').get('M');
% % % strength_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Strength').get('M');
% % % strength_av_WU2 = a_WU2.get('MEASUREENSEMBLE', 'StrengthAv').get('M');
degree_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Degree').get('M');
distance_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Distance').get('M');
Clustering_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Clustering').get('M');
% comparison
c_WU = CompareEnsemble( ...
    'P', 10, ...
    'A1', a_WU1, ...
    'A2', a_WU2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );


degree_WU_diff = c_WU.get('COMPARISON', 'Degree').get('DIFF');
degree_WU_p1 = c_WU.get('COMPARISON', 'Degree').get('P1');
degree_WU_p2 = c_WU.get('COMPARISON', 'Degree').get('P2');
degree_WU_cil = c_WU.get('COMPARISON', 'Degree').get('CIL');
degree_WU_ciu = c_WU.get('COMPARISON', 'Degree').get('CIU');

Clustering_WU_diff = c_WU.get('COMPARISON', 'Clustering').get('DIFF');
Clustering_WU_p1 = c_WU.get('COMPARISON', 'Clustering').get('P1');
Clustering_WU_p2 = c_WU.get('COMPARISON', 'Clustering').get('P2');
Clustering_WU_cil = c_WU.get('COMPARISON', 'Clustering').get('CIL');
Clustering_WU_ciu = c_WU.get('COMPARISON', 'Clustering').get('CIU');

distance_WU_diff = c_WU.get('COMPARISON', 'Distance').get('DIFF');
distance_WU_p1 = c_WU.get('COMPARISON', 'Distance').get('P1');
distance_WU_p2 = c_WU.get('COMPARISON', 'Distance').get('P2');
distance_WU_cil = c_WU.get('COMPARISON', 'Distance').get('CIL');
distance_WU_ciu = c_WU.get('COMPARISON', 'Distance').get('CIU');
