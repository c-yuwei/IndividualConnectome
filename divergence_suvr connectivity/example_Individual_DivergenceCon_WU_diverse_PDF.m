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
%% SUVR
a_WU1_SUVR = AnalyzeGroup_ST_WU( ...
    'GR', SUVR_gr1, ...
    'CORRELATION_RULE', Correlation.PEARSON ...
    );

a_WU2_SUVR = AnalyzeGroup_ST_WU( ...
    'TEMPLATE', a_WU1_SUVR, ...
    'GR', SUVR_gr2 ...
    );
c_WU_SUVR = CompareGroup( ...
    'P', 100, ...
    'A1', a_WU1_SUVR, ...
    'A2', a_WU2_SUVR, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );
warn_id = 'BRAPH2:ComparisonEnsembleBrainPF_NU';
warn_state = warning('query', warn_id);
warning('off', warn_id);

for m = 1:numel(measures)
    meas = measures{m};

    % --- get PFBs ---
    pfb_SUVR = c_WU_SUVR.get('COMPARISON', meas).get('PFBG');

    % --- copy SPH_DICT from the reference comparison ---
    pfb_SUVR.set('SPH_DICT', pfb_SUVR.get('SPH_DICT'));

    % --- enable FDR ---
    pfb_SUVR.set('FDR', 'on');

end
warning(warn_state.state, warn_id);

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
% im_gr1_pert = IndividualPerturbationConConstructor('GR_SUVR', SUVR_gr1,'GR_SUVR_REF',SUVR_gr1);
% Con_gr1_Perturbation = im_gr1_pert.get('GR');
% im_gr2_pert = IndividualPerturbationConConstructor('GR_SUVR', SUVR_gr2,'GR_SUVR_REF',SUVR_gr1);
% Con_gr2_Perturbation = im_gr2_pert.get('GR');
% a_WU1_pert = AnalyzeEnsemble_CON_WU('GR', Con_gr1_Perturbation); % Analyze Group 1 % Group 1 Analysis
% a_WU2_pert = AnalyzeEnsemble_CON_WU('TEMPLATE', a_WU1_pert,'GR', Con_gr2_Perturbation); % Analyze Group 2 % Group 2 Analysis

% --- build perturbation groups (as you already do) ---
im_gr1_pert = IndividualPerturbationConConstructor('GR_SUVR', SUVR_gr1, 'GR_SUVR_REF', SUVR_gr1);
Con_gr1_Perturbation = im_gr1_pert.get('GR');

im_gr2_pert = IndividualPerturbationConConstructor('GR_SUVR', SUVR_gr2, 'GR_SUVR_REF', SUVR_gr1);
Con_gr2_Perturbation = im_gr2_pert.get('GR');

% ========= MINIMAL ADDITION: set negative weights to 0 =========
Con_gr1_Perturbation = clamp_group_con_neg_to_zero(Con_gr1_Perturbation);
Con_gr2_Perturbation = clamp_group_con_neg_to_zero(Con_gr2_Perturbation);

% --- then analyse as usual ---
a_WU1_pert = AnalyzeEnsemble_CON_WU('GR', Con_gr1_Perturbation);
a_WU2_pert = AnalyzeEnsemble_CON_WU('TEMPLATE', a_WU1_pert, 'GR', Con_gr2_Perturbation);


%% comparison
c_WU_corr = CompareEnsemble('P', 100, 'A1', a_WU1_correlation, 'A2', a_WU2_correlation, 'MEMORIZE', true); % Compare Groups % Group Comparison
c_WU_div = CompareEnsemble('P', 100, 'A1', a_WU1_div, 'A2', a_WU2_div); % Compare Groups % Group Comparison

c_WU_pert = CompareEnsemble('P', 100, 'A1', a_WU1_pert, 'A2', a_WU2_pert, 'MEMORIZE', true); % Compare Groups % Group Comparison
c_WU_dist = CompareEnsemble('P', 100, 'A1', a_WU1_dist, 'A2', a_WU2_dist, 'MEMORIZE', true); % Compare Groups % Group Comparison
%% correlation
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

%% divergence


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

%% perturbation connectome

for m = 1:numel(measures)
    meas = measures{m};

    % --- get PFBs ---
    pfb_pert = c_WU_pert.get('COMPARISON', meas).get('PFB');

    % --- copy SPH_DICT from the reference comparison ---
    pfb_pert.set('SPH_DICT', pfb_pert.get('SPH_DICT'));

    % --- enable FDR ---
    pfb_pert.set('FDR', 'on');

