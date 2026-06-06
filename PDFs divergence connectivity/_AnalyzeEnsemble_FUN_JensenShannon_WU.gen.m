%% ¡header!
AnalyzeEnsemble_FUN_JensenShannon_WU < AnalyzeEnsemble (a, graph analysis with functional PDF data) is an ensemble-based graph analysis using Jensen-Shannon similarity.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_FUN_JensenShannon_WU) analyzes functional PDF data using weighted undirected graphs. For each subject, regional probability density functions stored in SubjectFUN are compared pairwise using Jensen-Shannon divergence, and the individual connectivity matrix is constructed as one minus the normalized Jensen-Shannon divergence.

%%% ¡seealso!
AnalyzeEnsemble_FUN_WU, SubjectFUN, GraphWU, ConverterNeuroimaging2PDFs

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_JensenShannon_WU.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_JensenShannon_WU.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_JensenShannon_WU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_JensenShannon_WU.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_JensenShannon_WU.GRAPH_TEMPLATE
%%%% ¡title!
GRAPH & MEASURE PARAMETERS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_JensenShannon_WU.ME_DICT
%%%% ¡title!
Group-averaged MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_JensenShannon_WU.G_DICT
%%%% ¡title!
Individual GRAPHS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_JensenShannon_WU.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ensemble-based graph analysis with functional PDF data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_JensenShannon_WU'

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with functional PDF data.
%%%% ¡default!
'Functional Jensen-Shannon Weighted Undirected Analyze Ensemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with functional PDF data.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_FUN_JensenShannon_WU) analyzes functional PDF data using weighted undirected graphs constructed from Jensen-Shannon similarity.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with functional PDF data.
%%%% ¡settings!
'AnalyzeEnsemble_FUN_JensenShannon_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with functional PDF data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_JensenShannon_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with functional PDF data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_JensenShannon_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with functional PDF data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_JensenShannon_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'GraphWU'

%%% ¡prop!
G_DICT (result, idict) is the graph (GraphWU) ensemble obtained from Jensen-Shannon similarity.
%%%% ¡settings!
'GraphWU'
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');

gr = a.get('GR');
sub_dict = gr.get('SUB_DICT');
subject_number = sub_dict.get('LENGTH');

wb = braph2waitbar( ...
    a.get('WAITBAR'), ...
    0, ...
    'Building Jensen-Shannon individual connectivity matrices ...' ...
    );

for sub_i = 1:subject_number
    sub = sub_dict.get('IT', sub_i);
    pdf_data = sub.getr('FUN');

    A = a.get('JENSEN_SHANNON_SIMILARITY_MATRIX', pdf_data);

    braph2waitbar( ...
        wb, ...
        sub_i / subject_number, ...
        ['Creating graph for subject ' num2str(sub_i) ' of ' num2str(subject_number) ' ...'] ...
        )

    g = GraphWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ...
        'NODELABELS', sub.get('BA').get('BR_DICT').get('KEYS') ...
        );

    g_dict.get('ADD', g)
end

if ~isa(a.get('GRAPH_TEMPLATE'), 'NoValue')
    for i = 1:g_dict.get('LENGTH')
        g_dict.get('IT', i).set('TEMPLATE', a.get('GRAPH_TEMPLATE'))
    end
end

braph2waitbar(wb, 'close')

value = g_dict;

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.

%% ¡props!

%%% ¡prop!
JENSEN_SHANNON_SIMILARITY_MATRIX (query, matrix) calculates the Jensen-Shannon similarity matrix from regional PDFs.
%%%% ¡calculate!
pdf_data = varargin{1};

num_rois = size(pdf_data, 2);
A = eye(num_rois);

for i = 1:num_rois
    p = pdf_data(:, i);

    for j = i + 1:num_rois
        q = pdf_data(:, j);

        similarity = a.get('JENSEN_SHANNON_SIMILARITY', p, q);

        A(i, j) = similarity;
        A(j, i) = similarity;
    end
end

value = A;

%%% ¡prop!
JENSEN_SHANNON_SIMILARITY (query, scalar) calculates one minus the normalized Jensen-Shannon divergence between two PDFs.
%%%% ¡calculate!
p = varargin{1};
q = varargin{2};

p = double(p(:));
q = double(q(:));

% Remove invalid values.
p(isnan(p) | isinf(p)) = 0;
q(isnan(q) | isinf(q)) = 0;

% Ensure non-negative distributions.
p(p < 0) = 0;
q(q < 0) = 0;

if sum(p) == 0 || sum(q) == 0
    value = 0;
    return
end

% Treat sampled PDF vectors as discrete probability distributions.
p = p / sum(p);
q = q / sum(q);

% Numerical safety for logarithms.
p = p + eps;
q = q + eps;

p = p / sum(p);
q = q / sum(q);

m = 0.5 * (p + q);

kl_pm = sum(p .* log(p ./ m));
kl_qm = sum(q .* log(q ./ m));

js_divergence = 0.5 * (kl_pm + kl_qm);

