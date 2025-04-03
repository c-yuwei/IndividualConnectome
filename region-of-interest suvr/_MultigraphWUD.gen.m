%% ¡header!
MultiGraphWUD < GraphWU (g, weighted undirected graph with density-based thresholding) is a weighted undirected graph.

%%% ¡description!
MultiGraphWUD is a weighted undirected graph where the adjacency matrix is thresholded based on a specified density.
There are no connections between layers.

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiGraphWUD.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
MultiGraphWUD.LABEL
%%%% ¡title!
Graph Name

%%% ¡prop!
%%%% ¡id!
MultiGraphWUD.NODELABELS
%%%% ¡title!
Node Labels

%%% ¡prop!
%%%% ¡id!
MultiGraphWUD.B
%%%% ¡title!
Input Adjacency Matrix

%%% ¡prop!
%%%% ¡id!
MultiGraphWUD.DENSITIES
%%%% ¡title!
Desired Density

%%% ¡prop!
%%%% ¡id!
MultiGraphWUD.A
%%%% ¡title!
Thresholded Adjacency Matrix

%%% ¡prop!
%%%% ¡id!
MultiGraphWUD.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
MultiGraphWUD.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
MultiGraphWUD.M_DICT
%%%% ¡title!
Graph Measures

%%% ¡prop!
%%%% ¡id!
MultiGraphWUD.NOTES
%%%% ¡title!
Graph Notes

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the weighted undirected graph with fixed densities.
%%%% ¡default!
'MultiGraphWUD'

%%% ¡prop!
NAME (constant, string) is the name of the weighted undirected graph with fixed densities.
%%%% ¡default!
'Graph Weighted Undirected with Density'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the weighted undirected graph with fixed densities.
%%%% ¡default!
'MultiGraphWUD is a weighted undirected graph with density-based thresholding,Edges are undirected and weighted, with weights below a threshold,(determined by the desired density) set to zero, and stronger weights unchanged , The adjacency matrix is symmetric.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the weighted undirected graph with fixed densities.
%%%% ¡settings!
'MultiGraphWUD'

%%% ¡prop!
ID (data, string) is a few-letter code for the weighted undirected graph with fixed densities.
%%%% ¡default!
'MultiGraphWUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the weighted undirected graph with fixed densities.
%%%% ¡default!
'MultiGraphWUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the weighted undirected graph with fixed densities.
%%%% ¡default!
'MultiGraphWUD notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type  __Graph.MULTIGRAPH__.
%%%% ¡default!
Graph.MULTIGRAPH

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type  __Graph.WEIGHTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.WEIGHTED * ones(layernumber);

%%% ¡prop!
DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.UNDIRECTED * ones(layernumber);

%%% ¡prop!
SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type  __Graph.NONSELFCONNECTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.NONSELFCONNECTED * ones(layernumber);


%%% ¡prop!
NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.NONNEGATIVE * ones(layernumber);


%%% ¡prop!
A (result, cell) is the cell array with the symmetric binary adjacency matrices of the binary undirected multigraph.
%%%% ¡calculate!
A_WU = calculateValue@GraphWU(g, prop);

densities = g.get('DENSITIES');
A = cell(length(densities));

if ~isempty(cell2mat(A_WU))
    for i = 1:1:length(densities)
        density = densities(i);
        sorted_vector = sort(A_WU(~eye(size(A_WU))));
        index = round(length(sorted_vector) * (100 - density) / 100);
        threshold = sorted_vector(index);
        A_WU(A_WU < threshold) = 0;
        A{i, i} = dediagonalize(cell2mat(A_WU));
    end
end
if g.get('RANDOMIZE')
    A = g.get('RANDOMIZATION', A);
end
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultigraphWUD.A, ...
    'TABLE_HEIGHT', s(40), ...
    'XYSLIDERLOCK', true, ... 
    'XSLIDERSHOW', false, ...
    'YSLIDERSHOW', true, ...
    'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
    'YSLIDERWIDTH', s(5), ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
PARTITIONS (result, rvector) returns the number of layers (1) for each partition (density) of the graph.
%%%% ¡calculate!
l = g.get('LAYERNUMBER');
densities = g.get('DENSITIES');
value = ones(1, length(densities)) * l / length(densities);

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
    alayerlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
end
value = alayerlabels;

%%% ¡prop!
APARTITIONLABELS (query, stringlist) returns the partition (density) labels for A.
%%%% ¡calculate!
apartitionlabels = g.get('PARTITIONLABELS');
if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('DENSITIES')) % ensures that it's not unecessarily calculated
    apartitionlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
end
value = apartitionlabels;

%%% ¡prop!
ALAYERTICKS (query, rvector) returns the layer tick values.
%%%% ¡calculate!
alayerticks = g.get('LAYERTICKS');
if length(alayerticks) ~= (g.get('LAYERNUMBER') / length(g.get('DENSITIES'))) % ensures that it's not unecessarily calculated
    l = g.get('LAYERNUMBER');
    densities = g.get('DENSITIES');
    alayerticks = [1:1:(l / length(densities))];
end
value = alayerticks;

%%% ¡prop!
APARTITIONTICKS (query, rvector) returns the partition (density) ticks for A.
%%%% ¡calculate!
value = g.get('DENSITIES');

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('MultigraphWUD')

