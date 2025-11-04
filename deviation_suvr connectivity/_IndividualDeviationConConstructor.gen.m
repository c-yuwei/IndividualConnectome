%% ¡header!
IndividualDeviationConConstructor < IndividualConConstructorBase (icdd, deviation-based subject individual brain connectome Constructor) Construct deviation based brain connecome from subjects with nifti files.

%%% ¡description!
IndividualDeviationConConstructor imports a group of subjects with regional SUVR  
 (standarize uptake value ratio) data from SUVRConsturctor.
 The connectivity matrix constructed based on Mahanlanobis Distance 

%%% ¡seealso!
Group, SubjectCON, ExporterGroupSubjectCON_XLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the CON subject group importer from XLS/XLSX.
%%%% ¡default!
'IndividualDeviationConConstructor'

%%% ¡prop!
NAME (constant, string) is the name of the CON subject group importer from XLS/XLSX.
%%%% ¡default!
'Individual Subject Deviation Connectome Constructor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the CON subject individual importer from XLS/XLSX.
%%%% ¡default!
'IndividualDeviationConConstructor imports a group of subjects with connectivity data from a series of XLS/XLSX file. The variables of interest can be loaded from another XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the CON subject individual importer from XLS/XLSX.
%%%% ¡settings!
'IndividualDeviationConConstructor'

%%% ¡prop!
ID (data, string) is a few-letter code for the CON subject individual importer from XLS/XLSX.
%%%% ¡default!
'IndividualDeviationConConstructor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the CON subject individual importer from XLS/XLSX.
%%%% ¡default!
'IndividualDeviationConConstructor label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the CON subject individual importer from XLS/XLSX.
%%%% ¡default!
'IndividualDeviationConstructor notes'

%%% ¡prop!
CONNECTOME_CONSTRUCT_METHOD (query, cell) defines the method for z-scoring individual connectome construction.
%%%% ¡calculate!
if isempty(varargin) && isempty(icdd.get('GR_SUVR').get('SUB_DICT').get('IT_LIST'))
    value = {};
    return
end
gr_suvr = icdd.get('GR_SUVR');
gr_suvr_reference = icdd.get('GR_SUVR_REF');
% healthy subjects
healthySUVRValues = [];
for i = 1:1:gr_suvr_reference.get('SUB_DICT').get('LENGTH')
    meanSUVR_values_region = gr_suvr_reference.get('SUB_DICT').get('IT',i).get('ST');
    healthySUVRValues = [healthySUVRValues, meanSUVR_values_region];
end

% Calculate global mean and std deviation for each region across healthy subjects
globalMeanHealthySUVR = mean(healthySUVRValues, 2); % Mean across subjects for each region
globalStdHealthySUVR = std(healthySUVRValues, 0, 2); % Std deviation across subjects for each region
zscorematrix_cross_subjects = {};
for i = 1:1:gr_suvr.get('SUB_DICT').get('LENGTH')
    meanSUVR_values_region = gr_suvr.get('SUB_DICT').get('IT',i).get('ST');
    sub_id = gr_suvr.get('SUB_DICT').get('IT',i).get('ID');
    numROIs = length(meanSUVR_values_region);
    zScoreConnectivityMatrix = zeros(numROIs, numROIs);
    % Compute z-scores for each ROI pair
    for m = 1:numROIs
        for n = 1:numROIs
            if m ~= n % Avoid diagonal
                avgSUVR_m = meanSUVR_values_region(m);
                avgSUVR_n = meanSUVR_values_region(n);
                zScore_m = (avgSUVR_m - globalMeanHealthySUVR(m)) / globalStdHealthySUVR(m);
                zScore_n = (avgSUVR_n - globalMeanHealthySUVR(n)) / globalStdHealthySUVR(n);

                %if zScore_m * zScore_n > 0
                zScoreConnectivityMatrix(m, n) = (abs(zScore_m)+abs(zScore_n))/2;
            else
                zScoreConnectivityMatrix(m, n) = 0;
            end
        end
    end
    zscorematrix_cross_subjects{i} = zScoreConnectivityMatrix;
end
value = zscorematrix_cross_subjects;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example data
%%%% ¡code!
group_dir = fullfile(fileparts(which('IndividualDeviationConConstructor')),'Example data Nifti');
if ~exist(group_dir)
    create_example_NIfTI([],group_dir)
end

%%% ¡test!
%%%% ¡name!
Verify Deviation-Based Connectome Constructor
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

ref_region_list = [2001];% reference region label

gr = SUVRConstructor('GR_PET',gr1_PET, ...
    'GR_T1',gr1_WM_GM, ...
    'BA', {ba},...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{ref_region_list}, ...
    'ATLAS_KIND', {'AAL2'}, ...
    'SUVR_REGION_SELECTION', selected_br_dict);

gr_ref = SUVRConstructor('GR_PET',gr_ref_PET, ...
    'GR_T1',gr_ref_WM_GM, ...
    'BA', {ba},...
    'ATLAS_PATH_DICT' ,path_dict, ...
    'REF_REGION_LIST',{ref_region_list}, ...
    'ATLAS_KIND', {'AAL2'}, ...
    'SUVR_REGION_SELECTION', selected_br_dict);

Con_gr = gr.get('GR');
Con_gr_ref = gr_ref.get('GR');

constructor = IndividualDeviationConConstructor( ...
    'GR_SUVR', Con_gr, ...
    'GR_SUVR_REF', Con_gr_ref ...
    );

deviation_connectomes = constructor.get('GR');

g_temp  = GraphWU('STANDARDIZE_RULE', 'range');
a_WU1 = AnalyzeEnsemble_CON_WU('GR', deviation_connectomes,'GRAPH_TEMPLATE', g_temp);
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

    % % Assert for each subject
    assert(mean_strength_first20 < mean_strength_others, ...
        sprintf('Test failed for subject %d: The first 20 regions do not have higher deviation strength than the other regions.', i));
end