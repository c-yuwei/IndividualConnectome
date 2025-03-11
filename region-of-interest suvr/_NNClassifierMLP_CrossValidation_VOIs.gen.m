%% ¡header!
NNClassifierMLP_CrossValidation_VOIs < NNClassifierMLP_CrossValidation (nncv, neural network cross-validation for MLP classifiers with VOIs) is a process for evaluating multi-layer perceptron classifiers with variables of interest using cross-validation.

%%% ¡description!
A cross-validation for multi-layer perceptron classifiers with variables of interest (NNClassifierMLP_CrossValidation_VOIs) extends the standard MLP cross-validation to incorporate additional variables of interest (VOIs), such as demographic or clinical data. It splits both the primary dataset and the VOI dataset into folds, trains the model on training folds, and validates on the held-out fold, repeating for all fold combinations.

To train all neural networks for all folds, use: nncv.get('TRAIN')

%%% ¡seealso!
NNDataPoint, NNDataset, NNEvaluator, NNClassifierMLP_VOIs, NNClassifierMLP_Evaluator_VOIs

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the cross-validation.
%%%% ¡default!
'NNClassifierMLP_CrossValidation_VOIs'

%%% ¡prop!
NAME (constant, string) is the name of the cross-validation.
%%%% ¡default!
'Neural Network Cross-Validation for Multi-layer Perceptron Classifiers with Variables of Interest'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the cross-validation.
%%%% ¡default!
'A cross validation for multi-layer perceptron classifiers with variables of interest (NNClassifierMLP_CrossValidation_VOIs) extends the standard MLP cross-validation to incorporate additional variables of interest (VOIs) such as demographic or clinical data. It splits both the primary dataset and the VOI dataset into folds, trains the model on training folds, and validates on the held-out fold, repeating for all fold combinations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the cross-validation.
%%%% ¡settings!
'NNClassifierMLP_CrossValidation_VOIs'

%%% ¡prop!
NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.
%%%% ¡settings!
'NNClassifierMLP_VOIs'


%%% ¡prop!
NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evaluator parameters.
%%%% ¡settings!
'NNClassifierMLP_Evaluator_VOIs'

%%% ¡prop!
NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.
%%%% ¡calculate!
d_list = nncv.get('D_LIST');
d_vois_list = nncv.get('D_VOIS_LIST');
if isempty(d_list) || isempty(d_vois_list)
    value = {};