%%% ¡prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡default!
5

%%% ¡prop!
RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
%%%% ¡calculate!
rng(g.get('RANDOM_SEED'), 'twister')

if isempty(varargin)
    value = {};
    return
end

A = varargin{1};
attempts_per_edge = g.get('ATTEMPTSPEREDGE');

for i = 1:length(A)
    tmp_a = A{i,i};

    random_g = GraphWU();
    random_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
    random_A = random_g.get('RANDOMIZATION', {tmp_a});
    A{i, i} = random_A;
end
value = A;

%% ¡props!

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', MultigraphWUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[MultigraphWUD.PFGA MultigraphWUD.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Empty
%%%% ¡probability!
.01
%%%% ¡code!

% 1
B = [];
g = MultigraphWUD('B', B, 'DENSITIES', []);

g.get('A_CHECK')

A = {};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultigraphWUD:' BRAPH2.FAIL_TEST], ...
    'MultigraphWUD is not constructing well.')

% 2
B = [];
g = MultigraphWUD('B', B, 'DENSITIES', [0 55 100]);

g.get('A_CHECK')

A = g.get('A');
assert(isequal(A{1, 1}, []) && isequal(A{2, 2}, []) && isequal(A{3, 3}, []), ...
    [BRAPH2.STR ':MultigraphWUD:' BRAPH2.FAIL_TEST], ...
    'MultigraphWUD is not constructing well.')

% 3
B = [
     0 .1 .2 .3 .4
    .1  0 .5 .6 .7
    .2 .5  0 .8 .9
    .3 .6 .8  0  1
    .4 .7 .9  1  0
    ];
g = MultigraphWUD('B', B, 'DENSITIES', []);

g.get('A_CHECK')
A = {};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultigraphWUD:' BRAPH2.FAIL_TEST], ...
    'MultigraphWUD is not constructing well.')

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B = [
     0 .1 .2 .3 .4
    .1  0 .5 .6 .7
    .2 .5  0 .8 .9
    .3 .6 .8  0  1
    .4 .7 .9  1  0
    ];
g = MultigraphWUD('B', B, 'DENSITIES', [0 55 100]);

g.get('A_CHECK')

A = g.get('A');
assert(isequal( ...
    A{1, 1}, ...
    [
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    ]) ...
    && ...
    isequal( ...
    A{2, 2}, ...
    [
    0 0 0 0 0
    0 0 0 .6 .7
    0 0 0 .8 .9
    0 .6 .8 0 1
    0 .7 .9 1 0
    ]) ...
    && ...
    isequal( ...
    A{3, 3}, ...
    [
     0 .1 .2 .3 .4
    .1  0 .5 .6 .7
    .2 .5  0 .8 .9
    .3 .6 .8  0  1
    .4 .7 .9  1  0
    ]), ...
    [BRAPH2.STR ':MultigraphWUD:' BRAPH2.FAIL_TEST], ...
    'MultigraphWUD is not constructing well.')

%%% ¡test!
%%%% ¡name!
Randomize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = randn(10);
g = MultigraphWUD('B', B, 'DENSITIES', [0 55 100]);

g.set('RANDOMIZE', true);
g.set('ATTEMPTSPEREDGE', 4);
g.get('A_CHECK')

A = g.get('A');

assert(isequal(size(A{1}), size(B)), ...
    [BRAPH2.STR ':MultigraphWUD:' BRAPH2.FAIL_TEST], ...
    'MultigraphWUD Randomize is not functioning well.')

g2 = MultigraphWUD('B', B, 'DENSITIES', [0 55 100]);
g2.set('RANDOMIZE', false);
g2.set('ATTEMPTSPEREDGE', 4);
g2.get('A_CHECK')

A2 = g2.get('A');
random_A = g2.get('RANDOMIZATION', A2);

for i = 1:length(A2)
    if all(A2{i, i}==0, "all") %if all nodes are zero, the random matrix is also all zeros
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':MultigraphWUD:' BRAPH2.FAIL_TEST], ...
            'MultigraphWUD Randomize is not functioning well.')
    elseif isequal((length(A2{i, i}).^2)- length(A2{i, i}), sum(A2{i, i}==1, "all")) %if all nodes (except diagonal) are one, the random matrix is the same as original
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':MultigraphWUD:' BRAPH2.FAIL_TEST], ...
            'MultigraphWUD Randomize is not functioning well.')
    else
%         assert(~isequal(A2{i, i}, random_A{i, i}), ...
%             [BRAPH2.STR ':MultigraphWUD:' BRAPH2.FAIL_TEST], ...
%             'MultigraphWUD Randomize is not functioning well.')
    end

    assert(isequal(numel(find(A2{i, i})), numel(find(random_A{i, i}))), ... % check same number of nodes
        [BRAPH2.STR ':MultigraphWUD:' BRAPH2.FAIL_TEST], ...
        'MultigraphWUD Randomize is not functioning well.')
        
    assert(issymmetric(random_A{i, i}), ... % check symmetry 
    [BRAPH2.STR ':MultigraphWUD:' BRAPH2.FAIL_TEST], ...
    'MultigraphWUD Randomize is not functioning well.')
end