%% ¡header!
NNClassifierMLP_Evaluator_VOIs < NNClassifierMLP_Evaluator (nne, neural network evaluator for multi-layer perceptron classifier with VOIs) evaluates the performance of a multi-layer perceptron classifier with dual datasets.

%%% ¡description!
A neural network evaluator for a multi-layer perceptron classifier with variables of interest (NNClassifierMLP_Evaluator_VOIs) evaluates the performance of an NNClassifierMLP_VOIs classifier using a primary dataset (D) and a VOI dataset (D_VOIs). It computes classification metrics (e.g., confusion matrix, AUC) based on dual-input predictions.

%%% ¡seealso!
NNDataPoint_CON_CLA, NNDataPoint_VOIs, NNClassifierMLP_VOIs

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator_VOIs.ID
%%%% ¡title!
Cross Validation ID

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator_VOIs.LABEL
%%%% ¡title!
Cross Validation LABEL

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator_VOIs.AUC
%%%% ¡title!
Area Under Receiver Operating Characteristic Curve

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator_VOIs.PFROC
%%%% ¡title!
Plot Receiver Operating Characteristic Curve

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator_VOIs.MACRO_AUC
%%%% ¡title!
Macro Area Under Receiver Operating Characteristic Curve

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator_VOIs.C_MATRIX
%%%% ¡title!
Confusion Matrix

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the neural network evaluator for a multi-layer perceptron classifier with VOIs.
%%%% ¡default!
'NNClassifierMLP_Evaluator_VOIs'

%%% ¡prop!
NAME (constant, string) is the name of the neural network evaluator for a multi-layer perceptron classifier with VOIs.
%%%% ¡default!
'Neural Network Evaluator for a Multi-layer Perceptron Classifier with Variables of Interest'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network evaluator for a multi-layer perceptron classifier with VOIs.
%%%% ¡default!
'A neural network evaluator for a multi-layer perceptron classifier with variables of interest (NNClassifierMLP_Evaluator_VOIs) evaluates the performance of an NNClassifierMLP_VOIs classifier using a primary dataset (D) and a VOI dataset (D_VOIs). It computes classification metrics (e.g., confusion matrix, AUC) based on dual-input predictions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network evaluator for a multi-layer perceptron classifier with VOIs.
%%%% ¡settings!
'NNClassifierMLP_Evaluator_VOIs'

%%% ¡prop!
ID (data, string) is a few-letter code for the neural network evaluator.
%%%% ¡default!
'NNClassifierMLP_Evaluator_VOIs ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network evaluator.
%%%% ¡default!
'NNClassifierMLP_Evaluator_VOIs label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network evaluator.
%%%% ¡default!
'NNClassifierMLP_Evaluator_VOIs notes'

%%% ¡prop!
NN (data, item) contains a trained neural network multi-layer perceptron classifier with VOIs.
%%%% ¡settings!
'NNClassifierMLP_VOIs';;

%%% ¡prop!
C_MATRIX (result, matrix) provides the confusion matrix for dual-input predictions from D and D_VOIs.
%%%% ¡calculate!
d = nne.get('D');
d_vois = nne.get('D_VOIS');
nn = nne.get('NN');
if isempty(d) || isempty(d_vois)
    value = [];
else
    % Predictions using both D and D_VOIs
    predictions = cell2mat(nn.get('PREDICT', d, d_vois));
    [~, maxIndices] = max(predictions, [], 2);
    predictions = logical(full(sparse(1:numel(maxIndices), maxIndices, 1, size(predictions, 1), size(predictions, 2))));

    classNames = nn.get('MODEL').Layers(end).Classes;
    for i = 1:length(predictions)
        classified(i) = classNames(predictions(i, :));
    end
    ground_truth = categorical(nne.get('GROUND_TRUTH'));
    value = confusionmat(classified, ground_truth);
end

%%% ¡prop!
AUC (result, rvector) provides the AUC for dual-input predictions from D and D_VOIs.
%%%% ¡calculate!
d = nne.get('D');
d_vois = nne.get('D_VOIS');
nn = nne.get('NN');
if isempty(d) || isempty(d_vois)
    value = [];
else
    predictions = cell2mat(nne.get('NN').get('PREDICT', d, d_vois));
    class_names = nn.get('MODEL').Layers(end).Classes;
    ground_truth = categorical(nne.get('GROUND_TRUTH'));
    rocNet = rocmetrics(ground_truth, predictions, class_names);
    value = rocNet.AUC;
end

%%% ¡prop!
MACRO_AUC (result, scalar) provides the average AUC across classes for multi-layer perceptron classifier with VOIs.
%%%% ¡calculate!
auc = nne.get('AUC');
if isempty(auc)
    value = 0;
else
    value = double(mean(auc));
end

%%% ¡prop!
PFROC (gui, item) contains the panel figure of the ROC plot for classification model.
%%%% ¡settings!
'NNClassifierMLP_EvaluatorPF_ROC_VOIs'
%%%% ¡postprocessing!
if isa(nne.getr('PFROC'), 'NoValue')
    nne.set('PFROC', NNClassifierMLP_EvaluatorPF_ROC_VOIs('NNE', nne));
