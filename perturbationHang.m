clear; clc;

% Load the Tau data and atlas (assuming these are available)
Tau = load(which('Tau.mat'));
Tau.Tau.SUVR = [Tau.Tau.SUVR_LH, Tau.Tau.SUVR_RH];
im_ba1 = ImporterBrainAtlasXLS('FILE', which('desikan_atlas_zhilei.xlsx'), 'WAITBAR', true);
ba1 = im_ba1.get('BA');

% Filter subjects with non-NaN values
IncludedScan = find(~isnan(Tau.Tau.AmyloidGroup) & ~isnan(Tau.Tau.Group) & ~isnan(Tau.Tau.Age) & ~isnan(Tau.Tau.Education));

% Categorize into groups
IncludedScan_NC_AN = IncludedScan(Tau.Tau.AmyloidGroup(IncludedScan) == 0 & Tau.Tau.Group(IncludedScan) == 0); % NC_AN
IncludedScan_NC_AP = IncludedScan(Tau.Tau.AmyloidGroup(IncludedScan) == 1 & Tau.Tau.Group(IncludedScan) == 0); % NC_AP
IncludedScan_MCI_AP = IncludedScan(Tau.Tau.AmyloidGroup(IncludedScan) == 1 & Tau.Tau.Group(IncludedScan) == 1); % MCI_AP
IncludedScan_AD_AP = IncludedScan(Tau.Tau.AmyloidGroup(IncludedScan) == 1 & Tau.Tau.Group(IncludedScan) == 2); % AD_AP

% Select earliest scan per RID (assuming GetScanOrder is defined)
[ScanOrder_NC_AN, ~, ~] = GetScanOrder(Tau.Tau.RID(IncludedScan_NC_AN), Tau.Tau.ScanDate(IncludedScan_NC_AN), Tau.Tau.Age(IncludedScan_NC_AN));
[ScanOrder_NC_AP, ~, ~] = GetScanOrder(Tau.Tau.RID(IncludedScan_NC_AP), Tau.Tau.ScanDate(IncludedScan_NC_AP), Tau.Tau.Age(IncludedScan_NC_AP));
[ScanOrder_MCI_AP, ~, ~] = GetScanOrder(Tau.Tau.RID(IncludedScan_MCI_AP), Tau.Tau.ScanDate(IncludedScan_MCI_AP), Tau.Tau.Age(IncludedScan_MCI_AP));
[ScanOrder_AD_AP, ~, ~] = GetScanOrder(Tau.Tau.RID(IncludedScan_AD_AP), Tau.Tau.ScanDate(IncludedScan_AD_AP), Tau.Tau.Age(IncludedScan_AD_AP));

Earliest_NC_AN = IncludedScan_NC_AN(ScanOrder_NC_AN == 1);
Earliest_NC_AP = IncludedScan_NC_AP(ScanOrder_NC_AP == 1);
Earliest_MCI_AP = IncludedScan_MCI_AP(ScanOrder_MCI_AP == 1);
Earliest_AD_AP = IncludedScan_AD_AP(ScanOrder_AD_AP == 1);
Earliest_All = [Earliest_NC_AN; Earliest_NC_AP; Earliest_MCI_AP; Earliest_AD_AP];

% Create filtered Tau struct
Tau_filtered = struct();
Tau_filtered.SUVR = Tau.Tau.SUVR(Earliest_All, :);
Tau_filtered.Age = Tau.Tau.Age(Earliest_All);
Tau_filtered.Sex = Tau.Tau.Sex(Earliest_All);
Tau_filtered.Education = Tau.Tau.Education(Earliest_All);
Tau_filtered.Group = Tau.Tau.Group(Earliest_All);
Tau_filtered.AmyloidGroup = Tau.Tau.AmyloidGroup(Earliest_All);
Tau_filtered.RID = Tau.Tau.RID(Earliest_All);
Tau.Tau = Tau_filtered;

