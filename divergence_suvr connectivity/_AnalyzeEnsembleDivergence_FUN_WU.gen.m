%% ¡header!
AnalyzeEnsembleDivergence_FUN_WU < AnalyzeEnsemble (a, graph analysis with functional data) is an ensemble-based graph analysis using functional data.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_FUN_WU) analyzes functional data 
using weighted undirected graphs.

%%% ¡seealso!
SubjectFUN, GraphWU

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsembleDivergence_FUN_WU.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsembleDivergence_FUN_WU.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsembleDivergence_FUN_WU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsembleDivergence_FUN_WU.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsembleDivergence_FUN_WU.GRAPH_TEMPLATE
%%%% ¡title!
GRAPH & MEASURE PARAMETERS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsembleDivergence_FUN_WU.ME_DICT
%%%% ¡title!
Group-averaged MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsembleDivergence_FUN_WU.G_DICT
%%%% ¡title!
Individual GRAPHS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsembleDivergence_FUN_WU.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsembleDivergence_FUN_WU'

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'Functional Weighted Undirected Analyze Ensemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_FUN_WU) analyzes functional data using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with functional data.
%%% ¡settings!
'AnalyzeEnsembleDivergence_FUN_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsembleDivergence_FUN_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsembleDivergence_FUN_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsembleDivergence_FUN_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'GraphWU'

%%% ¡prop!
G_DICT (result, idict) is the graph (GraphWU) ensemble of Jensen–Shannon divergence individual connectivity matrix.
%%%% ¡settings!
'GraphWU'
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
connectivityMatrix = a.get('CONNECTOME_CONSTUCT_METHOD');
gr_pdf = a.get('GR');
wb = braph2waitbar(a.get('WAITBAR'), 0, ['Build up individual connectivity matrix for subjects ...']);
for i = 1:1:gr_pdf.get('SUB_DICT').get('LENGTH')
	sub = gr_pdf.get('SUB_DICT').get('IT', i);    
    A = connectivityMatrix{i};
    braph2waitbar(wb, .15 + .85 * i / gr_pdf.get('SUB_DICT').get('LENGTH'), ['Calculating connectivity matrix for subject ' num2str(i) ' of ' num2str(gr_pdf.get('SUB_DICT').get('LENGTH')) ' ...'])
    g = GraphWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ... 
        'NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS') ...
        );
    g_dict.get('ADD', g)    
end

if ~isa(a.get('GRAPH_TEMPLATE'), 'NoValue')
    for i = 1:1:g_dict.get('LENGTH')
        g_dict.get('IT', i).set('TEMPLATE', a.get('GRAPH_TEMPLATE'))
    end
end
braph2waitbar(wb, 'close')
value = g_dict;

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%% ¡props!

%%% ¡prop!
CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for individual connectome construction.
%%%% ¡calculate!
gr_pdf = a.get('GR');
JSdivMatrix_cross_subjects = {};
for sub_index = 1:1:gr_pdf.get('SUB_DICT').get('LENGTH')
    subj_suvrs = gr_pdf.get('SUB_DICT').get('IT',sub_index).get('FUN');
    numROIs = size(subj_suvrs,2);
    JSdivMatrix = zeros(numROIs, numROIs);
    for i = 1:numROIs
        for j = 1:numROIs % Calculate for all pairs including self-comparison
            p = subj_suvrs(:,i); % Assuming the density estimates are the 2nd element
            q = subj_suvrs(:,j);

            % Ensure p and q are normalized to sum to 1
            p = p / sum(p);
            q = q / sum(q);
            % Calculate the midpoint distribution
            m = 0.5 * (p + q);
            m(m == 0) = eps;

            % Calculate the KL divergence
            JSdiv = 0.5 * (sum(p .* log(p ./ m)) + sum(q .* log(q ./ m)));
            JSdivMatrix(i, j) = JSdiv;
            JSdivMatrix(j, i) = JSdiv; % Symmetric matrix
        end
    end
    JSdivMatrix_cross_subjects{sub_index} = JSdivMatrix;
end
value = JSdivMatrix_cross_subjects;

%% ¡tests!

%%% ¡excluded_props!
[AnalyzeEnsembleDivergence_FUN_WU.TEMPLATE AnalyzeEnsembleDivergence_FUN_WU.GRAPH_TEMPLATE]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
group_dir = fullfile(fileparts(which('AnalyzeEnsembleDivergence_FUN_WU')),'Example data Nifti');
if ~exist(group_dir)
    create_example_NIfTI([],group_dir) % only creates files if the example folder doesn't already exist
end

%%% ¡test!
%%%% ¡name!
Verify the divergence-based individual connectome pipeline 
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', which('aal94_atlas.xlsx'));
ba = im_ba.get('BA');

group_dir = fullfile(fileparts(which('AnalyzeEnsembleDivergence_FUN_WU')),'Example data Nifti', 'Group1');
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

path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('upsampled_AAL2.nii'))} ...
    );

% suvr_brain_label = readtable(which('AAL2_Atlas_Labels.csv'));
% suvr_brain_label = suvr_brain_label.Var4;
ref_region_list = [2001];% reference region label

gr1 = PDFConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{ref_region_list}, ...
    'ATLAS_KIND', {'AAL2'});


PDF_gr1 = gr1.get('GR');
g_temp  = GraphWU('STANDARDIZE_RULE', 'range');
a_WU1 = AnalyzeEnsembleDivergence_FUN_WU( ...
    'GR', PDF_gr1, ...
    'GRAPH_TEMPLATE', g_temp...
    );

num_subjects = a_WU1.get('G_DICT').get('LENGTH');

strength_first20 = zeros(num_subjects, 20);
strength_others = zeros(num_subjects,size(a_WU1.get('G_DICT').get('IT', 1).get('B'),1)- 20);

% Loop through subjects to calculate strength

for i = 1:num_subjects
    g = a_WU1.get('G_DICT').get('IT', i);
    strength = g.get('MEASURE', 'Strength').get('M'); % Strength for all regions
    A = g.get('A');
    strength20_regions = sum(A{1}(1:20,1:20),2);
    strengthother_regions = sum(A{1}(21:end,21:end),2);
    mean_20 = mean(strength20_regions(:));
    mean_others = mean(strengthother_regions(:));
    % Assert for each subject
    assert(mean_20 < mean_others, ...
        sprintf('Test failed for subject %d: The first 20 regions do not have higher Divergence than the other regions.',  i));
end