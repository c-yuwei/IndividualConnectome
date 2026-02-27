% EXAMPLE_CON_WU
% Script example pipeline Correlation CON WU
clear %#ok<*NASGU>
clear variables
addpath(genpath(fileparts(which('braph2individualconnectome'))))
%% load Atlas

im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [which('aal94_atlas.xlsx')], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');
%% load Nifty images
%%group1
im_gr1_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY',[fileparts(which('Example data Nifti diverse PDF/atlas.xlsx')) filesep 'Group1'], ...
    'NIFTI_TYPE', {'T1'},...
    'WAITBAR', true);
gr1_WM_GM = im_gr1_WM_GM.get('GR');

im_gr1_PET = ImporterGroupSubjNIfTI('DIRECTORY',[fileparts(which('Example data Nifti diverse PDF/atlas.xlsx')) filesep 'Group1'], ...
    'NIFTI_TYPE', {'PET'},...
    'WAITBAR', true);
gr1_PET = im_gr1_PET.get('GR');

%%group2
im_gr2_WM_GM = ImporterGroupSubjNIfTI('DIRECTORY',[fileparts(which('Example data Nifti diverse PDF/atlas.xlsx')) filesep 'Group2'], ...
    'NIFTI_TYPE', {'T1'},...
    'WAITBAR', true);
gr2_WM_GM = im_gr2_WM_GM.get('GR');

im_gr2_PET = ImporterGroupSubjNIfTI('DIRECTORY',[fileparts(which('Example data Nifti diverse PDF/atlas.xlsx')) filesep 'Group2'], ...
    'NIFTI_TYPE', {'PET'},...
    'WAITBAR', true);
gr2_PET = im_gr2_PET.get('GR');


%% PDF Construtor

path_dict = IndexedDictionary( ...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('upsampled_AAL2.nii'))} ...
    );

mapping_path_dict = IndexedDictionary( ...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('AAL2_Atlas_Labels.csv'))} ...
    );

ref_region_list = {2611}; % Reference region label

atlas = ba;
br_dict = atlas.get('BR_DICT');
selected_ids = num2cell(1:94);
selected_br = cellfun(@(id) br_dict.get('IT', id), selected_ids, 'UniformOutput', false);
selected_br_dict = IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST', selected_br);

gr1 = PDFConstructor('GR_PET', gr1_PET, ...
    'GR_T1', gr1_WM_GM, ...
    'BA', {ba}, ...
    'ATLAS_PATH_DICT', path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', ref_region_list, ...
    'PDF_REGION_SELECTION', selected_br_dict);
PDF_gr1 = gr1.get('GR');


gr2 = PDFConstructor('GR_PET', gr2_PET, ...
    'GR_T1', gr2_WM_GM, ...
    'BA', {ba}, ...
    'ATLAS_PATH_DICT', path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', ref_region_list, ...
    'PDF_REGION_SELECTION', selected_br_dict);
PDF_gr2 = gr2.get('GR');

