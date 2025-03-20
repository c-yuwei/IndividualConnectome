%% ¡header!
NNClassifierMLP_EvaluatorPF_ROC_VOIs < NNClassifierMLP_EvaluatorPF_ROC (pf, panel receiver operating characteristic figure for VOIs) plots a panel of receiver operating characteristic curves for dual-input MLP classifier with VOIs.

%%% ¡description!
The receiver operating characteristic panel for an evaluator of MLP classifier with variables of interest (NNClassifierMLP_EvaluatorPF_ROC_VOIs) manages the functionalities to plot a panel of receiver operating characteristic curves for an NNClassifierMLP_VOIs classifier, using both a primary dataset (D) and a VOI dataset (D_VOIs).

%%% ¡seealso!
NNClassifierMLP_Evaluator_VOIs, NNClassifierMLP_VOIs

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ROC panel for an evaluator of MLP classifier with VOIs.
%%%% ¡default!
'NNClassifierMLP_EvaluatorPF_ROC_VOIs'

%%% ¡prop!
NAME (constant, string) is the name of the ROC panel for an evaluator of MLP classifier with VOIs.
%%%% ¡default!
'ROC Panel for an Evaluator of MLP Classifier with Variables of Interest'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ROC panel for an evaluator of MLP classifier with VOIs.
%%%% ¡default!
'The receiver operating characteristic panel for an evaluator of MLP classifier with variables of interest (NNClassifierMLP_EvaluatorPF_ROC_VOIs) manages the functionalities to plot a panel of receiver operating characteristic curves for an NNClassifierMLP_VOIs classifier, using both a primary dataset (D) and a VOI dataset (D_VOIs).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ROC panel.
%%%% ¡settings!
'NNClassifierMLP_EvaluatorPF_ROC_VOIs'

%%% ¡prop!
ID (data, string) is a few-letter code for the ROC panel.
%%%% ¡default!
'NNClassifierMLP_EvaluatorPF_ROC_VOIs ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ROC panel.
%%%% ¡default!
'NNClassifierMLP_EvaluatorPF_ROC_VOIs label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ROC panel.
%%%% ¡default!
'NNClassifierMLP_EvaluatorPF_ROC_VOIs notes'

%%% ¡prop!
NNE (metadata, item) is the neural network evaluator with VOIs support.
%%%% ¡settings!
'NNClassifierMLP_Evaluator_VOIs'

%%% ¡prop!
X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves using D and D_VOIs.
%%%% ¡postprocessing!
if isa(pf.getr('X_VALUES'), 'NoValue') && ~isa(pf.get('NNE').get('NN').getr('MODEL'), 'NoValue')
    class_names = pf.get('CLASSNAMES');
    d = pf.get('NNE').get('D');
    d_vois = pf.get('NNE').get('D_VOIS');
    predictions = cell2mat(pf.get('NNE').get('NN').get('PREDICT', d, d_vois));
    ground_truth = categorical(pf.get('NNE').get('GROUND_TRUTH'));
    rocNet = rocmetrics(ground_truth, predictions, class_names);
    for i = 1:length(class_names)
        idx_class = strcmp(rocNet.Metrics.ClassName, class_names{i});
        values(i, :) = rocNet.Metrics(idx_class, :).FalsePositiveRate;
    end
    pf.set('X_VALUES', values);
end

%%% ¡prop!
Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves using D and D_VOIs.
%%%% ¡postprocessing!
if isa(pf.getr('Y_VALUES'), 'NoValue') && ~isa(pf.get('NNE').get('NN').getr('MODEL'), 'NoValue')
    class_names = pf.get('CLASSNAMES');
    d = pf.get('NNE').get('D');
    d_vois = pf.get('NNE').get('D_VOIS');
    predictions = cell2mat(pf.get('NNE').get('NN').get('PREDICT', d, d_vois));
    ground_truth = categorical(pf.get('NNE').get('GROUND_TRUTH'));
    rocNet = rocmetrics(ground_truth, predictions, class_names);
    for i = 1:length(class_names)
        idx_class = strcmp(rocNet.Metrics.ClassName, class_names{i});
        values(i, :) = rocNet.Metrics(idx_class, :).TruePositiveRate;
    end
    pf.set('Y_VALUES', values);
end

%% ¡tests!

%%% ¡excluded_props!
[NNClassifierMLP_EvaluatorPF_ROC_VOIs.PARENT NNClassifierMLP_EvaluatorPF_ROC_VOIs.H NNClassifierMLP_EvaluatorPF_ROC_VOIs.ST_POSITION NNClassifierMLP_EvaluatorPF_ROC_VOIs.ST_AXIS NNClassifierMLP_EvaluatorPF_ROC_VOIs.H_ROC NNClassifierMLP_EvaluatorPF_ROC_VOIs.ROC_DICT NNClassifierMLP_EvaluatorPF_ROC_VOIs.ST_TITLE NNClassifierMLP_EvaluatorPF_ROC_VOIs.ST_XLABEL NNClassifierMLP_EvaluatorPF_ROC_VOIs.ST_YLABEL]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':NNClassifierMLP_EvaluatorPF_ROC_VOIs'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':NNClassifierMLP_EvaluatorPF_ROC_VOIs'])