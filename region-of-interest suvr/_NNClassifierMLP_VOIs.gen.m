%% ¡header!
NNClassifierMLP_VOIs < NNClassifierMLP (nn, multi-layer perceptron classifier with vois) comprises a multi-layer perceptron classifier model and a given dataset with variable of interests.

%%% ¡description!
This is children class of NNClassifierMLP that also includes user-defined variable of interests loaded from NNDataset for classification

%%% ¡seealso!
NNDataPoint_CON_CLA, NNClassifier_Evaluator_VOIs

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.ID
%%%% ¡title!
Neural Networks ID

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.LABEL
%%%% ¡title!
Neural Networks LABEL

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.PLOT_TRAINING
%%%% ¡title!
PLOT TRAINING PROGRESS

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.EPOCHS
%%%% ¡title!
Training EPOCHS

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.BATCH
%%%% ¡title!
Training BATCH

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.SHUFFLE
%%%% ¡title!
Training SHUFFLE

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.SOLVER
%%%% ¡title!
Training SOLVER

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.D
%%%% ¡title!
DATASET

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.D_VOIS
%%%% ¡title!
DATASET

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.LAYERS
%%%% ¡title!
Number of Neurons per Layer

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.MODEL
%%%% ¡title!
Neural Network CLASSIFIER

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_VOIs.NOTES
%%%% ¡title!
Neural Networks NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the neural network multi-layer perceptron classifier.
%%%% ¡default!
'NNClassifierMLP_VOIs'

%%% ¡prop!
NAME (constant, string) is the name of the neural network multi-layer perceptron classifier.
%%%% ¡default!
'Neural Network Multi-layer Perceptron Classifier with Variables of interests'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron classifier.
%%%% ¡default!
'A neural network multi-layer perceptron classifier (NNClassifierMLP) comprises a multi-layer perceptron classifier model and a given dataset. NNClassifierMLP trains the multi-layer perceptron classifier with a formatted inputs ("CB", channel and batch) derived from the given dataset.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron classifier.
%%%% ¡settings!
'NNClassifierMLP_VOIs'

%%% ¡prop!
ID (data, string) is a few-letter code for the neural network multi-layer perceptron classifier.
%%%% ¡default!
'NNClassifierMLP_VOIs ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron classifier.
%%%% ¡default!
'NNClassifierMLP_VOIs label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron classifier.
%%%% ¡default!
'NNClassifierMLP_VOIs notes'

%%% ¡prop!
D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
%%%% ¡settings!
'NNDataset'
%%%% ¡default!
NNDataset('DP_CLASS', 'NNDataPoint_CON_CLA')

%%% ¡prop!
DP_CLASSES (parameter, classlist) is the list of compatible data points.
%%%% ¡default!
{'NNDataPoint_CON_CLA' 'NNDataPoint_CON_FUN_MP_CLA' 'NNDataPoint_FUN_CLA' 'NNDataPoint_ST_CLA' 'NNDataPoint_ST_MM_CLA' 'NNDataPoint_Graph_CLA' 'NNDataPoint_Measure_CLA' 'NNDataPoint_VOIs'}

%%% ¡prop!
MODEL (result, net) is a trained neural network model.
%%%% ¡calculate!
inputs = cell2mat(nn.get('INPUTS', nn.get('D')));
targets = nn.get('TARGET_CLASSES', nn.get('D'));
voi_data = cell2mat(nn.get('VOI_INPUT',nn.get('D_VOIS')));

if isempty(inputs) || isempty(targets)
    value = network();