% Redefine group indices
indices_ref = find(Tau.Tau.AmyloidGroup == 0 & Tau.Tau.Group == 0); % NC_AN (gr0)
indices_group1 = find(Tau.Tau.AmyloidGroup == 1 & Tau.Tau.Group == 0); % NC_AP (gr1)
indices_group2 = find(Tau.Tau.AmyloidGroup == 1 & Tau.Tau.Group == 1); % MCI_AP (gr2)
indices_group3 = find(Tau.Tau.AmyloidGroup == 1 & Tau.Tau.Group == 2); % AD_AP (gr3)

% Create BRAPH2 groups
% Group 0 (NC_AN)
sub_list0 = cell(length(indices_ref), 1);
for i = 1:length(indices_ref)
    idx = indices_ref(i);
    sub_id = num2str(Tau.Tau.RID(idx));
    sub = SubjectST('ID', sub_id, 'BA', ba1, 'ST', Tau.Tau.SUVR(idx, :)');
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Age', 'V', Tau.Tau.Age(idx)));
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Sex', 'V', Tau.Tau.Sex(idx)));
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Education', 'V', Tau.Tau.Education(idx)));
    sub_list0{i} = sub;
end
gr0 = Group('SUB_CLASS', 'SubjectST', 'ID', 'NC_AN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST', 'IT_LIST', sub_list0));

% Group 1 (NC_AP)
sub_list1 = cell(length(indices_group1), 1);
for i = 1:length(indices_group1)
    idx = indices_group1(i);
    sub_id = num2str(Tau.Tau.RID(idx));
    sub = SubjectST('ID', sub_id, 'BA', ba1, 'ST', Tau.Tau.SUVR(idx, :)');
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Age', 'V', Tau.Tau.Age(idx)));
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Sex', 'V', Tau.Tau.Sex(idx)));
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Education', 'V', Tau.Tau.Education(idx)));
    sub_list1{i} = sub;
end
gr1 = Group('SUB_CLASS', 'SubjectST', 'ID', 'NC_AP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST', 'IT_LIST', sub_list1));

% Group 2 (MCI_AP)
sub_list2 = cell(length(indices_group2), 1);
for i = 1:length(indices_group2)
    idx = indices_group2(i);
    sub_id = num2str(Tau.Tau.RID(idx));
    sub = SubjectST('ID', sub_id, 'BA', ba1, 'ST', Tau.Tau.SUVR(idx, :)');
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Age', 'V', Tau.Tau.Age(idx)));
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Sex', 'V', Tau.Tau.Sex(idx)));
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Education', 'V', Tau.Tau.Education(idx)));
    sub_list2{i} = sub;
end
gr2 = Group('SUB_CLASS', 'SubjectST', 'ID', 'MCI_AP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST', 'IT_LIST', sub_list2));

% Group 3 (AD_AP)
sub_list3 = cell(length(indices_group3), 1);
for i = 1:length(indices_group3)
    idx = indices_group3(i);
    sub_id = num2str(Tau.Tau.RID(idx));
    sub = SubjectST('ID', sub_id, 'BA', ba1, 'ST', Tau.Tau.SUVR(idx, :)');
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Age', 'V', Tau.Tau.Age(idx)));
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Sex', 'V', Tau.Tau.Sex(idx)));
    sub.memorize('VOI_DICT').get('ADD', VOI('ID', 'Education', 'V', Tau.Tau.Education(idx)));
    sub_list3{i} = sub;
end
gr3 = Group('SUB_CLASS', 'SubjectST', 'ID', 'AD_AP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST', 'IT_LIST', sub_list3));

% Define methods
methods = {'SUVR', 'Perturbation'};
results = struct();

