clc;

% Add paths to necessary toolboxes (adjust as needed)
addpath(genpath('/home/hang/GitHub/IndividualConnectome-WithYuwei/braph2individualconnectome'));
addpath(genpath('/home/hang/GitHub/Individual-connectome/group_data/ADNI_DATA'));

% Define the groups and their names for comparison
group_names = {'CN', 'MCI', 'AD', 'CN_pos'};
suvr_groups = {SUVR_gr1, SUVR_gr2, SUVR_gr3, SUVR_gr4}; % For VOI data
conn_groups = {Con_gr1, Con_gr2, Con_gr3, Con_gr4}; % For connectivity data

% Define the pairs for comparison (e.g., CN vs. AD, CN vs. MCI, etc.)
pairs = {
    {'CN', 'AD'}, ...
    {'CN', 'MCI'}, ...
    {'CN', 'CN_pos'}, ...
    {'MCI', 'AD'}, ...
    {'MCI', 'CN_pos'}, ...
    {'CN_pos', 'AD'}, ...
    {'CN_pos', 'MCI'}
};

% VOI covariates to extract (e.g., 'Age', 'Sex', 'Education')
voi_covariates = {'Age', 'Sex', 'Education'};

% Extract VOI covariates for all groups from SUVR_gr
voi = cell(length(suvr_groups), 1);
for g = 1:length(suvr_groups)
    sub_list = suvr_groups{g}.get('SUB_DICT').get('IT_LIST');
    num_subs = length(sub_list);
    % Extract VOI covariates
    voi_data = zeros(num_subs, length(voi_covariates));
    for s = 1:num_subs
        sub = sub_list{s};
        voi_dict = sub.get('VOI_DICT');
        for v = 1:length(voi_covariates)
            voi_value = voi_dict.get('IT', voi_covariates{v}).get('V');
            if iscategorical(voi_value) || ischar(voi_value) % Handle categorical VOI like 'Sex'
                if strcmp(voi_covariates{v}, 'Sex')
                    if strcmp(voi_value, 'Male')
                        voi_value = 0;
                    elseif strcmp(voi_value, 'Female')
                        voi_value = 1;
                    else
                        voi_value = NaN; % Handle unknown values
                    end
                end
            end
            voi_data(s, v) = voi_value;
        end
    end
    voi{g} = voi_data;
end

% Extract perturbation connectivity data for all groups
conn_data = cell(length(conn_groups), 1);
for g = 1:length(conn_groups)
    sub_list = conn_groups{g}.get('SUB_DICT').get('IT_LIST');
    num_subs = length(sub_list);
    if num_subs > 0
        first_sub = sub_list{1};
        conn_matrix = first_sub.get('CON');
        n_regions = size(conn_matrix, 1); % Number of regions
        num_conn_features = n_regions * (n_regions - 1) / 2; % Number of unique edges
    else
        num_conn_features = 0; % Handle empty case
    end
    % Extract upper triangular part of connectome data
    conn_data{g} = zeros(num_subs, num_conn_features);
    for s = 1:num_subs
        sub = sub_list{s};
        conn_matrix = sub.get('CON');
        upper_vec = conn_matrix(triu(true(size(conn_matrix)), 1)); % Upper triangular part
        conn_data{g}(s, :) = upper_vec(:)'; % Flatten to row vector
    end
end

% Get atlas information for brain region mapping
first_sub = SUVR_gr1.get('SUB_DICT').get('IT', 1); % First subject from CN group
ba = first_sub.get('BA'); % Brain Atlas
br_dict = ba.get('BR_DICT'); % Brain Region Dictionary
n_regions = numel(br_dict.get('IT_LIST')); % Number of regions
num_conn_features = n_regions * (n_regions - 1) / 2; % Number of unique edges
edge_pairs = cell(num_conn_features, 2);
edge_idx = 1;
for i = 1:n_regions
    for j = i+1:n_regions
        edge_pairs{edge_idx, 1} = i; % Source region ID
        edge_pairs{edge_idx, 2} = j; % Target region ID
        edge_idx = edge_idx + 1;
    end
end

% Run tt2 for each pair for perturbation connectivity
pvals_table_conn = table('Size', [length(pairs), 4], 'VariableTypes', {'string', 'double', 'double', 'double'}, ...
    'VariableNames', {'Pair', 'pval_mean', 'tval_mean', 'num_significant'});
