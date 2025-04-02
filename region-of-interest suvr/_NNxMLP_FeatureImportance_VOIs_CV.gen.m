%% ¡header!
NNxMLP_FeatureImportance_VOIs_CV < NNxMLP_FeatureImportance_CV (nnficv, neural network feature importace for multi-layer perceptron) provides the importance of features across all folds for multi-layer perceptron (MLP) using shuffled feature method.

%%% ¡description!
Neural Network Feature Importance for Multi-Layer Perceptron with Cross-Validation (NNxMLP_FeatureImportance_VOIs_CV)
 assesses the importance of features across all folds by measuring the increase in model error when the feature values are randomly shuffled. 
The feature importance score for each feature is then averaged across all folds. 
It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, 
 such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.

%%% ¡seealso!
NNxMLP_FeatureImportanceAcrossMeasures_CV, NNClassifierMLP_CrossValidation, NNRegressorMLP_CrossValidation

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.ID
%%%% ¡title!
Feature Importance MLP Cross Validation ID

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.LABEL
%%%% ¡title!
Feature Importance MLP Cross Validation LABEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.NNCV
%%%% ¡title!
Neural Networks Cross Validation

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.FI_TEMPLATE
%%%% ¡title!
Template for Feature Importance Analysis

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.P
%%%% ¡title!
Permutation Number

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.APPLY_BONFERRONI
%%%% ¡title!
Bonferroni Correction ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.APPLY_CONFIDENCE_INTERVALS
%%%% ¡title!
Confidence Interval ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.SIG_LEVEL
%%%% ¡title!
Significant Level

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.RESHAPED_AV_FEATURE_IMPORTANCE
%%%% ¡title!
Feature Importance Score

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_VOIs_CV.FI_LIST
%%%% ¡title!
Feature Importance List

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the neural network feature importance for cross validation.
%%%% ¡default!
'NNxMLP_FeatureImportance_VOIs_CV'

%%% ¡prop!
NAME (constant, string) is the name of the neural network feature importance for cross validation.
%%%% ¡default!
'Feature Importace for Multi-layer Perceptron'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network feature importance for cross validation.
%%%% ¡default!
'Neural Network Feature Importance for Multi-Layer Perceptron with Cross-Validation (NNxMLP_FeatureImportance_VOIs_CV) assesses the importance of features across all folds by measuring the increase in model error when the feature values are randomly shuffled. The feature importance score for each feature is then averaged across all folds. It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network feature importance for cross validation.
%%%% ¡settings!
'NNxMLP_FeatureImportance_VOIs_CV'

%%% ¡prop!
ID (data, string) is a few-letter code of the neural network feature importance for cross validation.
%%%% ¡default!
'NNxMLP_FeatureImportance_VOIs_CV ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network feature importance for cross validation.
%%%% ¡default!
'NNxMLP_FeatureImportance_VOIs_CV label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network feature importance for cross validation.
%%%% ¡default!
'NNxMLP_FeatureImportance_VOIs_CV notes'

%%% ¡prop!
FI_LIST (result, itemlist) contains a list of feature importance analysis for all folds.
%%%% ¡settings!
'NNxMLP_FeatureImportance_VOIs'
%%%% ¡calculate!
if ~isa(nnficv.getr('FI_TEMPLATE'), 'NoValue')
    fi_template = nnficv.get('FI_TEMPLATE');
else
    fi_template = NNxMLP_FeatureImportance_VOIs( ...
        'P', nnficv.get('P'), ...
        'APPLY_BONFERRONI', nnficv.get('APPLY_BONFERRONI'), ...
        'APPLY_CONFIDENCE_INTERVALS', nnficv.get('APPLY_CONFIDENCE_INTERVALS'), ...
        'SIG_LEVEL', nnficv.get('SIG_LEVEL'));
end

d_list = nnficv.get('NNCV').get('D_LIST');
dvois_list = nnficv.get('NNCV').get('D_VOIS_LIST');
nn_list = nnficv.get('NNCV').get('NN_LIST');
fi_list = {};
for i = 1:length(d_list)
    fi = eval(fi_template.get('ELCLASS'));
    d = d_list{i};
    d_vois = dvois_list{i};
    nn = nn_list{i};
    fi.set('TEMPLATE', fi_template, 'D', d, 'D_VOIS', d_vois, 'NN', nn);
    fi_list{i} = fi;
end
value = fi_list;

%% ¡tests!

%%% ¡excluded_props!
[NNxMLP_FeatureImportance_VOIs_CV.FI_TEMPLATE]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
create_data_NN_CLA_ST_XLS() % only creates files if the example folder doesn't already exist

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

% Create a classifier cross-validation
nncv = NNClassifierMLP_CrossValidation_VOIs('D', {d1, d2, d3}, 'KFOLDS', 2);
nncv.get('TRAIN');

% Evaluate the feature importance
fi_template = NNxMLP_FeatureImportance_VOIs('P', 5, 'APPLY_BONFERRONI', true, 'APPLY_CONFIDENCE_INTERVALS', true);
fi_cv = NNxMLP_FeatureImportance_VOIs_CV('NNCV', nncv, 'FI_TEMPLATE', fi_template);
fi_cv_score = fi_cv.get('RESHAPED_AV_FEATURE_IMPORTANCE');
input_dp = it_list1{1}.get('INPUT');

assert(isequal(size(cell2mat(fi_cv_score)), size(cell2mat(input_dp))), ...
	        [BRAPH2.STR ':NNxMLP_FeatureImportance_VOIs_CV:' BRAPH2.FAIL_TEST], ...
	        'NNxMLP_FeatureImportance_VOIs_CV does not have the feature importance score array of the same feature size as the input data.' ...
	        )