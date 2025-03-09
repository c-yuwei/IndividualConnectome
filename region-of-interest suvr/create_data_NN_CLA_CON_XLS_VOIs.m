function create_data_NN_CLA_CON_XLS(data_dir, random_seed)
%CREATE_DATA_NN_CLA_CON_XLS creates connectivity data with VOIs for neural network classification analysis
%
% CREATE_DATA_NN_CLA_CON_XLS() creates data in the default folder 'Example data NN CLA CON XLS'.
%
% CREATE_DATA_NN_CLA_CON_XLS(DATA_DIR) creates data in the specified DATA_DIR folder.
%
% CREATE_DATA_NN_CLA_CON_XLS(DATA_DIR, RANDOM_SEED) creates data with a specified random seed.

if nargin < 1
    data_dir = [fileparts(which('NNClassifierMLP_VOIs')) filesep 'Example data NN CLA CON XLS VOIs'];
end

if nargin < 2
    random_seed = 'default';
end

if ~isdir(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasXLS('BA', ba, 'FILE', [data_dir filesep() 'atlas.xlsx']);
    ex_ba.get('SAVE')
    N = ba.get('BR_DICT').get('LENGTH');

    % Save RNG settings
    rng_settings_ = rng(); rng(random_seed)

    sex_options = {'Female' 'Male'};

    % Connectivity parameters (identical for both groups)
    K = 2; % Mean degree
    beta = 0.3; % Rewiring probability

    % Group 1: Connectivity with specific VOIs
    gr1_name = 'CON_Group_1_XLS';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir(gr1_dir);
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
    ];
    for i = 1:100 % 10 subjects in Group 1
        sub_id = ['SubjectCON_' num2str(i)];
        h = WattsStrogatz(N, K, beta);
        A = full(adjacency(h)); A(1:N+1:end) = 0; % Remove self-loops
        A = max(A, A'); % Symmetrize
        writetable(array2table(A), [gr1_dir filesep() sub_id '.xlsx'], 'WriteVariableNames', false)
        % VOIs: Group 1 has younger ages and more females
        age = randi([20, 40]); % Younger age range
        sex = sex_options{1}; % Female
        vois1 = [vois1; {sub_id, age, sex}];
    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.xlsx'], 'WriteVariableNames', false)

    % Group 2: Identical connectivity but different VOIs
    gr2_name = 'CON_Group_2_XLS';
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir(gr2_dir);
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
    ];
    for i = 101:200 % 10 subjects in Group 2
        sub_id = ['SubjectCON_' num2str(i)];
        h = WattsStrogatz(N, K, beta); % Same connectivity parameters
        A = full(adjacency(h)); A(1:N+1:end) = 0;
        A = max(A, A');
        writetable(array2table(A), [gr2_dir filesep() sub_id '.xlsx'], 'WriteVariableNames', false)
        % VOIs: Group 2 has older ages and more males
        age = randi([50, 70]); % Older age range
        sex = sex_options{2}; % Male
        vois2 = [vois2; {sub_id, age, sex}];
    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.xlsx'], 'WriteVariableNames', false)

    % Reset RNG
    rng(rng_settings_)
end

%%% ¡test_functions!
function h = WattsStrogatz(N,K,beta)
% H = WattsStrogatz(N,K,beta) returns a Watts-Strogatz model graph with N
% nodes, N*K edges, mean node degree 2*K, and rewiring probability beta.
%
% beta = 0 is a ring lattice, and beta = 1 is a random graph.

% Connect each node to its K next and previous neighbors. This constructs
% indices for a ring lattice.
s = repelem((1:N)',1,K);
t = s + repmat(1:K,N,1);
t = mod(t-1,N)+1;

% Rewire the target node of each edge with probability beta
for source=1:N
    switchEdge = rand(K, 1) < beta;
    
    newTargets = rand(N, 1);
    newTargets(source) = 0;
    newTargets(s(t==source)) = 0;
    newTargets(t(source, ~switchEdge)) = 0;
    
    [~, ind] = sort(newTargets, 'descend');
    t(source, switchEdge) = ind(1:nnz(switchEdge));
end

h = graph(s,t);
end
end