significant_edges_conn = cell(length(pairs), 1);

for p = 1:length(pairs)
    group1_name = pairs{p}{1};
    group2_name = pairs{p}{2};
    idx1 = find(strcmp(group_names, group1_name));
    idx2 = find(strcmp(group_names, group2_name));
    
    X1_conn = conn_data{idx1};
    X2_conn = conn_data{idx2};
    cov1 = voi{idx1};
    cov2 = voi{idx2};
    cov = [cov1; cov2]; % Combined covariates from SUVR_gr
    
    % Run tt2 for connectivity
    [pvals_conn, tvals_conn] = tt2(X1_conn, X2_conn, cov);
    pvals_fdr_conn = mafdr(pvals_conn, 'BHFDR', true);
    p_idx_conn = find(pvals_fdr_conn < 0.05);
    
    % Store all p-values with their indices for ranking
    significant_pvals = zeros(length(p_idx_conn), 2); % [index, p-value]
    for i = 1:length(p_idx_conn)
        idx = p_idx_conn(i);
        significant_pvals(i, 1) = idx; % Original index
        significant_pvals(i, 2) = pvals_fdr_conn(idx); % FDR-corrected p-value
    end
    
    % Sort by p-value (lowest to highest for ranking by importance)
    [~, sort_idx] = sort(significant_pvals(:, 2));
    ranked_pvals = significant_pvals(sort_idx, :);
    
    % Store Connectivity results
    pvals_table_conn.Pair{p} = [group1_name ' vs ' group2_name];
    pvals_table_conn.pval_mean(p) = mean(pvals_fdr_conn); % Mean FDR-corrected p-value
    pvals_table_conn.tval_mean(p) = mean(tvals_conn); % Mean t-value
    pvals_table_conn.num_significant(p) = length(p_idx_conn); % Number of significant edges
    
    % Map ranked significant indices to edge pairs
    if ~isempty(p_idx_conn)
        significant_edges_conn{p} = table('Size', [length(p_idx_conn), 4], ...
            'VariableTypes', {'double', 'double', 'string', 'double'}, ...
            'VariableNames', {'Edge_ID1', 'Edge_ID2', 'Edge_Label', 'FDR_pval'});
        for i = 1:length(p_idx_conn)
            idx = ranked_pvals(i, 1); % Use ranked index
            if idx <= num_conn_features
                significant_edges_conn{p}.Edge_ID1(i) = edge_pairs{idx, 1};
                significant_edges_conn{p}.Edge_ID2(i) = edge_pairs{idx, 2};
                % Create a label combining the two region labels
                br1 = br_dict.get('IT', edge_pairs{idx, 1});
                br2 = br_dict.get('IT', edge_pairs{idx, 2});
                significant_edges_conn{p}.Edge_Label(i) = [br1.get('LABEL'), '-', br2.get('LABEL')];
                significant_edges_conn{p}.FDR_pval(i) = ranked_pvals(i, 2); % Ranked p-value
            else
                warning('Connectivity Index %d exceeds number of edges (%d)', idx, num_conn_features);
            end
        end
    else
        significant_edges_conn{p} = table('Size', [0, 4], ...
            'VariableTypes', {'double', 'double', 'string', 'double'}, ...
            'VariableNames', {'Edge_ID1', 'Edge_ID2', 'Edge_Label', 'FDR_pval'});
    end
end

% Display the results table
disp('T-test Results for Perturbation Connectivity with FDR Correction:');
disp(pvals_table_conn);

% Display ranked significant edges for each pair
for p = 1:length(pairs)
    if ~isempty(significant_edges_conn{p})
        disp(['Ranked Significant Edges for Perturbation Connectivity (' pvals_table_conn.Pair{p} '):']);
        disp(significant_edges_conn{p});
    end
end

% Save results to a file
% save('/home/hang/GitHub/IndividualConnectome-WithYuwei/statistical analysis/ranked_significant_edges_results.mat', ...
%     'pvals_table_conn', 'significant_edges_conn');

%% FDG PET
clc;

