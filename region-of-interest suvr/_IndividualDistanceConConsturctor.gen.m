%% ¡header!
IndividualDistanceConConsturctor < IndividualConConstructorBase (icd, importer of SUVR subject group from .mat) imports a group of subjects with regional SUVR data from a series of XLS/XLSX file.

%%% ¡description!
IndividualDistanceConConsturctor imports a group of subjects with mean SUVR  
 (standarize uptake value ratio) data from a series of nifti files 
 contained in a folder named "group_data". All these files must be in the same 
 folder; also, no other files should be in the folder. Each file contains a 
 matrix of values corresponding to the intensity distribution of brain regions.
 The connectivity matrix constructed based on Mahanlanobis Distance is returned
 from ImporterIndividual_Distance_XLS.
The variables of interest are from another Nifti file named "SUVR_GROUP_MAT.vois.xlsx" 
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
ELCLASS (constant, string) is the class of the subject individual distance based connectivity constructor.
%%%% ¡default!
'IndividualDistanceConConsturctor'

%%% ¡prop!
NAME (constant, string) is the name of the subject individual distance based connectivity constructor.
%%%% ¡default!
'Distance based connectivity constructor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject individual distance based connectivity constructor.
%%%% ¡default!
'IndividualDistanceConConsturctor construct distance based connectome for a group of subjects with nifti file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject individual distance based connectivity constructor.
%%%% ¡settings!
'IndividualDistanceConConsturctor'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject individual distance based connectivity constructor.
%%%% ¡default!
'IndividualDistanceConConsturctor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject individual distance based connectivity constructor.
%%%% ¡default!
'IndividualDistanceConConsturctor label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject individual distance based connectivity constructor.
%%%% ¡default!
'IndividualDistanceConConsturctor notes'

%%% ¡prop!
CONNECTOME_CONSTUCT_METHOD (query, cell) defines the method for Mahalanobis distance individual connectome construction.
%%%% ¡calculate!
if isempty(varargin) && isempty(icd.get('GR_SUVR').get('SUB_DICT').get('IT_LIST'))
    value = {};
    return
end
gr_suvr = icd.get('GR_SUVR');
for i = 1:1:gr_suvr.get('SUB_DICT').get('LENGTH')
    subj_suvrs{i} = gr_suvr.get('SUB_DICT').get('IT',i).get('ST');
end

maxMahalDistAcrossSubjects = 0;
mahalDistances_cross_subjects = {};
for i = 1:1:length(subj_suvrs)
    subj_suvr = subj_suvrs{i};
    uniqueROIs = size(subj_suvr,1);
    % Calculate the global mean SUVR value for the subject
    globalMeanSUVR = mean(subj_suvr, 'all');
    % Subtract the global mean from each SUVR value to center the data
    centeredSUVRMatrix = subj_suvr - globalMeanSUVR;
    % Calculate the covariance matrix of the centered SUVR data
    covMatrix = cov(centeredSUVRMatrix');
    invCovMatrix = inv(covMatrix); % Inverse of the covariance matrix
    mahalDistances = zeros(uniqueROIs, uniqueROIs); % To store Mahalanobis distances for each ROI
    for roi1 = 1:uniqueROIs
        for roi2 = 1:uniqueROIs
            if roi1 ~= roi2
                % For each ROI, the diffVector is its centered SUVR values
                diffVector_first = centeredSUVRMatrix(roi1);
                mahalDist1 = sqrt((diffVector_first * invCovMatrix) * diffVector_first'); % Mahalanobis distance calculation
                diffVector_second = centeredSUVRMatrix(roi2);
                mahalDist2 = sqrt((diffVector_second * invCovMatrix) * diffVector_second'); % Mahalanobis distance calculation
                mahalDistances(roi1,roi2) = (mahalDist1+mahalDist2)/2; % Store the computed distance
            else
                mahalDistances(roi1,roi2) = 0;
            end
        end
    end
    % Update maxMahalDistAcrossSubjects if a larger distance is found
    currentMax = max(mahalDistances(:));
    if currentMax > maxMahalDistAcrossSubjects
        maxMahalDistAcrossSubjects = currentMax;
    end
    mahalDistances_cross_subjects{i} = mahalDistances;

end
scaledMahalDistMatrix_cross_subjects = {};
for i = 1:length(mahalDistances_cross_subjects)
    mahalDistMatrix = mahalDistances_cross_subjects{i};
    % Scale the Mahalanobis distances
    scaledMahalDistMatrix_cross_subjects{i} = 1 - mahalDistMatrix / ceil(maxMahalDistAcrossSubjects);
end
value = scaledMahalDistMatrix_cross_subjects;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
create_example_NIfTI()

%%% ¡test!
%%%% ¡name!
Verify the Distance-based individual connectome pipeline 
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', which('aal94_atlas.xlsx'));
ba = im_ba.get('BA');

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

path_dict = IndexedDictionary(...
    'IT_CLASS', 'FILE_PATH', ...
    'IT_LIST', {FILE_PATH('PATH', which('upsampled_AAL2.nii'))} ...
    );

% suvr_brain_label = readtable(which('AAL2_Atlas_Labels.csv'));
% suvr_brain_label = suvr_brain_label.Var4;
ref_region_list = [2001];% reference region label

gr1 = SUVRConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', ba,...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{ref_region_list}, ...
    'ATLAS_KIND', {'AAL2'});


SUVR_gr1 = gr1.get('GR');


constructor1 = IndividualDistanceConConsturctor( ...
    'GR_SUVR', SUVR_gr1);

distance_connectomes_gr1 = constructor1.get('GR');

g_temp  = GraphWU('STANDARDIZE_RULE', 'range');
a_WU1 = AnalyzeEnsemble_CON_WU('GR', distance_connectomes_gr1,'GRAPH_TEMPLATE', g_temp);
num_subjects = a_WU1.get('G_DICT').get('LENGTH');

% Initialize arrays for strength measures
strength_first20_1 = zeros(num_subjects, 20);
strength_others_1 = zeros(num_subjects,size(distance_connectomes_gr1.get('SUB_DICT').get('IT', 1).get('CON'),1)- 20);

for i = 1:num_subjects
    g = a_WU1.get('G_DICT').get('IT', i);
    strength = g.get('MEASURE', 'Strength').get('M'); % Strength for all regions
    strength20_regions = strength{1}(1:20,:);
    strengthother_regions = strength{1}(21:end,:);
    mean_20 = mean(strength20_regions(:));
    mean_others = mean(strengthother_regions(:));
    % Assert for each subject
    assert(mean_20 < mean_others, ...
        sprintf('Test failed for subject %d: The first 20 regions do not have higher distance than the other regions.', i));
end