else
    number_features = size(inputs, 2);
    number_vois = size(voi_data, 2); % Number of additional VOIs
    number_classes = numel(categories(categorical(targets)));
    targets = categorical(targets);
    % Define the primary feature input
    feature_input = featureInputLayer(number_features, 'Name', 'Feature_Input');
    
    % Define VOI input
    voi_input = featureInputLayer(number_vois, 'Name', 'VOI_Input');
    
    % Retrieve user-defined layer settings
    layers = nn.get('LAYERS');
    nn_architecture = [feature_input];
    
    for i = 1:length(layers)
        nn_architecture = [nn_architecture
            fullyConnectedLayer(layers(i), 'Name', ['Dense_' num2str(i)])
            batchNormalizationLayer('Name', ['BatchNormalization_' num2str(i)])
            dropoutLayer(0.5, 'Name', ['Dropout_' num2str(i)])
            reluLayer('Name', ['ReLU_' num2str(i)])
        ];
    end
    
    % Concatenation layer
    concatenation_layer = concatenationLayer(1, 2, 'Name', 'Concat');
    
    % Final classification layers after concatenation
    classification_layers = [
        fullyConnectedLayer(number_classes, 'Name', 'Dense_output')
        softmaxLayer('Name', 'Softmax')
        classificationLayer('Name', 'Output')
    ];
    
    % Convert to layerGraph for proper connections
    nn_architecture = layerGraph(nn_architecture);
    nn_architecture = addLayers(nn_architecture, voi_input);
    nn_architecture = addLayers(nn_architecture, concatenation_layer);
    nn_architecture = addLayers(nn_architecture, classification_layers);
    
    % Connect layers properly
    nn_architecture = connectLayers(nn_architecture, ['ReLU_' num2str(length(layers))], 'Concat/in1'); % Features -> Concat
    nn_architecture = connectLayers(nn_architecture, 'VOI_Input', 'Concat/in2'); % VOI Input -> Concat
    nn_architecture = connectLayers(nn_architecture, 'Concat', 'Dense_output'); % Concat -> Final classification

    % Specify training options
    options = trainingOptions(nn.get('SOLVER'), ...
        'MiniBatchSize', nn.get('BATCH'), ...
        'MaxEpochs', nn.get('EPOCHS'), ...
        'Shuffle', nn.get('SHUFFLE'), ...
        'Plots', nn.get('PLOT_TRAINING'), ...
        'Verbose', nn.get('VERBOSE'));

    % Create ArrayDatastore for each input
    dsFeatures = arrayDatastore(inputs, 'IterationDimension', 1);
    dsVOI      = arrayDatastore(voi_data, 'IterationDimension', 1);
    dsTargets  = arrayDatastore(targets, 'IterationDimension', 1);

    % Combine the two datastores
    combinedDS = combine(dsFeatures, dsVOI, dsTargets);
    combinedTrainDS = transform(combinedDS, @(data) {data{1}', data{2}', data{3}});

    % Train the neural network
    value = trainNetwork(combinedTrainDS, nn_architecture, options);
end

%%% ¡prop!
PREDICT (query, cell) returns the predictions of the trained neural network for a dataset pair (D and D_VOIs).
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
d = varargin{1}; % Primary dataset
d_vois = varargin{2}; % VOI dataset
inputs = cell2mat(nn.get('INPUTS', d));
voi_data = cell2mat(nn.get('VOI_INPUT', d_vois));
if isempty(inputs) || isempty(voi_data)
    value = {};
else
    dsFeatures = arrayDatastore(inputs, 'IterationDimension', 1);
    dsVOI = arrayDatastore(voi_data, 'IterationDimension', 1);
    combinedDS = combine(dsFeatures, dsVOI);
    combinedPredDS = transform(combinedDS, @(data) {data{1}', data{2}'});
    net = nn.get('MODEL');
    value = {net.predict(combinedPredDS)};
end


%% ¡props!

%%% ¡prop!
VOI_SELECTION (parameter, stringlist) defines which VOIs should be included in the analysis.
%%%% ¡default!
{'Age', 'Sex','Education'}; % Example: Default selected VOIs

%%% ¡prop!
D_VOIs (data, item) is the voi dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
%%%% ¡settings!
'NNDataset'

%%% ¡prop!
VOI_INPUT (query, cell) extracts VOI values based on the selection list.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
d = varargin{1};
dp_dict = d.get('DP_DICT');
it_list = dp_dict.get('IT_LIST');
num_subjects = length(it_list);
selected_vois = nn.get('VOI_SELECTION'); % Get user-defined VOI list
voi_data = zeros(num_subjects, length(selected_vois)); % Preallocate as a numerical matrix

for subj_idx = 1:num_subjects
    sub = it_list{subj_idx}; % Get subject data
    voi_dict = sub.get('VOI_DICT');
    
    selected_values = nan(1, length(selected_vois)); % Initialize with NaNs to handle missing VOIs
    
    for voi_idx = 1:voi_dict.get('LENGTH')
        voi = voi_dict.get('IT', voi_idx);
        voi_id = voi.get('ID'); % Extract VOI ID
        
        % If the VOI ID is in the selected list, store its value
        match_idx = find(strcmp(selected_vois, voi_id), 1);
        if ~isempty(match_idx)
            selected_values(match_idx) = voi.get('V'); % Assign value to the corresponding column
        end
    end
    
    voi_data(subj_idx, :) = selected_values; % Store extracted VOI values
end

value = {voi_data};


%% ¡tests!

%%% ¡test!
%%%% ¡name!
train the MLPClassifier VOI with example data
%%%% ¡code!
% Step 1: Ensure example data exists
data_dir = [fileparts(which('NNDataPoint_VOIs')) filesep 'Example data NN CLA CON XLS VOIs'];
if ~isfile([data_dir filesep 'atlas.xlsx'])
    create_data_NN_CLA_CON_XLS_VOIs(data_dir); % Generate example files with VOIs
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

% Check if the number of fully connected layers matches the specified LAYERS property
trained_model = nn.get('MODEL');
assert(length(nn.get('LAYERS')) == sum(contains({trained_model.Layers.Name}, 'Dense')) - 1, ...
    [BRAPH2.STR ':NNClassifierMLP_VOIs:' BRAPH2.FAIL_TEST], ...
    'NNClassifierMLP_VOIs does not construct the layers correctly. The number of hidden layers should match the specified LAYERS property.' ...
);
