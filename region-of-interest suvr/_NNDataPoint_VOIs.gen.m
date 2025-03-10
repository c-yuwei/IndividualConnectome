%% ¡header!
NNDataPoint_VOIs < NNDataPoint (dp, variable of interests (VOIs) data point) is a data point for classification with a graph.

%%% ¡description!
A data point for classification with variable of interests (VOIs) (NNDataPoint_VOIs) 
 contains both input and target for neural network analysis.
The input is the value of variable of interests extracted from vois.file of subject.
The target is obtained from the variables of interest of the subject.

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for variable of interest.
%%%% ¡default!
'NNDataPoint_VOIs'

%%% ¡prop!
NAME (constant, string) is the name of the data point for variable of interest.
%%%% ¡default!
'Neural Network Data Point for variable of interests'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the data point for variable of interest.
%%%% ¡default!
'A data point for variable of interests (NNDataPoint_VOIs) contains both input and target for neural network analysis. The input is the value of variable of interests extracted from vois.file of subject.. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the data point for variable of interest.
%%%% ¡settings!
'NNDataPoint_VOIs'

%%% ¡prop!
ID (data, string) is a few-letter code for the data point for variable of interest.
%%%% ¡default!
'NNDataPoint_VOIs ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the data point for variable of interest.
%%%% ¡default!
'NNDataPoint_VOIs label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the data point for variable of interest.
%%%% ¡default!
'NNDataPoint_VOIs notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point, a vector of VOI values.
%%%% ¡calculate!
voi_dict = dp.get('VOI_DICT');
if voi_dict.get('LENGTH') == 0
    value = {};
else
    % Extract all VOI values into a vector
    voi_list = voi_dict.get('IT_LIST');
    values = cellfun(@(voi) voi.get('V'), voi_list, 'UniformOutput', false);
    % Convert to numeric vector (assumes VOIs are numeric or categorical indices)
    value = {cell2mat(values)};
end
    
%%% ¡prop!
TARGET (result, cell) is the target values for this data point.
%%%% ¡calculate!
value = cellfun(@(c) sum(double(c)), dp.get('TARGET_CLASS'), 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
VOI_DICT (data, idict) is a dictionary with variable of interests.
%%%% ¡settings!
'Subject'
		
%%% ¡prop!
TARGET_CLASS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.

%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_VOIs.G]

%%% ¡test!
%%%% ¡name!
Construct the data point with the adjacency matrix derived from its weighted undirected graph (GraphWU) 
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_VOIs')) filesep 'Example data NN CLA CON XLS VOIs' filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_XLS_VOIs() % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_VOIs')) filesep 'Example data NN CLA CON XLS VOIs' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_VOIs')) filesep 'Example data NN CLA CON XLS VOIs' filesep 'CON_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

% Get the subject dictionary and extract the list of subjects
sub_dict1 = gr1.get('SUB_DICT');
sub_list1 = sub_dict1.get('IT_LIST'); % Get all subjects as a cell array
[~, group_folder_name1] = fileparts(im_gr1.get('DIRECTORY'));
% Use cellfun to create NNDataPoint_VOIs for each subject
it_list_voi1 = cellfun(@(sub) NNDataPoint_VOIs( ...
    'ID', sub.get('ID'), ...
    'VOI_DICT', IndexedDictionary( ...
        'ID', 'subject_idict', ...
        'IT_CLASS', 'SubjectNIfTI', ...
        'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
        'IT_LIST', sub.get('VOI_DICT').get('IT_LIST') ...
        ), ...
    'TARGET_CLASS', {group_folder_name1} ...
    ), sub_list1, 'UniformOutput', false);

% create NNDataPoint_Graph_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_VOIs', ...
        'IT_LIST', it_list_voi1 ...
        );

% create a NNDataset containing the NNDataPoint_Graph_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_VOIs', ...
    'DP_DICT', dp_list1 ...
    );

% Verify VOI values by comparing Age from SubjectCON and NNDataPoint_VOIs
for i = 1:gr1.get('SUB_DICT').get('LENGTH')
    % Get the original subject and its ID
    sub = gr1.get('SUB_DICT').get('IT', i);
    sub_id = sub.get('ID');
    
    % Find the corresponding NNDataPoint_VOIs by ID
    dp_voi = d1.get('DP_DICT').get('IT_FROM_KEY', sub_id);
    
    % Retrieve Age VOI from SubjectCON using IT_FROM_KEY
    voi_age = sub.get('VOI_DICT').get('IT_FROM_KEY', 'Age');
    age_sub = voi_age.get('V');
    
    % Retrieve Age VOI from NNDataPoint_VOIs (as TARGET since TARGET_CLASS is 'Age')
    age_dp = dp_voi.get('VOI_DICT').get('IT_FROM_KEY','Age').get('V');  % TARGET should be Age value
    
    % Assert that the Age values match
    assert(isequal(age_sub, age_dp), ...
        [BRAPH2.STR ':NNDataPoint_VOIs:' BRAPH2.FAIL_TEST], ...
        ['Age VOI mismatch for subject ' sub_id ': expected ' num2str(age_sub) ', got ' num2str(age_dp)]);
    
    % Retrieve Age VOI from SubjectCON using IT_FROM_KEY
    voi_sex = sub.get('VOI_DICT').get('IT_FROM_KEY', 'Sex');
    sex_sub = voi_sex.get('V');
    
    % Retrieve Age VOI from NNDataPoint_VOIs (as TARGET since TARGET_CLASS is 'Age')
    sex_dp = dp_voi.get('VOI_DICT').get('IT_FROM_KEY','Sex').get('V');  % TARGET should be Age value
    
    % Assert that the Age values match
    assert(isequal(sex_sub, sex_dp), ...
        [BRAPH2.STR ':NNDataPoint_VOIs:' BRAPH2.FAIL_TEST], ...
        ['Age VOI mismatch for subject ' sub_id ': expected ' num2str(age_sub) ', got ' num2str(age_dp)]);
end