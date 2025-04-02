%% ¡header!
NNxMLP_FeatureImportance_VOIs < NNxMLP_FeatureImportance (nnfi, neural network feature importace for multi-layer perceptron) provides feature importance analysis for multi-layer perceptron (MLP) using shuffled feature method.

%%% ¡description!
A neural network feature importace for multi-layer perceptron (NNxMLP_FeatureImportance_VOIs) 
 assesses the importance of features by measuring the increase in model error when the feature values are randomly shuffled. 
It introduces the permutation method to establish the significance of each feature (or composite features) by comparing the 
 original model loss to the distribution of losses obtained from several shuffled iterations, providing a robust statistical 
 analysis of feature importance using a user-defined confidence interval and adjusting for multiple comparisons with the Bonferroni correction.

%%% ¡seealso!
NNDataset, NNDataPointMLP_Shuffled, NNRegressorMLP, NNClassifierMLP, NNxMLP_FeatureImportanceAcrossMeasures

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs.ID
%%%% ¡title!
Feature Importance MLP ID

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs.LABEL
%%%% ¡title!
Feature Importance MLP LABEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs.D
%%%% ¡title!
Neural Networks Dataset

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs.NN
%%%% ¡title!
Neural Networks

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs.P
%%%% ¡title!
Permutation Number

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs.APPLY_BONFERRONI
%%%% ¡title!
Bonferroni Correction ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs.APPLY_CONFIDENCE_INTERVALS
%%%% ¡title!
Confidence Interval ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs.SIG_LEVEL
%%%% ¡title!
Significant Level

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs.FEATURE_IMPORTANCE
%%%% ¡title!
Feature Importance Score

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the feature importance analysis.
%%%% ¡default!
'NNxMLP_FeatureImportance_VOIs'

%%% ¡prop!
NAME (constant, string) is the name of the feature importance analysis.
%%%% ¡default!
'Neural Network Feature Importace for Multi-layer Perceptron'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the feature importance analysis.
%%%% ¡default!
'A neural network feature importace for multi-layer perceptron (NNxMLP_FeatureImportance_VOIs) assesses the importance of features by measuring the increase in model error when the feature values are randomly shuffled. It introduces the permutation method to establish the significance of each feature (or composite features) by comparing the original model loss to the distribution of losses obtained from several shuffled iterations, providing a robust statistical analysis of feature importance using a user-defined confidence interval and adjusting for multiple comparisons with the Bonferroni correction.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the feature importance analysis.
%%%% ¡settings!
'NNxMLP_FeatureImportance_VOIs'

%%% ¡prop!
ID (data, string) is a few-letter code of the feature importance analysis.
%%%% ¡default!
'NNxMLP_FeatureImportance_VOIs ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the feature importance analysis.
%%%% ¡default!
'NNxMLP_FeatureImportance_VOIs label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the feature importance analysis.
%%%% ¡default!
'NNxMLP_FeatureImportance_VOIs notes'

%%% ¡prop!
NN (data, item) contains a trained neural network multi-layer perceptron classifier or regressor.
%%%% ¡settings!
'NNBase'
%%%% ¡check_prop!
check = any(strcmp(value.get('ELCLASS'), {'NNBase', 'NNClassifierMLP_VOIs'}));

%%% ¡prop!
BASELINE_LOSS (result, scalar) is the loss value obtained from original dataset, acting as a baseline loss value for evaluating the feature importance.
%%%% ¡calculate!
d = nnfi.get('D');
nn = nnfi.get('NN');
net = nn.get('MODEL');
inputs = cell2mat(nnfi.memorize('BASELINE_INPUTS'));
d_vois = nnfi.get('NN').get('INPUTS', nnfi.get('D_VOIS'));
targets = nn.get('TARGETS', d);
if isempty(inputs)
    baseline_loss = 0;
else
    baseline_loss = crossentropy(net.predict(inputs, d_vois{1}), targets);
end
value = baseline_loss;

%%% ¡prop!
SHUFFLED_LOSS (query, rvector) is the loss value obtained from shuffled datasets.
%%%% ¡calculate!
if isempty(varargin)
    value = [];
    return