else
    kfolds = nncv.get('KFOLDS');
    for i = 1:kfolds
        % Combine training folds for D and D_VOIS
        d_training_set = d_list;
        d_training_set(i) = [];  % Exclude the i-th fold
        d_training_set = NNDatasetCombine('D_LIST', d_training_set).get('D');
        
        d_vois_training_set = d_vois_list;
        d_vois_training_set(i) = [];  % Exclude the i-th fold
        d_vois_training_set = NNDatasetCombine('D_LIST', d_vois_training_set).get('D');
        
        if ~isa(nncv.getr('NN_TEMPLATE'), 'NoValue')
            nn_template = nncv.get('NN_TEMPLATE');
        else
            nn_template = NNClassifierMLP_VOIs( ...
                'EPOCHS', nncv.get('EPOCHS'), ...
                'BATCH', nncv.get('BATCH'), ...
                'SHUFFLE', nncv.get('SHUFFLE'), ...
                'SOLVER', nncv.get('SOLVER'), ...
                'VERBOSE', nncv.get('VERBOSE'), ...
                'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
        end
        
        value{i} = NNClassifierMLP_VOIs( ...
            'TEMPLATE', nn_template, ...
            'D', d_training_set, ...
            'D_VOIS', d_vois_training_set, ...
            'VERBOSE', nncv.get('VERBOSE'), ...
            'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
    end
end

%%% ¡prop!
EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
%%%% ¡calculate!
d_list = nncv.get('D_LIST');
d_vois_list = nncv.get('D_VOIS_LIST');
nn_list = nncv.get('NN_LIST');
if isempty(d_list) || isempty(d_vois_list) || isempty(nn_list)
    value = {};
else
    if ~isa(nncv.getr('NNEVALUATOR_TEMPLATE'), 'NoValue')
        nne_template = nncv.get('NNEVALUATOR_TEMPLATE');
    else
        nne_template = NNClassifierMLP_Evaluator_VOIs();
    end
    
    value = cell(length(d_list), 1);
    for i = 1:length(d_list)
        value{i} = NNClassifierMLP_Evaluator_VOIs( ...
            'TEMPLATE', nne_template, ...
            'D', d_list{i}, ...
            'D_VOIS', d_vois_list{i}, ...
            'NN', nn_list{i});
    end
end

%% ¡props!

%%% ¡prop!
D_VOIS (data, itemlist) is the VOI datasets from groups to be cross-validated.
%%%% ¡settings!
'NNDataset'
%%%% ¡check_value!
d_list = nncv.get('D');
d_vois_list = nncv.get('D_VOIS');
if length(d_list) ~= length(d_vois_list)
    check = 'The number of primary datasets (D) and VOI datasets (D_VOIS) must be equal.';
elseif ~isempty(d_list) && ~isempty(d_vois_list)
    for i = 1:length(d_list)
        if d_list{i}.get('DP_DICT').get('LENGTH') ~= d_vois_list{i}.get('DP_DICT').get('LENGTH')
            check = 'The number of data points in each primary dataset (D) and corresponding VOI dataset (D_VOIS) must be equal.';
            return
        end
    end
end
check = true;

%%% ¡prop!
DSP_VOIS (result, itemlist) is a list of dataset splitters for the VOI datasets.
%%%% ¡settings!
'NNDatasetSplit'
%%%% ¡calculate!
d_vois_list = nncv.get('D_VOIS');
split = nncv.get('SPLIT');
if isempty(split)
    split_per_dataset = {};
else
    for i = 1:length(d_vois_list)
        split_per_dataset{i} = split(i, :);
    end
end
value = cellfun(@(d_vois, s) NNDatasetSplit('D', d_vois, 'SPLIT', s), d_vois_list, split_per_dataset, 'UniformOutput', false);

%%% ¡prop!
DCO_VOIS (result, itemlist) is a list of dataset combiners for the VOI datasets per fold.
%%%% ¡settings!
'NNDatasetCombine'
%%%% ¡calculate!
dsp_vois_list = nncv.get('DSP_VOIS');
if length(dsp_vois_list) == 0
    value = {};
else
    kfolds = nncv.get('KFOLDS');
    for i = 1:1:kfolds
        d_vois_splitted_list = cellfun(@(dsp) dsp.get('D_LIST_IT', i), dsp_vois_list, 'UniformOutput', false);
        value{i} = NNDatasetCombine('D_LIST', d_vois_splitted_list);
    end
    value = value';
end

%%% ¡prop!
D_VOIS_LIST (result, itemlist) contains the split VOI datasets corresponding to the k folds.
%%%% ¡calculate!
dco_vois_list = nncv.get('DCO_VOIS');
if length(dco_vois_list) == 0
    value = {};
else
    value = cellfun(@(dco) dco.get('D'), dco_vois_list, 'UniformOutput', false);
end



%% ¡tests!

%%% ¡excluded_props!
[NNClassifierMLP_CrossValidation_VOIs.PFROC]

%%% ¡test!
%%%% ¡name!
Evaluate a classifier cross-validation with VOIs using example data
%%%% ¡code!
% Step 1: Ensure example data exists
data_dir = [fileparts(which('NNDataPoint_VOIs')) filesep 'Example data NN CLA CON XLS VOIs'];
if ~isfile([data_dir filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_XLS(data_dir); % Generate example files with VOIs
end

% Step 2: Load Brain Atlas
im_ba = ImporterBrainAtlasXLS('FILE', [data_dir filesep 'atlas.xlsx'], 'WAITBAR', true);
ba = im_ba.get('BA');

% Step 3: Load Groups of SubjectCON (primary connectivity data)
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [data_dir filesep 'CON_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
);
gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [data_dir filesep 'CON_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
);
gr2 = im_gr2.get('GR');

% Step 4: Create NNDataPoint_CON_CLA for primary connectivity data
% Group 1
sub_dict1 = gr1.get('SUB_DICT');
sub_list1 = sub_dict1.get('IT_LIST');
[~, group_folder_name1] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {group_folder_name1}), ...
    sub_list1, 'UniformOutput', false);

% Group 2
sub_dict2 = gr2.get('SUB_DICT');
sub_list2 = sub_dict2.get('IT_LIST');
[~, group_folder_name2] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {group_folder_name2}), ...
    sub_list2, 'UniformOutput', false);

% Create IndexedDictionary for primary data
dp_list1 = IndexedDictionary('IT_CLASS', 'NNDataPoint_CON_CLA', 'IT_LIST', it_list1);
dp_list2 = IndexedDictionary('IT_CLASS', 'NNDataPoint_CON_CLA', 'IT_LIST', it_list2);