% Add paths to necessary toolboxes (adjust as needed)
addpath(genpath('/home/hang/GitHub/IndividualConnectome-WithYuwei/braph2individualconnectome'));
addpath(genpath('/home/hang/GitHub/Individual-connectome/group_data/ADNI_DATA'));
addpath(genpath('/home/hang/GitHub/BRAPH-2/braph2genesis/src')); % Add BRAPH-2 genesis path

% Define the groups and their names for comparison
group_names = {'CN', 'MCI', 'AD', 'CN_pos'};
suvr_groups = {SUVR_gr1, SUVR_gr2, SUVR_gr3, SUVR_gr4}; % For VOI data
conn_groups = {Con_gr1_pert, Con_gr2_pert, Con_gr3_pert, Con_gr4_pert}; % For connectivity data

% Define the pairs for comparison (e.g., CN vs. AD, CN vs. MCI, etc.)
pairs = {
    {'CN', 'AD'}, ...
    {'CN', 'MCI'}, ...
    {'CN', 'CN_pos'}, ...
    {'MCI', 'AD'}, ...
    {'MCI', 'CN_pos'}, ...
    {'CN_pos', 'AD'}, ...
    {'CN_pos', 'MCI'}
};

% VOI covariates to extract (e.g., 'Age', 'Sex', 'Education')
voi_covariates = {'Age', 'Sex', 'Education'};

% Extract VOI covariates for all groups from SUVR_gr
voi = cell(length(suvr_groups), 1);
for g = 1:length(suvr_groups)
    sub_list = suvr_groups{g}.get('SUB_DICT').get('IT_LIST');
    num_subs = length(sub_list);
    % Extract VOI covariates
    voi_data = zeros(num_subs, length(voi_covariates));
    for s = 1:num_subs
        sub = sub_list{s};
        voi_dict = sub.get('VOI_DICT');
        for v = 1:length(voi_covariates)
            voi_value = voi_dict.get('IT', voi_covariates{v}).get('V');
            if iscategorical(voi_value) || ischar(voi_value) % Handle categorical VOI like 'Sex'
                if strcmp(voi_covariates{v}, 'Sex')
                    if strcmp(voi_value, 'Male')
                        voi_value = 0;
                    elseif strcmp(voi_value, 'Female')
                        voi_value = 1;
                    else
                        voi_value = NaN; % Handle unknown values
                    end
                end
            end
            voi_data(s, v) = voi_value;
        end
    end
    voi{g} = voi_data;
end

% Extract perturbation connectivity data for all groups
conn_data = cell(length(conn_groups), 1);
for g = 1:length(conn_groups)
    sub_list = conn_groups{g}.get('SUB_DICT').get('IT_LIST');
    num_subs = length(sub_list);
    if num_subs > 0
        first_sub = sub_list{1};
        conn_matrix = first_sub.get('CON');
        n_regions = size(conn_matrix, 1); % Number of regions
        num_conn_features = n_regions * (n_regions - 1) / 2; % Number of unique edges
    else
        num_conn_features = 0; % Handle empty case
    end
    % Extract upper triangular part of connectome data
    conn_data{g} = zeros(num_subs, num_conn_features);
    for s = 1:num_subs
        sub = sub_list{s};
        conn_matrix = sub.get('CON');
        upper_vec = conn_matrix(triu(true(size(conn_matrix)), 1)); % Upper triangular part
        conn_data{g}(s, :) = upper_vec(:)'; % Flatten to row vector
    end
end

% Get atlas information for brain region mapping
first_sub = SUVR_gr1.get('SUB_DICT').get('IT', 1); % First subject from CN group
ba = first_sub.get('BA'); % Brain Atlas
br_dict = ba.get('BR_DICT'); % Brain Region Dictionary
n_regions = numel(br_dict.get('IT_LIST')); % Number of regions
num_conn_features = n_regions * (n_regions - 1) / 2; % Number of unique edges
edge_pairs = cell(num_conn_features, 2);
edge_idx = 1;
for i = 1:n_regions
    for j = i+1:n_regions
        edge_pairs{edge_idx, 1} = i; % Source region ID
        edge_pairs{edge_idx, 2} = j; % Target region ID
        edge_idx = edge_idx + 1;
    end
end