end
seed = varargin{1};
rng(seed, 'twister')

shuffled_loss = [];
d = nnfi.get('D');
d_vois = nnfi.get('D_VOIS');
if isa(d.getr('DP_DICT'), 'NoValue')
    value = shuffled_loss;
    return
end

nn = nnfi.get('NN');
targets = nn.get('TARGETS', d);

comp_feature_indices = nnfi.get('COMP_FEATURE_INDICES');
num_comp_feature_combinations = length(comp_feature_indices);
leap_parallel = 2^10;
shuffled_loss = [];

start = tic;
for j = 1:leap_parallel:num_comp_feature_combinations
    for i = j:min(j+leap_parallel, num_comp_feature_combinations)
        comp_feature_combination = comp_feature_indices{i};
        d_perm = nnfi.get('D_SHUFFLED', comp_feature_combination);
        predictions = nn.get('PREDICT', d_perm, d_vois);
        scrambled_loss = crossentropy(predictions, targets);
        shuffled_loss(i) = scrambled_loss;
    end
    if nnfi.get('VERBOSE')
        disp(['** PERMUTATION FEATURE IMPORTANCE - (composite) features #' int2str(min(j+leap_parallel-1, num_comp_feature_combinations)) '/' int2str(num_comp_feature_combinations) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
    end
    if nnfi.get('INTERRUPTIBLE')
        pause(nnfi.get('INTERRUPTIBLE'))
    end
end

value = shuffled_loss;

%% ¡props!

%%% ¡prop!
D_VOIS (data, item) is the neural networks dataset for feature importance analysis.
%%%% ¡settings!
'NNDataset'


%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example ST
%%%% ¡code!
create_data_NN_CLA_ST_XLS_VOIs() % only creates files if the example folder doesn't already exist

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

im_gr3 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_3.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr3 = im_gr3.get('GR');

% Training-test split
% create item lists of NNDataPoint_ST_CLA
it_list1 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {gr1.get('ID')}), ...
    gr1.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

it_list2 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {gr2.get('ID')}), ...
    gr2.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

it_list3 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_CLASS', {gr3.get('ID')}), ...
    gr3.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_ST_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list2 ...
        );

dp_list3 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list3 ...
        );

% create a NNDataset containing the NNDataPoint_ST_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
    'DP_DICT', dp_list2 ...
    );

d3 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
    'DP_DICT', dp_list3 ...
    );

% Split the NNData into training set and test set
d_split1 = NNDatasetSplit('D', d1, 'SPLIT', {0.7, 0.3});
d_split2 = NNDatasetSplit('D', d2, 'SPLIT', {0.7, 0.3});
d_split3 = NNDatasetSplit('D', d3, 'SPLIT', {0.7, 0.3});

d_training = NNDatasetCombine('D_LIST', {d_split1.get('D_LIST_IT', 1), d_split2.get('D_LIST_IT', 1), d_split3.get('D_LIST_IT', 1)}).get('D');
d_test = NNDatasetCombine('D_LIST', {d_split1.get('D_LIST_IT', 2), d_split2.get('D_LIST_IT', 2), d_split3.get('D_LIST_IT', 2)}).get('D');

% Create a MLP classifier with training set
nn = NNClassifierMLP('D', d_training, 'LAYERS', [20 20]);
nn.get('TRAIN');

% Evaluate the feature importance
fi = NNxMLP_FeatureImportance('D', d_test, 'NN', nn, 'P', 5, 'APPLY_BONFERRONI', true, 'APPLY_CONFIDENCE_INTERVALS', true);
fi_score = fi.get('RESHAPED_FEATURE_IMPORTANCE');
input_dp = it_list1{1}.get('INPUT');

assert(isequal(size(cell2mat(fi_score)), size(cell2mat(input_dp))), ...
	        [BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.FAIL_TEST], ...
	        'NNxMLP_FeatureImportance does not have the feature importance score array of the same feature size as the input data.' ...
	        )

