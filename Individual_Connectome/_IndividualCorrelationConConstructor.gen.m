%% ¡header!
IndividualCorrelationConConstructor < IndividualConConstructorBase (icc, constructor of correlation based brain connectome)  Construct correlation based brain connecome from subjects with nifti files.

%%% ¡description!
IndividualDeviationConConstructor imports a group of subjects with regional SUVR  
 (standarize uptake value ratio) data from a series of Nifti files 
 contained in a folder named "group_data". All these files must be in the same 
 folder; also, no other files should be in the folder. Each file contains a 
 matrix of values corresponding to the intensity distribution of brain regions.
 The connectivity matrix constructed based on Mahanlanobis Distance is returned
 from ImporterIndividual_Distance_XLS.
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
ELCLASS (constant, string) is the class of the correlation based brain connectome constructor from Nifti.
%%%% ¡default!
'IndividualCorrelationConConstructor'

%%% ¡prop!
NAME (constant, string) is the name of thecorrelation based brain connectome constructor from Nifti.
%%%% ¡default!
'Individual Subject Correlation Connectome Constructor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the CON subject individual importer from XLS/XLSX.
%%%% ¡default!
'IndividualCorrelationConConstructor imports a group of subjects with connectivity data from a series of XLS/XLSX file. The variables of interest can be loaded from another XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the CON subject individual importer from XLS/XLSX.
%%%% ¡settings!
'IndividualCorrelationConConstructor'

%%% ¡prop!
ID (data, string) is a few-letter code for the CON subject individual importer from XLS/XLSX.
%%%% ¡default!
'IndividualCorrelationConConstructor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the CON subject individual importer from XLS/XLSX.
%%%% ¡default!
'IndividualCorrelationConConstructor label'

%%% ¡prop!
CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for individual connectome construction.
%%%% ¡calculate!
gr_suvr = icc.get('GR_SUVR');
correlationMatrix_cross_subjects = {};
for i = sub_index:1:gr_suvr.get('SUB_DICT').get('LENGTH')
    subj_suvrs = gr_suvr.get('SUB_DICT').get('IT',sub_index).get('FUN');
    numROIs = size(subj_suvrs,2);
    correlationMatrix = zeros(numROIs, numROIs);
    % Calculate JS divergence between each pair of ROIs
    for i = 1:numROIs
        for j = i+1:numROIs % To avoid redundant calculations
            p = subj_suvrs(:,i); % Assuming the density estimates are the 2nd element
            q = subj_suvrs(:,j);
            % Calculate correlation coefficient
            R = corrcoef(p, q);
            R_average = (R(1,2) +  R(2,1))/2;
            % Store the result (using the first element of the correlation matrix)
            correlationMatrix(i, j) = R_average; % The off-diagonal contains correlation coefficients
            correlationMatrix(j, i) = R_average; % Ensure symmetry
        end
    end

    correlationMatrix_cross_subjects{sub_index} = correlationMatrix;
end

value = correlationMatrix_cross_subjects;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectCON_XLS.GET_DIR]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
create_data_CON_XLS() % only creates files if the example folder doesn't already exist
