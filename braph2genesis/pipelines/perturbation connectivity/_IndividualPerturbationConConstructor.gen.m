%% ¡header!
IndividualPerturbationConConstructor < IndividualConConstructorBase (ipc, perturbation-based subject individual brain connectome Constructor) Construct perturbation-based brain connectome from subjects with SUVR data.

%%% ¡description!
IndividualPerturbationConConstructor constructs individual connectomes by perturbation using partial correlation with selected VOIs, adjusting for mean-centered age and education if selected.

%%% ¡seealso!
Group, SubjectST, ExporterGroupSubjectCON_XLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the perturbation-based connectome constructor.
%%%% ¡default!
'IndividualPerturbationConConstructor'

%%% ¡prop!
NAME (constant, string) is the name of the perturbation-based connectome constructor.
%%%% ¡default!
'Individual Perturbation Connectome Constructor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the perturbation-based connectome constructor.
%%%% ¡default!
'IndividualPerturbationConConstructor constructs individual connectomes using perturbation method with partial correlation using selected VOIs'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the perturbation-based connectome constructor.
%%%% ¡settings!
'IndividualPerturbationConConstructor'

%%% ¡prop!
ID (data, string) is a few-letter code for the perturbation-based connectome constructor.
%%%% ¡default!
'IndividualPerturbationConConstructor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the perturbation-based connectome constructor.
%%%% ¡default!
'IndividualPerturbationConConstructor label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the perturbation-based connectome constructor.
%%%% ¡default!
'IndividualPerturbationConConstructor notes'

%%% ¡prop!
CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for constructing individual connectomes using perturbation with partial correlation using selected VOIs.
%%%% ¡calculate!
if isempty(varargin) && isempty(ipc.get('GR_SUVR').get('SUB_DICT').get('IT_LIST'))
    value = {};
    return
end
gr_suvr = ipc.get('GR_SUVR');
gr_suvr_ref = ipc.get('GR_SUVR_REF');

% Get selected VOIs
selected_vois = ipc.get('VOI_SELECTION');

% Extract SUVR and selected VOI data for healthy reference group
N = gr_suvr_ref.get('SUB_DICT').get('LENGTH');
healthy_SUVR = [];
healthy_vois = [];
for i = 1:N
    sub = gr_suvr_ref.get('SUB_DICT').get('IT', i);
    suvr_i = sub.get('ST')';
    healthy_SUVR = [healthy_SUVR; suvr_i];
    
    voi_dict = sub.get('VOI_DICT');
    voi_values = [];
    for v = 1:length(selected_vois)
        voi = selected_vois{v};
        voi_value = voi_dict.get('IT', voi).get('V');
        voi_values = [voi_values, voi_value];
    end
    healthy_vois = [healthy_vois; voi_values];
end

% Mean-center selected VOIs for reference group (if any selected)
if ~isempty(selected_vois)
    mean_vois_ref = mean(healthy_vois);
    healthy_vois_centered = healthy_vois - mean_vois_ref;
else
    healthy_vois_centered = [];
end

% Compute reference correlation matrix R
if ~isempty(healthy_vois_centered)
    R = partialcorr(healthy_SUVR, healthy_vois_centered);
else
    R = corr(healthy_SUVR);
end

% Create diagonal mask
num_regions = size(healthy_SUVR, 2);
DiagMask = diag(ones(num_regions, 1));
R_adjusted = R - DiagMask;

% Compute normalization factor F
F = (1 - (R .^ 2)) / (N - 1);
F(F == 0) = eps; % Avoid division by zero

connectome_matrices = {};
for k = 1:gr_suvr.get('SUB_DICT').get('LENGTH')
    sub = gr_suvr.get('SUB_DICT').get('IT', k);
    suvr_k = sub.get('ST')';
    
    % Combine with healthy reference data
    perturbed_SUVR = [healthy_SUVR; suvr_k];
    
    % Extract selected VOIs for the perturbed subject
    voi_dict = sub.get('VOI_DICT');
    voi_values = [];
    for v = 1:length(selected_vois)
        voi = selected_vois{v};
        voi_value = voi_dict.get('IT', voi).get('V');
        voi_values = [voi_values, voi_value];
    end
    perturbed_vois = [healthy_vois; voi_values];
    
    % Mean-center perturbed VOIs relative to reference group
    if ~isempty(selected_vois)
        perturbed_vois_centered = perturbed_vois - mean_vois_ref;
    else
        perturbed_vois_centered = [];
    end
    
    % Compute perturbed correlation matrix P
    if ~isempty(perturbed_vois_centered)
        P = partialcorr(perturbed_SUVR, perturbed_vois_centered);
    else
        P = corr(perturbed_SUVR);
    end

    % Compute difference and normalize, then vectorize
    D = P - R;
    C = D ./ F;%* (N - 1); % element-wise division and scaling
    connectome_matrices{k} = C;
