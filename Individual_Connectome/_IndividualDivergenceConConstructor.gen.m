%% ¡header!
IndividualDivergenceConConstructor < IndividualConConstructorBase (idi, importer of SUVR subject group from .mat) imports a group of subjects with regional SUVR data from a series of XLS/XLSX file.

%%% ¡description!
IndividualDivergenceConConstructor imports a group of subjects with regional SUVR  
 (standarize uptake value ratio) data from a series of .xlsx files 
 contained in a folder named "group_data". All these files must be in the same 
 folder; also, no other files should be in the folder. Each file contains a 
 matrix of values corresponding to the intensity distribution of brain regions.
The variables of interest are from another XLS/XLSX file named "SUVR_GROUP_MAT.vois.xlsx" 
 (if exisitng) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectCON, ExporterGroupSubjectCON_XLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the CON subject group importer from XLS/XLSX.
%%%% ¡default!
'IndividualDivergenceConConstructor'

%%% ¡prop!
NAME (constant, string) is the name of the CON subject group importer from XLS/XLSX.
%%%% ¡default!
'Individual Divergence-based Subject Connectome Constructor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the CON subject individual importer from XLS/XLSX.
%%%% ¡default!
'IndividualDivergenceConConstructor imports a group of subjects with Nifti data. The variables of interest can be loaded from another XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the CON subject individual Constructor from Nifti.
%%%% ¡settings!
'IndividualDivergenceConConstructor'

%%% ¡prop!
ID (data, string) is a few-letter code for the CON subject individual Constructor from Nifti.
%%%% ¡default!
'IndividualDivergenceConConstructor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the CON subject individual Constructor from Nifti.
%%%% ¡default!
'IndividualDivergenceConConstructor label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the CON subject individual Constructor from Nifti.
%%%% ¡default!
'IndividualDivergenceConConstructor notes'

%%% ¡prop!
CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for individual connectome construction.
%%%% ¡calculate!
gr_suvr = idi.get('GR_SUVR');
JSdivMatrix_cross_subjects = {};
for sub_index = 1:1:gr_suvr.get('SUB_DICT').get('LENGTH')
    subj_suvrs = gr_suvr.get('SUB_DICT').get('IT',sub_index).get('FUN');
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
[ImporterGroupSubjectCON_XLS.GET_DIR]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
create_data_CON_XLS() % only creates files if the example folder doesn't already exist

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
ba = BrainAtlas();

im_gr = ImporterIndividual_JSDivergence_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON')) filesep 'Example data CON XLS' filesep 'CON_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')