% With natural logarithm, Jensen-Shannon divergence is bounded by log(2).
% Normalize to [0, 1].
js_divergence = js_divergence / log(2);

% Numerical safety.
js_divergence = min(max(js_divergence, 0), 1);

% Connectivity strength: higher value means more similar PDFs.
value = 1 - js_divergence;

%% ¡tests!

%%% ¡excluded_props!
[AnalyzeEnsemble_FUN_JensenShannon_WU.TEMPLATE AnalyzeEnsemble_FUN_JensenShannon_WU.GRAPH_TEMPLATE AnalyzeEnsemble_FUN_JensenShannon_WU.JENSEN_SHANNON_SIMILARITY_MATRIX AnalyzeEnsemble_FUN_JensenShannon_WU.JENSEN_SHANNON_SIMILARITY]

%%% ¡test!
%%%% ¡name!
Jensen-Shannon similarity is one for identical PDFs
%%%% ¡probability!
.01
%%%% ¡code!
a = AnalyzeEnsemble_FUN_JensenShannon_WU();

p = [0.1 0.2 0.4 0.2 0.1]';
q = p;

similarity = a.get('JENSEN_SHANNON_SIMILARITY', p, q);

assert(abs(similarity - 1) < 1e-12, ...
    'Jensen-Shannon similarity should be 1 for identical PDFs.')

%%% ¡test!
%%%% ¡name!
Jensen-Shannon similarity is symmetric
%%%% ¡probability!
.01
%%%% ¡code!
a = AnalyzeEnsemble_FUN_JensenShannon_WU();

p = [0.1 0.2 0.4 0.2 0.1]';
q = [0.4 0.2 0.1 0.2 0.1]';

similarity_pq = a.get('JENSEN_SHANNON_SIMILARITY', p, q);
similarity_qp = a.get('JENSEN_SHANNON_SIMILARITY', q, p);

assert(abs(similarity_pq - similarity_qp) < 1e-12, ...
    'Jensen-Shannon similarity should be symmetric.')

%%% ¡test!
%%%% ¡name!
Jensen-Shannon similarity matrix from PDF data
%%%% ¡probability!
.01
%%%% ¡code!
a = AnalyzeEnsemble_FUN_JensenShannon_WU();

pdf_data = [ ...
    0.1 0.4 0.1
    0.2 0.3 0.1
    0.4 0.2 0.6
    0.2 0.1 0.1
    0.1 0.0 0.1 ...
    ];

A = a.get('JENSEN_SHANNON_SIMILARITY_MATRIX', pdf_data);

assert(isequal(size(A), [3 3]), ...
    'The Jensen-Shannon similarity matrix should be 3-by-3.')

assert(all(abs(diag(A) - 1) < 1e-12), ...
    'The diagonal of the Jensen-Shannon similarity matrix should be 1.')

assert(max(abs(A - A'), [], 'all') < 1e-12, ...
    'The Jensen-Shannon similarity matrix should be symmetric.')

assert(all(A(:) >= 0) && all(A(:) <= 1), ...
    'The Jensen-Shannon similarity values should be in the range [0, 1].')

%%% ¡test!
%%%% ¡name!
Graph construction from SubjectFUN PDFs
%%%% ¡probability!
.01
%%%% ¡code!
ba = BrainAtlas( ...
    'BR_DICT', IndexedDictionary( ...
        'IT_CLASS', 'BrainRegion', ...
        'IT_LIST', { ...
            BrainRegion('ID', 'BR1'), ...
            BrainRegion('ID', 'BR2'), ...
            BrainRegion('ID', 'BR3') ...
            } ...
        ) ...
    );

sub = SubjectFUN( ...
    'ID', 'sub-0001', ...
    'BA', ba, ...
    'FUN', [ ...
        0.1 0.4 0.1
        0.2 0.3 0.1
        0.4 0.2 0.6
        0.2 0.1 0.1
        0.1 0.0 0.1 ...
        ] ...
    );

gr = Group( ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary( ...
        'IT_CLASS', 'SubjectFUN', ...
        'IT_LIST', {sub} ...
        ) ...
    );

a = AnalyzeEnsemble_FUN_JensenShannon_WU( ...
    'GR', gr, ...
    'WAITBAR', false ...
    );

g_dict = a.get('G_DICT');

assert(isequal(g_dict.get('LENGTH'), 1), ...
    'The graph dictionary should contain one graph.')

g = g_dict.get('IT', 1);
A = g.get('A');

if iscell(A)
    A = A{1};
end

assert(isequal(size(A), [3 3]), ...
    'The graph adjacency matrix should be 3-by-3.')

assert(all(abs(diag(A) - 1) < 1e-12), ...
    'The diagonal of the graph adjacency matrix should be 1.')

assert(max(abs(A - A'), [], 'all') < 1e-12, ...
    'The graph adjacency matrix should be symmetric.')

assert(all(A(:) >= 0) && all(A(:) <= 1), ...
    'The graph adjacency values should be in the range [0, 1].')