end
value = connectome_matrices;

%% ¡props!

%%% ¡prop!
VOI_SELECTION (parameter, stringlist) defines which VOIs should be included in the analysis.
%%%% ¡default!
{'Age', 'Sex', 'Education'}; % Example: Default selected VOIs

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example data
%%%% ¡code!
group_dir = fullfile(fileparts(which('create_example_NIfTI')),'Example data Nifti');
if ~exist(group_dir)
    create_example_NIfTI([],group_dir)
end

%%% ¡test!
%%%% ¡name!
Verify Perturbation-Based Connectome Constructor
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', which('aal94_atlas.xlsx'));
ba = im_ba.get('BA');
atlas = ba;
br_dict = atlas.get('BR_DICT');
selected_ids = num2cell(1:94);
selected_br = cellfun(@(id) br_dict.get('IT', id), selected_ids, 'UniformOutput', false);
selected_br_dict = IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_LIST',  selected_br);
group_dir = fullfile(fileparts(which('IndividualDeviationConConstructor')),'Example data Nifti', 'Group1');

im_gr1_WM_GM = ImporterGroupSubjNIfTI( ...
    'DIRECTORY', group_dir, ...
    'NIFTI_TYPE', {'T1'}, ...
    'WAITBAR', true ...
    );
gr1_WM_GM = im_gr1_WM_GM.get('GR');

im_gr1_PET = ImporterGroupSubjNIfTI( ...
    'DIRECTORY', group_dir, ...
    'NIFTI_TYPE', {'PET'}, ...
    'WAITBAR', true ...
    );
gr1_PET = im_gr1_PET.get('GR');

healthy_dir = fullfile(fileparts(which('IndividualDeviationConConstructor')),'Example data Nifti', 'Group2');
im_gr_ref_WM_GM = ImporterGroupSubjNIfTI( ...
    'DIRECTORY', healthy_dir, ...
    'NIFTI_TYPE', {'T1'}, ...
    'WAITBAR', true ...
    );
gr_ref_WM_GM = im_gr_ref_WM_GM.get('GR');

im_gr_ref_PET = ImporterGroupSubjNIfTI( ...
    'DIRECTORY', healthy_dir, ...
    'NIFTI_TYPE', {'PET'}, ...
    'WAITBAR', true ...
    );
gr_ref_PET = im_gr_ref_PET.get('GR');

path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('upsampled_AAL2.nii'))} ...
    );

ref_region_list = [2001]; % reference region label

gr = SUVRConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', {ba},...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{ref_region_list}, ...
    'SUVR_REGION_SELECTION', selected_br_dict);

gr_ref = SUVRConstructor('GR_PET',gr_ref_PET, ...
    'GR_T1',gr_ref_WM_GM, ...
    'BA', {ba},...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{ref_region_list}, ...
    'SUVR_REGION_SELECTION', selected_br_dict);

suvr_gr = gr.get('GR');
suvr_gr_ref = gr_ref.get('GR');

constructor = IndividualPerturbationConConstructor( ...
    'GR_SUVR', suvr_gr, ...
    'GR_SUVR_REF', suvr_gr_ref ...
    );

perturbation_connectomes = constructor.get('GR');

g_temp = GraphWU('STANDARDIZE_RULE', 'range');
a_WU1 = AnalyzeEnsemble_CON_WU('GR', perturbation_connectomes, 'GRAPH_TEMPLATE', g_temp);
num_subjects = a_WU1.get('G_DICT').get('LENGTH');

for i = 1:num_subjects
    g = a_WU1.get('G_DICT').get('IT', i);
    strength = g.get('MEASURE', 'Strength').get('M'); % Strength for all regions

    % Separate the first 20 regions and others
    strength_first20(i, :) = strength{1}(1:20);
    strength_others(i, :) = strength{1}(21:end);

    % Compute the mean strength for the two sets of regions for each subject
    mean_strength_first20 = mean(strength_first20(i, :));
    mean_strength_others = mean(strength_others(i, :));

    % Assert for each subject
    assert(mean_strength_first20 < mean_strength_others, ...
        sprintf('Test failed for subject %d: The first 20 regions do not have higher strength than the other regions.', i));
end