% Run tt2 and visualize for each pair for perturbation connectivity
pvals_table_conn = table('Size', [length(pairs), 4], 'VariableTypes', {'string', 'double', 'double', 'double'}, ...
    'VariableNames', {'Pair', 'pval_mean', 'tval_mean', 'num_significant'});
significant_edges_conn = cell(length(pairs), 1);

for p = 1:length(pairs)
    group1_name = pairs{p}{1};
    group2_name = pairs{p}{2};
    idx1 = find(strcmp(group_names, group1_name));
    idx2 = find(strcmp(group_names, group2_name));
    
    X1_conn = conn_data{idx1};
    X2_conn = conn_data{idx2};
    cov1 = voi{idx1};
    cov2 = voi{idx2};
    cov = [cov1; cov2]; % Combined covariates from SUVR_gr
    
    % Run tt2 for connectivity
    [pvals_conn, tvals_conn] = tt2(X1_conn, X2_conn, cov);
    pvals_fdr_conn = mafdr(pvals_conn, 'BHFDR', true);
    p_idx_conn = find(pvals_fdr_conn < 0.05);
    
    % Store all p-values with their indices for ranking
    significant_pvals = zeros(length(p_idx_conn), 2); % [index, p-value]
    for i = 1:length(p_idx_conn)
        idx = p_idx_conn(i);
        significant_pvals(i, 1) = idx; % Original index
        significant_pvals(i, 2) = pvals_fdr_conn(idx); % FDR-corrected p-value
    end
    
    % Sort by p-value (lowest to highest for ranking by importance)
    [~, sort_idx] = sort(significant_pvals(:, 2));
    ranked_pvals = significant_pvals(sort_idx, :);
    
    % Store Connectivity results
    pvals_table_conn.Pair{p} = [group1_name ' vs ' group2_name];
    pvals_table_conn.pval_mean(p) = mean(pvals_fdr_conn); % Mean FDR-corrected p-value
    pvals_table_conn.tval_mean(p) = mean(tvals_conn); % Mean t-value
    pvals_table_conn.num_significant(p) = length(p_idx_conn); % Number of significant edges
    
    % Map ranked significant indices to edge pairs
    if ~isempty(p_idx_conn)
        significant_edges_conn{p} = table('Size', [length(p_idx_conn), 4], ...
            'VariableTypes', {'double', 'double', 'string', 'double'}, ...
            'VariableNames', {'Edge_ID1', 'Edge_ID2', 'Edge_Label', 'FDR_pval'});
        for i = 1:length(p_idx_conn)
            idx = ranked_pvals(i, 1); % Use ranked index
            if idx <= num_conn_features
                significant_edges_conn{p}.Edge_ID1(i) = edge_pairs{idx, 1};
                significant_edges_conn{p}.Edge_ID2(i) = edge_pairs{idx, 2};
                % Create a label combining the two region labels
                br1 = br_dict.get('IT', edge_pairs{idx, 1});
                br2 = br_dict.get('IT', edge_pairs{idx, 2});
                significant_edges_conn{p}.Edge_Label(i) = [br1.get('LABEL'), '-', br2.get('LABEL')];
                significant_edges_conn{p}.FDR_pval(i) = ranked_pvals(i, 2); % Ranked p-value
            else
                warning('Connectivity Index %d exceeds number of edges (%d)', idx, num_conn_features);
            end
        end
    else
        significant_edges_conn{p} = table('Size', [0, 4], ...
            'VariableTypes', {'double', 'double', 'string', 'double'}, ...
            'VariableNames', {'Edge_ID1', 'Edge_ID2', 'Edge_Label', 'FDR_pval'});
    end
    
    % Create pair-specific BrainAtlas with only regions involved in significant edges
    pair_br_dict = IndexedDictionary('ID', ['BR_DICT_' group1_name '_' group2_name], 'IT_CLASS', 'BrainRegion');
    unique_region_ids = unique([significant_edges_conn{p}.Edge_ID1; significant_edges_conn{p}.Edge_ID2]);
    for i = 1:length(unique_region_ids)
        br = br_dict.get('IT', unique_region_ids(i));
        pair_br_dict.get('ADD', br);
    end
    ba_pair = BrainAtlas('ID', ['BA_' group1_name '_' group2_name], 'LABEL', [group1_name ' vs ' group2_name], 'NOTES', 'Pair-specific atlas', 'BR_DICT', pair_br_dict);
    
    % Create pair-specific sph_dict with spheres for significant edge endpoints
    pair_sph_dict = IndexedDictionary('ID', ['SPH_DICT_' group1_name '_' group2_name], 'IT_CLASS', 'SettingsSphere');
    for i = 1:height(significant_edges_conn{p})
        edge_idx = ranked_pvals(i, 1); % Use ranked index
        if edge_idx <= num_conn_features
            region1_id = edge_pairs{edge_idx, 1};
            region2_id = edge_pairs{edge_idx, 2};
            br1 = br_dict.get('IT', region1_id);
            br2 = br_dict.get('IT', region2_id);
            significance = -log10(significant_edges_conn{p}.FDR_pval(i)) / 10 + 1;
            disp(significance);
            % Sphere for region 1
            sph1 = SettingsSphere(...
                'PANEL', pf, ...
                'PROP', BrainAtlasPF.H_SPHS, ...
                'I', region1_id, ...
                'VISIBLE', true, ...
                'ID', br1.get('ID'), ...
                'X', br1.get('X'), ...
                'Y', br1.get('Y'), ...
                'Z', br1.get('Z'), ...
                'SPHERESIZE', significance, ...
                'FACECOLOR', BRAPH2.COL, ... % Default color, to be updated below
                'FACEALPHA', 1 ...
                );
            % Sphere for region 2
            sph2 = SettingsSphere(...
                'PANEL', pf, ...
                'PROP', BrainAtlasPF.H_SPHS, ...
                'I', region2_id, ...
                'VISIBLE', true, ...
                'ID', br2.get('ID'), ...
                'X', br2.get('X'), ...
                'Y', br2.get('Y'), ...
                'Z', br2.get('Z'), ...
                'SPHERESIZE', significance, ...
                'FACECOLOR', BRAPH2.COL, ... % Default color, to be updated below
                'FACEALPHA', 1 ...
                );
            % Interpolate FACECOLOR based on significance
            base_color = [0.9000 0.4000 0.1000]; % Original color
            max_color = [1 0 0]; % Red for high significance
            max_significance = 1.5; % Cap at -log10(0.00001)/10 + 1 ≈ 1.5
            norm_significance = min(significance / max_significance, 1); % Normalize to [0, 1]
            face_color = base_color + (max_color - base_color) * norm_significance; % Linear interpolation
            sph1.set('FACECOLOR', face_color);
            sph2.set('FACECOLOR', face_color);
            pair_sph_dict.get('ADD', sph1);
            pair_sph_dict.get('ADD', sph2);
        end
    end
    
    % Update BrainAtlasPF with pair-specific BA and sph_dict
    pf = BrainAtlasPF(...
        'SURF', ImporterBrainSurfaceNV('FILE', surface_file).get('SURF'), ...
        'BA', ba_pair, ...
        'SPH_DICT', pair_sph_dict ...
        );
    
    % Draw and show the brain surface immediately
    pf.get('DRAW');
    pf.get('SHOW');
    gui0 = GUIFig('PF', pf, 'FILE', char(fprintf('%d', p)), 'POSITION', [.1 .1 .4 .8], 'WAITBAR', true, 'CLOSEREQ', false);
    gui0.get('DRAW');
    gui0.get('SHOW');
    
    % Save the figure (assuming gcf captures the current figure)
    f = gcf;
    saveas(f, ['/home/hang/GitHub/IndividualConnectome-WithYuwei/statistical analysis/' group1_name '_vs_' group2_name '_brain_projection.png']);
    close(f);
end

% Display the results table
disp('T-test Results for Perturbation Connectivity with FDR Correction:');
disp(pvals_table_conn);

% Display ranked significant edges for each pair
for p = 1:length(pairs)
    if ~isempty(significant_edges_conn{p})
        disp(['Ranked Significant Edges for Perturbation Connectivity (' pvals_table_conn.Pair{p} '):']);
        disp(significant_edges_conn{p});
    end
end

% Save results to a file
% save('/home/hang/GitHub/IndividualConnectome-WithYuwei/statistical analysis/ranked_significant_edges_results.mat', ...
%     'pvals_table_conn', 'significant_edges_conn');