end
%%%% ¡gui!
pr = PanelPropItem('EL', nne, 'PROP', NNClassifierMLP_EvaluatorPF_ROC_VOIs.PFROC, ...
    'GUICLASS', 'GUIFig', ...
	'BUTTON_TEXT', ['ROC Plot'], ...
    varargin{:});

%% ¡props!

%%% ¡prop!
D_VOIS (data, item) is the voi dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
%%%% ¡settings!
'NNDataset'

%% ¡tests!

%%% ¡excluded_props!
[NNClassifierMLP_Evaluator_VOIs.PFROC]

%%% ¡test!
%%%% ¡name!
Evaluate a classifier with the example data and variable of interest
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

% Split VOI datasets into training and test sets (same split as primary data)
d_vois_split1 = NNDatasetSplit('D', d_vois1, 'SPLIT', {0.7, 0.3});
d_vois_split2 = NNDatasetSplit('D', d_vois2, 'SPLIT', {0.7, 0.3});

% Combine training and test sets for VOI data
d_vois_training = NNDatasetCombine('D_LIST', {d_vois_split1.get('D_LIST_IT', 1), d_vois_split2.get('D_LIST_IT', 1)}).get('D');
d_vois_test = NNDatasetCombine('D_LIST', {d_vois_split1.get('D_LIST_IT', 2), d_vois_split2.get('D_LIST_IT', 2)}).get('D');

% Step 6: Define and train the neural network with VOIs
nn = NNClassifierMLP_VOIs( ...
    'D', d_training, ...
    'D_VOIS', d_vois_training, ...
    'LAYERS', [128 128], ...
    'VOI_SELECTION', {'Age', 'Sex'} ...
);
nn.get('TRAIN');

% Step 7: Evaluate the classifier with the test set
nne_test = NNClassifierMLP_Evaluator_VOIs('D', d_test, 'D_VOIS', d_vois_test, 'NN', nn);
confusion_matrix = nne_test.get('C_MATRIX');
auc = nne_test.get('AUC');
av_auc = nne_test.get('MACRO_AUC');

% Step 8: Assertions
% Assert that accuracy is high (e.g., >= 0.9)
assert(av_auc >= 0.9, ...
    [BRAPH2.STR ':NNClassifierMLP_VOIs:' BRAPH2.FAIL_TEST], ...
    'NNClassifierMLP_VOIs failed to achieve sufficient accuracy with VOI-only differences. Expected >= 90%, got %.2f%%.', av_auc * 100 ...
);

% Check if the number of fully connected layers matches the specified LAYERS property
trained_model = nn.get('MODEL');
assert(length(nn.get('LAYERS')) == sum(contains({trained_model.Layers.Name}, 'Dense')) - 1, ...
    [BRAPH2.STR ':NNClassifierMLP_VOIs:' BRAPH2.FAIL_TEST], ...
    'NNClassifierMLP_VOIs does not construct the layers correctly. The number of hidden layers should match the specified LAYERS property.' ...
);


% Check whether the ground truth are derived as expected
ground_truth = nne_test.get('GROUND_TRUTH');
targets = nne_test.get('NN').get('TARGET_CLASSES', d_test);

for i = 1:size(ground_truth, 1)
    check(i) = isequal(targets{i}, ground_truth{i});
end
assert(all(check), ...
    [BRAPH2.STR ':NNEvaluator_CLA:' BRAPH2.FAIL_TEST], ...
    'NNEvaluator_CLA does not calculate the ground truth correctly.' ...
    )

% Check whether the number of predictions are the same as the input datapoints
predictions = cell2mat(nne_test.get('NN').get('PREDICT', nne_test.get('D'),nne_test.get('D_VOIS')));
num_predictions = length(predictions);
num_datapoints = nne_test.get('D').get('DP_DICT').get('LENGTH');
assert(isequal(num_predictions, num_datapoints), ...
    [BRAPH2.STR ':NNEvaluator_CLA:' BRAPH2.FAIL_TEST], ...
    'NNEvaluator_CLA does not calculate the predictions correctly.' ...
    )

% Check whether the dimension of the confusion matrix matches with the number of classes
c_matrix = nne_test.get('C_MATRIX');
dim_c = size(c_matrix, 1);
num_classes = numel(nne_test.get('NN').get('MODEL').Layers(end).Classes);
assert(isequal(dim_c, num_classes), ...
    [BRAPH2.STR ':NNEvaluator_CLA:' BRAPH2.FAIL_TEST], ...
    'NNEvaluator_CLA does not calculate the confusion matrix correctly.' ...
    )

% Check whether the dimension of the AUC matches with the number of classes
auc = nne_test.get('AUC');
dim_auc = length(auc);
num_classes = numel(nne_test.get('NN').get('MODEL').Layers(end).Classes);
assert(isequal(dim_auc, num_classes), ...
    [BRAPH2.STR ':NNEvaluator_CLA:' BRAPH2.FAIL_TEST], ...
    'NNEvaluator_CLA does not calculate the confusion matrix correctly.' ...
    )