% Create NNDataset for primary data
d1 = NNDataset('DP_CLASS', 'NNDataPoint_CON_CLA', 'DP_DICT', dp_list1);
d2 = NNDataset('DP_CLASS', 'NNDataPoint_CON_CLA', 'DP_DICT', dp_list2);

% Split primary datasets into training and test sets (70% training, 30% test)
d_split1 = NNDatasetSplit('D', d1, 'SPLIT', {0.7, 0.3});
d_split2 = NNDatasetSplit('D', d2, 'SPLIT', {0.7, 0.3});

% Combine training and test sets for primary data
d_training = NNDatasetCombine('D_LIST', {d_split1.get('D_LIST_IT', 1), d_split2.get('D_LIST_IT', 1)}).get('D');
d_test = NNDatasetCombine('D_LIST', {d_split1.get('D_LIST_IT', 2), d_split2.get('D_LIST_IT', 2)}).get('D');

% Step 5: Create NNDataPoint_VOIs for VOI data  data using gr.get('VOIS')
% Group 1
it_list_voi1 = cellfun(@(sub) NNDataPoint_VOIs( ...
    'ID', sub.get('ID'), ...
    'VOI_DICT', IndexedDictionary( ...
        'ID', 'subject_idict', ...
        'IT_CLASS', 'SubjectCON', ... % Adjusted to match SubjectCON
        'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
        'IT_LIST', sub.get('VOI_DICT').get('IT_LIST') ...
    ), ...
    'TARGET_CLASS', {group_folder_name1} ...
), sub_list1, 'UniformOutput', false);

% Group 2
it_list_voi2 = cellfun(@(sub) NNDataPoint_VOIs( ...
    'ID', sub.get('ID'), ...
    'VOI_DICT', IndexedDictionary( ...
        'ID', 'subject_idict', ...
        'IT_CLASS', 'SubjectCON', ...
        'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
        'IT_LIST', sub.get('VOI_DICT').get('IT_LIST') ...
    ), ...
    'TARGET_CLASS', {group_folder_name2} ...
), sub_list2, 'UniformOutput', false);

% Create IndexedDictionary for VOI data
voi_dp_list1 = IndexedDictionary('IT_CLASS', 'NNDataPoint_VOIs', 'IT_LIST', it_list_voi1);
voi_dp_list2 = IndexedDictionary('IT_CLASS', 'NNDataPoint_VOIs', 'IT_LIST', it_list_voi2);

% Create NNDataset for VOI data
d_vois1 = NNDataset('DP_CLASS', 'NNDataPoint_VOIs', 'DP_DICT', voi_dp_list1);
d_vois2 = NNDataset('DP_CLASS', 'NNDataPoint_VOIs', 'DP_DICT', voi_dp_list2);

% Set up cross-validation with VOIs
kfolds = 3; % Small number of folds for efficient testing
nncv = NNClassifierMLP_CrossValidation_VOIs('KFOLDS', kfolds, 'D', {d1, d2}, 'D_VOIS', {d_vois1, d_vois2});

% Retrieve lists for verification
d_list = nncv.get('D_LIST');
d_vois_list = nncv.get('D_VOIS_LIST');
nn_list = nncv.get('NN_LIST');
e_list = nncv.get('EVALUATOR_LIST');

% Assertions to verify correct functionality
% Check that the number of split primary datasets matches kfolds
assert(length(d_list) == kfolds, ...
    [BRAPH2.STR ':NNClassifierMLP_CrossValidation_VOIs:' BRAPH2.FAIL_TEST], ...
    'NNClassifierMLP_CrossValidation_VOIs does not correctly split the primary datasets into folds.' ...
);

% Check that the number of split VOI datasets matches kfolds
assert(length(d_vois_list) == kfolds, ...
    [BRAPH2.STR ':NNClassifierMLP_CrossValidation_VOIs:' BRAPH2.FAIL_TEST], ...
    'NNClassifierMLP_CrossValidation_VOIs does not correctly split the VOI datasets into folds.' ...
);

% Check that the neural network list has the correct number of elements
assert(length(nn_list) == kfolds, ...
    [BRAPH2.STR ':NNClassifierMLP_CrossValidation_VOIs:' BRAPH2.FAIL_TEST], ...
    'NNClassifierMLP_CrossValidation_VOIs does not calculate the neural network list correctly.' ...
);

% Check that the evaluator list has the correct number of elements
assert(length(e_list) == kfolds, ...
    [BRAPH2.STR ':NNClassifierMLP_CrossValidation_VOIs:' BRAPH2.FAIL_TEST], ...
    'NNClassifierMLP_CrossValidation_VOIs does not calculate the evaluator list correctly.' ...
);