gr1_suvr = SUVRConstructor('GR_PET', gr1_PET, ...
    'GR_T1', gr1_WM_GM, ...
    'BA', {ba}, ...
    'ATLAS_PATH_DICT', path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', ref_region_list, ...
    'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr1 = gr1_suvr.get('GR');

gr2_suvr = SUVRConstructor('GR_PET', gr2_PET, ...
    'GR_T1', gr2_WM_GM, ...
    'BA', {ba}, ...
    'ATLAS_PATH_DICT', path_dict, ...
    'MAPPING_PATH_DICT', mapping_path_dict, ...
    'REF_REGION_LIST', ref_region_list, ...
    'SUVR_REGION_SELECTION', selected_br_dict);
SUVR_gr2 = gr2_suvr.get('GR');


%% comparison on SUVR
% a_WU1_SUVR = AnalyzeGroup_ST_WU( ...
%     'GR', SUVR_gr1, ...
%     'CORRELATION_RULE', Correlation.PEARSON ...
%     );
% 
% a_WU2_SUVR = AnalyzeGroup_ST_WU( ...
%     'TEMPLATE', a_WU1_SUVR, ...
%     'GR', SUVR_gr2 ...
%     );
% c_WU_SUVR = CompareGroup( ...
%     'P', 100, ...
%     'A1', a_WU1_SUVR, ...
%     'A2', a_WU2_SUVR, ...
%     'WAITBAR', true, ...
%     'VERBOSE', false, ...
%     'MEMORIZE', true ...
%     );
% c_WU_SUVR.get('COMPARISON', 'Clustering').get('PFBG').set('FDR','on');
% 
% Clustering_WU_diff_SUVR = c_WU_SUVR.get('COMPARISON', 'Clustering').get('DIFF');
% Clustering_WU_p1_SUVR = c_WU_SUVR.get('COMPARISON', 'Clustering').get('P1');
% Clustering_WU_p2_SUVR = c_WU_SUVR.get('COMPARISON', 'Clustering').get('P2');
% Clustering_WU_cil_SUVR = c_WU_SUVR.get('COMPARISON', 'Clustering').get('CIL');
% Clustering_WU_ciu_SUVR = c_WU_SUVR.get('COMPARISON', 'Clustering').get('CIU');
% 
% GlobalEfficiency_av_WU_diff_SUVR = c_WU_SUVR.get('COMPARISON', 'GlobalEfficiency').get('DIFF');
% GlobalEfficiency_av_WU_p1_SUVR = c_WU_SUVR.get('COMPARISON', 'GlobalEfficiency').get('P1');
% GlobalEfficiency_av_WU_p2_SUVR = c_WU_SUVR.get('COMPARISON', 'GlobalEfficiency').get('P2');
% GlobalEfficiency_av_WU_cil_SUVR = c_WU_SUVR.get('COMPARISON', 'GlobalEfficiency').get('CIL');
% GlobalEfficiency_av_WU_ciu_SUVR = c_WU_SUVR.get('COMPARISON', 'GlobalEfficiency').get('CIU');
% 
% distance_WU_diff_SUVR = c_WU_SUVR.get('COMPARISON', 'Distance').get('DIFF');
% distance_WU_p1_SUVR = c_WU_SUVR.get('COMPARISON', 'Distance').get('P1');
% distance_WU_p2_SUVR = c_WU_SUVR.get('COMPARISON', 'Distance').get('P2');
% distance_WU_cil_SUVR = c_WU_SUVR.get('COMPARISON', 'Distance').get('CIL');
% distance_WU_ciu_SUVR = c_WU_SUVR.get('COMPARISON', 'Distance').get('CIU');
% % % 
% fun10 = PDF_gr1.get('SUB_DICT').get('IT',10).get('FUN');
% fun10_2 = PDF_gr2.get('SUB_DICT').get('IT',10).get('FUN');
% fun10_1 = PDF_gr1.get('SUB_DICT').get('IT',10).get('FUN');
% region25_fun10_2 = fun10_2(:,21);region25_fun10_1 = fun10_1(:,21);
% figure;
% plot(region25_fun10_2);
% hold on;
% plot(region25_fun10_1);legend('region 21 group 2','region 21 group 1');
% hold off

%% divergence
g_temp  = GraphWU('STANDARDIZE_RULE', 'range');
a_WU1_div = AnalyzeEnsembleDivergence_FUN_WU( ...
    'GR', PDF_gr1, ...
    'GRAPH_TEMPLATE', g_temp);
gr1_div = a_WU1_div.get('G_DICT');
a_WU2_div = AnalyzeEnsembleDivergence_FUN_WU( ...
    'GR', PDF_gr2, ...
    'GRAPH_TEMPLATE', g_temp);
gr2_div = a_WU2_div.get('G_DICT');


%% distance
im_gr1_dist = IndividualDistanceConConstructor('GR_SUVR', SUVR_gr1,'GR_SUVR_REF',SUVR_gr1);
Con_gr1_Distance = im_gr1_dist.get('GR');
im_gr2_dist = IndividualDistanceConConstructor('GR_SUVR', SUVR_gr2,'GR_SUVR_REF',SUVR_gr1);
Con_gr2_Distance = im_gr2_dist.get('GR');
a_WU1_dist = AnalyzeEnsemble_CON_WU('GR', Con_gr1_Distance); % Analyze Group 1 % Group 1 Analysis
a_WU2_dist = AnalyzeEnsemble_CON_WU('TEMPLATE', a_WU1_dist,'GR', Con_gr2_Distance); % Analyze Group 2 % Group 2 Analysis

%% correlation
g_temp  = GraphWU('STANDARDIZE_RULE', 'range');
a_WU1_correlation = AnalyzeEnsemble_FUN_WU( ...
    'GR', PDF_gr1, ...
    'REPETITION', 0, ...
    'GRAPH_TEMPLATE', g_temp...
    );
gr1_corr = a_WU1_correlation.get('G_DICT');

a_WU2_correlation = AnalyzeEnsemble_FUN_WU( ...
    'GR', PDF_gr2, ...
    'REPETITION', 0, ...
    'GRAPH_TEMPLATE', g_temp...
    );
gr2_corr = a_WU2_correlation.get('G_DICT');
%% perturbation
im_gr1_pert = IndividualPerturbationConConstructor('GR_SUVR', SUVR_gr1,'GR_SUVR_REF',SUVR_gr1);
Con_gr1_Perturbation = im_gr1_pert.get('GR');
im_gr2_pert = IndividualPerturbationConConstructor('GR_SUVR', SUVR_gr2,'GR_SUVR_REF',SUVR_gr1);
Con_gr2_Perturbation = im_gr2_pert.get('GR');
a_WU1_pert = AnalyzeEnsemble_CON_WU('GR', Con_gr1_Perturbation); % Analyze Group 1 % Group 1 Analysis
a_WU2_pert = AnalyzeEnsemble_CON_WU('TEMPLATE', a_WU1_pert,'GR', Con_gr2_Perturbation); % Analyze Group 2 % Group 2 Analysis


%% comparison
c_WU_corr = CompareEnsemble('P', 100, 'A1', a_WU1_correlation, 'A2', a_WU2_correlation, 'MEMORIZE', true); % Compare Groups % Group Comparison
c_WU_div = CompareEnsemble('P', 100, 'A1', a_WU1_div, 'A2', a_WU2_div); % Compare Groups % Group Comparison

c_WU_pert = CompareEnsemble('P', 100, 'A1', a_WU1_pert, 'A2', a_WU2_pert, 'MEMORIZE', true); % Compare Groups % Group Comparison
c_WU_dist = CompareEnsemble('P', 100, 'A1', a_WU1_dist, 'A2', a_WU2_dist, 'MEMORIZE', true); % Compare Groups % Group Comparison
%% 
measures = {'Strength', 'GlobalEfficiency', 'Clustering'};
warn_id = 'BRAPH2:ComparisonEnsembleBrainPF_NU';
warn_state = warning('query', warn_id);
warning('off', warn_id);

for m = 1:numel(measures)
    meas = measures{m};

    % --- get PFBs ---
    pfb_corr = c_WU_corr.get('COMPARISON', meas).get('PFB');

    % --- copy SPH_DICT from the reference comparison ---
    pfb_corr.set('SPH_DICT', pfb_corr.get('SPH_DICT'));

    % --- enable FDR ---
    pfb_corr.set('FDR', 'on');
    

end
warning(warn_state.state, warn_id);

%%


for m = 1:numel(measures)
    meas = measures{m};

    % --- get PFBs ---
    pfb_div = c_WU_div.get('COMPARISON', meas).get('PFB');

    % --- copy SPH_DICT from the reference comparison ---
    pfb_div.set('SPH_DICT', pfb_div.get('SPH_DICT'));

    % --- enable FDR ---
    pfb_div.set('FDR', 'on');

end
warning(warn_state.state, warn_id);


%% distance connectome



for m = 1:numel(measures)
    meas = measures{m};

    % --- get PFBs ---
    pfb_dist = c_WU_dist.get('COMPARISON', meas).get('PFB');

    % --- copy SPH_DICT from the reference comparison ---
    pfb_dist.set('SPH_DICT', pfb_dist.get('SPH_DICT'));

    % --- enable FDR ---
    pfb_dist.set('FDR', 'on');

end
warning(warn_state.state, warn_id);


%%
c_WU_div.get('COMPARISON', 'Clustering').get('PFB').get('DRAWN')
c_WU_div.get('COMPARISON', 'Clustering').get('PFB').get('DRAW')
c_WU_div.get('COMPARISON', 'Clustering').get('PFB').get('SHOW')

c_WU_dist.get('COMPARISON', 'Clustering').get('PFB').get('DRAWN')
c_WU_dist.get('COMPARISON', 'Clustering').get('PFB').get('DRAW')
c_WU_dist.get('COMPARISON', 'Clustering').get('PFB').get('SHOW')