% Run classification for each method 10 times
for m = 1:length(methods)
    method = methods{m};
    results.(method).AUC = zeros(10, 2); % NC_AP vs MCI_AP, NC_AP vs AD_AP
    results.(method).Sensitivity = zeros(10, 2);
    results.(method).Specificity = zeros(10, 2);
    
    % Prepare data based on method
    if strcmp(method, 'SUVR')
        % SUVR uses structural data directly
        it_list0 = cellfun(@(x) NNDataPoint_ST_CLA('ID', x.get('ID'), 'SUB', x, 'TARGET_CLASS', {gr0.get('ID')}), gr0.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
        it_list1 = cellfun(@(x) NNDataPoint_ST_CLA('ID', x.get('ID'), 'SUB', x, 'TARGET_CLASS', {gr1.get('ID')}), gr1.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
        it_list2 = cellfun(@(x) NNDataPoint_ST_CLA('ID', x.get('ID'), 'SUB', x, 'TARGET_CLASS', {gr2.get('ID')}), gr2.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
        it_list3 = cellfun(@(x) NNDataPoint_ST_CLA('ID', x.get('ID'), 'SUB', x, 'TARGET_CLASS', {gr3.get('ID')}), gr3.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
        dp_class = 'NNDataPoint_ST_CLA';
    elseif strcmp(method, 'Perturbation')
        % Perturbation method
        im_gr1 = IndividualPerturbationConConstructor('GR_SUVR', gr1, 'GR_SUVR_REF', gr0);
        im_gr2 = IndividualPerturbationConConstructor('GR_SUVR', gr2, 'GR_SUVR_REF', gr0);
        im_gr3 = IndividualPerturbationConConstructor('GR_SUVR', gr3, 'GR_SUVR_REF', gr0);
        Con_gr1 = im_gr1.get('GR');
        Con_gr2 = im_gr2.get('GR');
        Con_gr3 = im_gr3.get('GR');
        it_list1 = cellfun(@(x) NNDataPoint_CON_CLA('ID', x.get('ID'), 'SUB', x, 'TARGET_CLASS', {gr1.get('ID')}), Con_gr1.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
        it_list2 = cellfun(@(x) NNDataPoint_CON_CLA('ID', x.get('ID'), 'SUB', x, 'TARGET_CLASS', {gr2.get('ID')}), Con_gr2.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
        it_list3 = cellfun(@(x) NNDataPoint_CON_CLA('ID', x.get('ID'), 'SUB', x, 'TARGET_CLASS', {gr3.get('ID')}), Con_gr3.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
        dp_class = 'NNDataPoint_CON_CLA';
    end
    
    % Create datasets (excluding gr0 for classification tasks)
    d1 = NNDataset('DP_CLASS', dp_class, 'DP_DICT', IndexedDictionary('IT_CLASS', dp_class, 'IT_LIST', it_list1));
    d2 = NNDataset('DP_CLASS', dp_class, 'DP_DICT', IndexedDictionary('IT_CLASS', dp_class, 'IT_LIST', it_list2));
    d3 = NNDataset('DP_CLASS', dp_class, 'DP_DICT', IndexedDictionary('IT_CLASS', dp_class, 'IT_LIST', it_list3));
    
    % Balance groups
    group_size1 = d1.get('DP_DICT').get('LENGTH');
    group_size2 = d2.get('DP_DICT').get('LENGTH');
    group_size3 = d3.get('DP_DICT').get('LENGTH');
    min_group_size = min([group_size1, group_size2, group_size3]);
    
    for run = 1:10
        rng(run); % Set random seed for reproducibility
        % 
        % Undersample groups to balance them
        if group_size1 > min_group_size
            rand_indices_d1 = randperm(group_size1, min_group_size);
            selected_it_list1 = it_list1(rand_indices_d1);
            d1_balanced = NNDataset('DP_CLASS', dp_class, 'DP_DICT', IndexedDictionary('IT_CLASS', dp_class, 'IT_LIST', selected_it_list1));
        else
            d1_balanced = d1;
        end

        if group_size2 > min_group_size
            rand_indices_d2 = randperm(group_size2, min_group_size);
            selected_it_list2 = it_list2(rand_indices_d2);
            d2_balanced = NNDataset('DP_CLASS', dp_class, 'DP_DICT', IndexedDictionary('IT_CLASS', dp_class, 'IT_LIST', selected_it_list2));
        else
            d2_balanced = d2;
        end

        if group_size3 > min_group_size
            rand_indices_d3 = randperm(group_size3, min_group_size);
            selected_it_list3 = it_list3(rand_indices_d3);
            d3_balanced = NNDataset('DP_CLASS', dp_class, 'DP_DICT', IndexedDictionary('IT_CLASS', dp_class, 'IT_LIST', selected_it_list3));
        else
            d3_balanced = d3;
        end

        % Extract features based on method
        % Extract features based on the method
        if strcmp(method, 'SUVR')
            % Extract SUVR vectors for each group
            X1_suvr = cell2mat(cellfun(@(dp) dp.get('SUB').get('ST'), ...
                d1_balanced.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false)')';
            X2_suvr = cell2mat(cellfun(@(dp) dp.get('SUB').get('ST'), ...
                d2_balanced.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false)')';
            X3_suvr = cell2mat(cellfun(@(dp) dp.get('SUB').get('ST'), ...
                d3_balanced.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false)')';
            X2_ID = cellfun(@(dp) dp.get('SUB').get('ID'), d2_balanced.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false)';

            % Extract VOI for each group
            X1_voi = extract_voi(d1_balanced);
            X2_voi = extract_voi(d2_balanced);
            X3_voi = extract_voi(d3_balanced);

            % Regress out VOI from SUVR vectors
            X1_features = regress_out_voi(X1_suvr, X1_voi);
            X2_features = regress_out_voi(X2_suvr, X2_voi);
            X3_features = regress_out_voi(X3_suvr, X3_voi);
        elseif strcmp(method, 'Perturbation')
            % Extract connectivity matrices for each group
            dp_list1 = d1_balanced.get('DP_DICT').get('IT_LIST');
            dp_list2 = d2_balanced.get('DP_DICT').get('IT_LIST');
            dp_list3 = d3_balanced.get('DP_DICT').get('IT_LIST');
            X1_conn = cellfun(@(dp) dp.get('SUB').get('CON'), dp_list1, 'UniformOutput', false);
            X2_conn = cellfun(@(dp) dp.get('SUB').get('CON'), dp_list2, 'UniformOutput', false);
            X3_conn = cellfun(@(dp) dp.get('SUB').get('CON'), dp_list3, 'UniformOutput', false);

            % Vectorize connectivity matrices (upper triangle without diagonal)
            X1_conn_vec = cellfun(@(conn) squareform(conn - diag(diag(conn))), X1_conn, 'UniformOutput', false);
            X2_conn_vec = cellfun(@(conn) squareform(conn - diag(diag(conn))), X2_conn, 'UniformOutput', false);
            X3_conn_vec = cellfun(@(conn) squareform(conn - diag(diag(conn))), X3_conn, 'UniformOutput', false);

            % Convert to feature matrices
            X1_features = cell2mat(X1_conn_vec');
            X2_features = cell2mat(X2_conn_vec');
            X3_features = cell2mat(X3_conn_vec');
        end

        % Prepare features and labels for classification tasks
        % NC_AP vs MCI_AP
        X_ncap_mciap = [X1_features; X2_features];
        y_ncap_mciap = [zeros(size(X1_features, 1), 1); ones(size(X2_features, 1), 1)];

        % NC_AP vs AD_AP
        X_ncap_adap = [X1_features; X3_features];
        y_ncap_adap = [zeros(size(X1_features, 1), 1); ones(size(X3_features, 1), 1)];


        % Train and evaluate SVM for each task
        tasks = {'NC_AP_vs_MCI_AP', 'NC_AP_vs_AD_AP'};
        for t = 1:2
            switch t
                case 1
                    X = X_ncap_mciap;
                    y = y_ncap_mciap;
                case 2
                    X = X_ncap_adap;
                    y = y_ncap_adap;
            end
                    % Define 5-fold cross-validation
            cv = cvpartition(y, 'KFold', 10);
            auc_folds = zeros(cv.NumTestSets, 1);
            sensitivity_folds = zeros(cv.NumTestSets, 1);
            specificity_folds = zeros(cv.NumTestSets, 1);
            
            for k = 1:cv.NumTestSets
                trainIdx = cv.training(k);
                testIdx = cv.test(k);
                
                X_train = X(trainIdx, :);
                y_train = y(trainIdx);
                X_test = X(testIdx, :);
                y_test = y(testIdx);
                
                svm_model = fitcsvm(X_train, y_train, 'KernelFunction', 'linear', 'Standardize', true);
                
                [y_pred, scores] = predict(svm_model, X_test);
                
                cm = confusionmat(y_test, y_pred);
                sensitivity_folds(k) = cm(2,2) / sum(cm(2,:));
                specificity_folds(k) = cm(1,1) / sum(cm(1,:));
                
                [~, ~, ~, auc_folds(k)] = perfcurve(y_test, scores(:,2), 1);
            end
            
            results.(method).AUC(run, t) = mean(auc_folds);
            results.(method).Sensitivity(run, t) = mean(sensitivity_folds);
            results.(method).Specificity(run, t) = mean(specificity_folds);
        end
    end
end

% Save results
save('classification_results.mat', 'results');

% Plot box plots
figure('Position', [100, 100, 800, 600]);
subplot(2, 1, 1);
boxplot([results.SUVR.AUC(:,1), results.Perturbation.AUC(:,1)], 'Labels', {'SUVR', 'Perturbation'});
title('AUC for NC_AP vs MCI_AP');
ylabel('AUC');

subplot(2, 1, 2);
boxplot([results.SUVR.AUC(:,2), results.Perturbation.AUC(:,2)], 'Labels', {'SUVR', 'Perturbation'});
title('AUC for NC_AP vs AD_AP');
ylabel('AUC');

figure('Position', [100, 100, 800, 600]);
subplot(2, 1, 1);
boxplot([results.SUVR.Sensitivity(:,1), results.Perturbation.Sensitivity(:,1)], 'Labels', {'SUVR', 'Perturbation'});
title('Sensitivity for NC_AP vs MCI_AP');
ylabel('Sensitivity');

subplot(2, 1, 2);
boxplot([results.SUVR.Sensitivity(:,2), results.Perturbation.Sensitivity(:,2)], 'Labels', {'SUVR', 'Perturbation'});
title('Sensitivity for NC_AP vs AD_AP');
ylabel('Sensitivity');

figure('Position', [100, 100, 800, 600]);
subplot(2, 1, 1);
boxplot([results.SUVR.Specificity(:,1), results.Perturbation.Specificity(:,1)], 'Labels', {'SUVR', 'Perturbation'});
title('Specificity for NC_AP vs MCI_AP');
ylabel('Specificity');

subplot(2, 1, 2);
boxplot([results.SUVR.Specificity(:,2), results.Perturbation.Specificity(:,2)], 'Labels', {'SUVR', 'Perturbation'});
title('Specificity for NC_AP vs AD_AP');
ylabel('Specificity');

function X_regressed = regress_out_voi(X, voi)
    num_regions = size(X, 2);
    X_regressed = zeros(size(X));
    for r = 1:num_regions
       [~,~,X_regressed(:, r),~,~] = regress(X(:, r),[ones(length(X_regressed(:, r)),1),voi]);
    end
end

function voi = extract_voi(dataset)
    voi_keys = {'Age', 'Sex', 'Education'};
    num_subjects = dataset.get('DP_DICT').get('LENGTH');
    voi = zeros(num_subjects, length(voi_keys));
    for i = 1:num_subjects
        voi_dict = dataset.get('DP_DICT').get('IT', i).get('SUB').get('VOI_DICT');
        for v = 1:length(voi_keys)
            voi(i, v) = voi_dict.get('IT', voi_keys{v}).get('V');
        end
    end
end