end
warning(warn_state.state, warn_id);
%% suvr
c_WU_SUVR.get('COMPARISON', 'Clustering').get('PFBG').get('DRAWN')
c_WU_SUVR.get('COMPARISON', 'Clustering').get('PFBG').get('DRAW')
c_WU_SUVR.get('COMPARISON', 'Clustering').get('PFBG').get('SHOW')

c_WU_SUVR.get('COMPARISON', 'GlobalEfficiency').get('PFBG').get('DRAWN')
c_WU_SUVR.get('COMPARISON', 'GlobalEfficiency').get('PFBG').get('DRAW')
c_WU_SUVR.get('COMPARISON', 'GlobalEfficiency').get('PFBG').get('SHOW')

c_WU_SUVR.get('COMPARISON', 'Strength').get('PFBG').get('DRAWN')
c_WU_SUVR.get('COMPARISON', 'Strength').get('PFBG').get('DRAW')
c_WU_SUVR.get('COMPARISON', 'Strength').get('PFBG').get('SHOW')

%% clustering
c_WU_div.get('COMPARISON', 'Clustering').get('PFB').get('DRAWN')
c_WU_div.get('COMPARISON', 'Clustering').get('PFB').get('DRAW')
c_WU_div.get('COMPARISON', 'Clustering').get('PFB').get('SHOW')

c_WU_dist.get('COMPARISON', 'Clustering').get('PFB').get('DRAWN')
c_WU_dist.get('COMPARISON', 'Clustering').get('PFB').get('DRAW')
c_WU_dist.get('COMPARISON', 'Clustering').get('PFB').get('SHOW')

c_WU_corr.get('COMPARISON', 'Clustering').get('PFB').get('DRAWN')
c_WU_corr.get('COMPARISON', 'Clustering').get('PFB').get('DRAW')
c_WU_corr.get('COMPARISON', 'Clustering').get('PFB').get('SHOW')

c_WU_pert.get('COMPARISON', 'Clustering').get('PFB').get('DRAWN')
c_WU_pert.get('COMPARISON', 'Clustering').get('PFB').get('DRAW')
c_WU_pert.get('COMPARISON', 'Clustering').get('PFB').get('SHOW')
%% GlobalEfficiancy
c_WU_div.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('DRAWN')
c_WU_div.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('DRAW')
c_WU_div.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('SHOW')

c_WU_dist.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('DRAWN')
c_WU_dist.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('DRAW')
c_WU_dist.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('SHOW')

c_WU_corr.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('DRAWN')
c_WU_corr.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('DRAW')
c_WU_corr.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('SHOW')

c_WU_pert.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('DRAWN')
c_WU_pert.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('DRAW')
c_WU_pert.get('COMPARISON', 'GlobalEfficiency').get('PFB').get('SHOW')
%% Strength
c_WU_div.get('COMPARISON', 'Strength').get('PFB').get('DRAWN')
c_WU_div.get('COMPARISON', 'Strength').get('PFB').get('DRAW')
c_WU_div.get('COMPARISON', 'Strength').get('PFB').get('SHOW')

c_WU_dist.get('COMPARISON', 'Strength').get('PFB').get('DRAWN')
c_WU_dist.get('COMPARISON', 'Strength').get('PFB').get('DRAW')
c_WU_dist.get('COMPARISON', 'Strength').get('PFB').get('SHOW')

c_WU_corr.get('COMPARISON', 'Strength').get('PFB').get('DRAWN')
c_WU_corr.get('COMPARISON', 'Strength').get('PFB').get('DRAW')
c_WU_corr.get('COMPARISON', 'Strength').get('PFB').get('SHOW')

c_WU_pert.get('COMPARISON', 'Strength').get('PFB').get('DRAWN')
c_WU_pert.get('COMPARISON', 'Strength').get('PFB').get('DRAW')
c_WU_pert.get('COMPARISON', 'Strength').get('PFB').get('SHOW')


% ===== helper (put at end of the same .m file, or separate file on path) =====
function GR = clamp_group_con_neg_to_zero(GR)
    sub_dict = GR.get('SUB_DICT');
    nSub = sub_dict.get('LENGTH');

    for i = 1:nSub
        sub = sub_dict.get('IT', i);

        % Most BRAPH2 CON subjects store connectivity in property 'CON'
        con = sub.get('CON');

        % single-layer case: one matrix
        A = con;
        A(A < 0) = 0;
        A(1:size(A,1)+1:end) = 0;
        A = (A + A.')/2;
        con = A;

        sub.set('CON', con);
    end
end