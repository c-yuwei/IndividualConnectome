%% ¡header!
RegressOutCovariatesMultipleGroups < ConcreteElement (roc, Regress Out Covariates for Multiple Groups) performs regression to remove covariates from data for multiple groups.

%%% ¡description!
RegressOutCovariatesMultipleGroups (roc) loads multiple groups, extracts all subjects after matching their IDs across groups, performs regression to remove
age, sex, and education as covariates, and saves the residuals back to the respective subjects in each group.

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of Regress Out Covariates for Multiple Groups.
%%%% ¡default!
'RegressOutCovariatesMultipleGroups'

%%% ¡prop!
NAME (constant, string) is the name of the Regress Out Covariates for Multiple Groups.
%%%% ¡default!
'Regress Out Covariates for Multiple Groups'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Regress Out Covariates for Multiple Groups.
%%%% ¡default!
'A Regress Out Covariates for Multiple Groups (RegressOutCovariatesMultipleGroups) performs regression to remove covariates like age, sex, and education from data in multiple groups.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Regress Out Covariates for Multiple Groups.
%%%% ¡settings!
'RegressOutCovariatesMultipleGroups'

%%% ¡prop!
ID (data, string) is a few-letter code for the Regress Out Covariates for Multiple Groups.
%%%% ¡default!
'RegressOutCovariatesMultipleGroups ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Regress Out Covariates for Multiple Groups.
%%%% ¡default!
'Regress Out Covariates for Multiple Groups label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Regress Out Covariates for Multiple Groups.
%%%% ¡default!
'Regress Out Covariates for Multiple Groups notes'

%% ¡props!

%%% ¡prop!
GR_LIST (data, idict) is the list of groups containing the data to regress.
%%%% ¡default!
{}

%%% ¡prop!
COVARIATE_LIST (data, idict) is the list of groups containing the covariates (age, sex, education).
%%%% ¡default!
{}

%%% ¡prop!
RESIDUALS_LIST (result, cell) contains the residuals for all groups after regressing out covariates.
%%%% ¡calculate!
% Ensure GR_LIST and COVARIATE_LIST have the same length
assert(length(roc.get('GR_LIST')) == length(roc.get('COVARIATE_LIST')), 'GR_LIST and COVARIATE_LIST must have the same length.');

% Collect all subjects across groups and match IDs
all_subjects = {};
id_subject_map = containers.Map(); % Map to track subjects by ID

% Collect subjects by matching IDs across groups
for g = 1:length(roc.get('GR_LIST'))
    group_subjects = roc.get('GR_LIST').get('SUB_DICT').getItems();
    covariate_subjects = roc.get('COVARIATE_LIST').get('SUB_DICT').getItems();
    
    assert(length(group_subjects) == length(covariate_subjects), 'Data and covariate groups must have the same number of subjects.');
    
    for s = 1:length(group_subjects)
        subject_id = group_subjects{s}.get('ID');
        covariate_id = covariate_subjects{s}.get('ID');
        
        assert(strcmp(subject_id, covariate_id), 'Subject IDs in data and covariate groups must match.');
        
        if ~isKey(id_subject_map, subject_id)
            id_subject_map(subject_id) = struct('data', group_subjects{s}, 'covariates', covariate_subjects{s});
            all_subjects = [all_subjects; struct('data', group_subjects{s}, 'covariates', covariate_subjects{s})];
        end
    end
end

% Extract covariates and data
n_subjects = length(all_subjects);
covariates = cell2mat(cellfun(@(x) x.covariates.get('VOIS'), all_subjects, 'UniformOutput', false));
data = cell2mat(cellfun(@(x) x.data.get('DATA'), all_subjects, 'UniformOutput', false));

% Add constant term for regression
X = [ones(n_subjects, 1), covariates];

% Perform regression for each column of the data
residuals = zeros(size(data));
for i = 1:size(data, 2)
    b = regress(data(:, i), X); % Solve regression
    residuals(:, i) = data(:, i) - X * b; % Compute residuals
end

% Save residuals back to subjects
for i = 1:n_subjects
    all_subjects{i}.data.set('DATA', residuals(i, :));
end

% Split residuals back into groups
residuals_list = cell(length(roc.get('GR_LIST')), 1);
counter = 1;
for g = 1:length(roc.get('GR_LIST'))
    group_subjects = roc.get('GR_LIST').get('SUB_DICT').getItems();
    n_group_subjects = length(group_subjects);
    residuals_list{g} = residuals(counter:(counter + n_group_subjects - 1), :);
    counter = counter + n_group_subjects;
end

value = residuals_list;

%%% ¡tests!

%%% ¡test!
%%%% ¡name!
Test RegressOutCovariatesMultipleGroups
%%%% ¡code!
% Create example data for multiple groups
n_groups = 3;
n_subjects_per_group = 5;

covariates = { ...
    [20, 1, 12; 30, 0, 16; 25, 1, 14; 28, 0, 15; 22, 1, 13], ...
    [22, 0, 14; 24, 1, 16; 27, 0, 13; 26, 1, 15; 23, 0, 12], ...
    [29, 1, 17; 31, 0, 19; 28, 1, 18; 30, 0, 16; 25, 1, 15] ...
};

data = { ...
    rand(n_subjects_per_group, 3) + covariates{1}, ...
    rand(n_subjects_per_group, 3) + covariates{2}, ...
    rand(n_subjects_per_group, 3) + covariates{3} ...
};

ids = {'ID1', 'ID2', 'ID3', 'ID4', 'ID5'};
groups_data = cell(n_groups, 1);
groups_covariates = cell(n_groups, 1);
for g = 1:n_groups
    subjects_data = cell(n_subjects_per_group, 1);
    subjects_covariates = cell(n_subjects_per_group, 1);
    for i = 1:n_subjects_per_group
        subjects_data{i} = SubjectCON('ID', ids{i}, 'DATA', data{g}(i, :));
        subjects_covariates{i} = SubjectCON('ID', ids{i}, 'VOIS', covariates{g}(i, :));
    end
    groups_data{g} = Group('SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON', 'IT_LIST', subjects_data));
    groups_covariates{g} = Group('SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON', 'IT_LIST', subjects_covariates));
end

% Run regression element
roc = RegressOutCovariatesMultipleGroups('GR_LIST', groups_data, 'COVARIATE_LIST', groups_covariates);
residuals_list = roc.get('RESIDUALS_LIST');

% Verify residuals
assert(~isempty(residuals_list), 'Residuals list should not be empty.');
assert(length(residuals_list) == n_groups, 'Residuals list should match the number of groups.');
for g = 1:n_groups
    assert(all(size(residuals_list{g}) == size(data{g})), 'Residuals should have the same size as data.');
end
