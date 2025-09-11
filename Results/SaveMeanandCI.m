% Define the list of .mat files
% mat_files = {
%     'classification_BaselineWholeMatrix_Balanced.mat',
%     'classification_Perturbationhybrid_matrix_Balanced.mat',
%     'classification_Distancehybrid_matrix_Balanced.mat',
%     'classification_Correlationhybrid_matrix_Balanced.mat',
%     'classification_Divergencehybrid_matrix_Balanced.mat',
%     'classification_Deviationhybrid_matrix_Balanced.mat'
% };
% mat_files  = {'classification_BaselinehybridSUVRMatrix_Balanced.mat'
%     'classification_DistancehybridSUVRMatrix_Balanced.mat',
%     'classification_CorrelationhybridSUVRMatrix_Balanced.mat',
%     'classification_DeviationhybridSUVRMatrix_Balanced.mat',
%     'classification_PerturbationhybridSUVRMatrix_Balanced.mat',
%     'classification_DivergencehybridSUVRMatrix_Balanced.mat'};

% mat_files  = {'classification_SingleLayer_SUVR_Balanced(CN pos).mat'
%     'DistanceSUVRDoubleLayerWithoutStandardizeAndSemipositive(CN pos).mat',
%     'CorrelationSUVRDoubleLayerWithoutStandardizeAndSemipositive(CN pos).mat',
%     'DeviationSUVRDoubleLayerWithoutStandardizeAndSemipositive(CN pos).mat',
%     'PerturbationSUVRDoubleLayerWithoutStandardizeAndSemipositive(CN POS).mat',
%     'DivergenceSUVRDoubleLayerWithoutStandardizeAndSemipositive(CN pos).mat',
%     'MultiLayerConbinedWithBaselineLayerNoDeviationWithoutStandardizeAndSemipositive(CN pos).mat'};
% methods = {'Baseline'  'Distance' 'correlation' 'deviation' 'Perturbation' 'divergence' 'Multilayer No deviation' };

% mat_files  ={'Classification_CamCAN_baselineWithAge.mat','Classification_CamCAN_baseline+perturbation.mat','Classification_CamCAN_baseline+perturbationWithAge.mat'};

mat_files  ={'GenderClassification_CamCAN_baseline_by_agegroups.mat',
    'GenderClassification_CamCAN_perturbation_by_agegroups.mat',
    };
% methods = {'SUVR', 'Distance', 'Correlation', 'Deviation', 'Perturbation', 'Divergence'};
methods ={'Baseline', 'Perturbation(Single layer)'};
% Group pairs
% group_pairs = {'old_vs_young'};
group_pairs = {'male_30_vs_female_30' 'male_40_vs_female_40' 'male_50_vs_female_50'};
% group_pairs = {'CN_pos_vs_MCI', 'CN_pos_vs_AD'};

% Function to calculate mean and 95% CI
function [mean_val, ci] = calc_mean_ci(data)
    mean_val = mean(data);
    std_dev = std(data);
    n = length(data);
    ci = 1.96 * (std_dev / sqrt(n)); % 95% CI
end

% Loop through each group pair
for j = 1:length(group_pairs)
    group_pair = group_pairs{j};
    
    % Initialize table for this group pair
    group_table = table();
    
    % Loop through each method
    for i = 1:length(mat_files)
        data = load(mat_files{i});
        method_name = methods{i};
        
        % Extract AUC, SEN, SPE based on method
        if i == 1 % Baseline method
            auc = data.results.(group_pair).AUC';
            sen = data.results.(group_pair).sensitivity';
            spe = data.results.(group_pair).specificity';
        else % Other methods
            auc = data.results.(group_pair).AUC;
            sen = data.results.(group_pair).sensitivity;
            spe = data.results.(group_pair).specificity;
        end
        
        % Calculate mean and CI for AUC
        [mean_auc, ci_auc] = calc_mean_ci(auc);
        % Format as 'mean ± CI' with 2 digits for mean and 4 for CI
        auc_str = sprintf('%.2f ± %.4f', mean_auc, ci_auc);
        
        % Calculate mean and CI for SEN
        [mean_sen, ci_sen] = calc_mean_ci(sen);
        % Format as 'mean ± CI' with 2 digits for mean and 4 for CI
        sen_str = sprintf('%.2f ± %.4f', mean_sen, ci_sen);
        
        % Calculate mean and CI for SPE
        [mean_spe, ci_spe] = calc_mean_ci(spe);
        % Format as 'mean ± CI' with 2 digits for mean and 4 for CI
        spe_str = sprintf('%.2f ± %.4f', mean_spe, ci_spe);
        
        % Create a temporary table for this method
        temp_table = table({method_name}, {auc_str}, {sen_str}, {spe_str}, ...
            'VariableNames', {'Method', 'AUC', 'Sensitivity', 'Specificity'});
        
        % Append to the group table
        group_table = [group_table; temp_table];
    end
    filename = ['results_', group_pair, 'MultiLayer.xlsx'];
    % save(['Results/matrix/withConverters' filesep filename], 'group_table');

    % writetable(group_table, ['Results/matrix/withConverters/' filesep filename])
    % Optional: Display the table for this group pair
    disp(['Results for ', group_pair]);
    disp(group_table);
end

%% 3 classes

mat_files = {'Classification_CamCAN_baseline(3 classes).mat', 'Classification_CamCAN_baseline+perturbation(3 classes).mat'};
methods = {'Baseline', 'Perturbation'};
group_pairs = {'Age30_Age40_Age50'};

% Function to calculate mean and 95% CI
function [mean_val, ci] = calc_mean_ci2(data)
    mean_val = mean(data);
    std_dev = std(data);
    n = length(data);
    ci = 1.96 * (std_dev / sqrt(n)); % 95% CI
end

% Loop through each group pair
for j = 1:length(group_pairs)
    group_pair = group_pairs{j};
    
    % Initialize table for this group pair
    group_table = table();
    
    % Loop through each method
    for i = 1:length(mat_files)
        data = load(mat_files{i});
        method_name = methods{i};
        if i == 1
            auc = data.results.(group_pair).av_AUC;
        else
            auc = data.results.(group_pair).AVAUC;
        end
        auc2(:,1) = auc(1:100);
        auc2(:,2) = auc(101:200);
        auc2(:,3) = auc(201:300);
        sensitivity = data.results.(group_pair).sensitivity;
        specificity = data.results.(group_pair).specificity;

        % Calculate mean and CI for AUC, SEN, SPE
        [mean_auc, ci_auc] = calc_mean_ci2(auc2);
        [mean_sen, ci_sen] = calc_mean_ci2(sensitivity);
        [mean_spe, ci_spe] = calc_mean_ci2(specificity);
        
        % Format as 'mean ± CI' with 2 digits for mean and 4 for CI
        auc_str = sprintf('%.3f ± %.2f ', mean_auc, ci_auc);
        sen_str = sprintf('%.3f ± %.2f ', mean_sen, ci_sen);
        spe_str = sprintf('%.3f ± %.2f ', mean_spe, ci_spe);
        
        % Create a temporary table for this method
       temp_table = table({method_name}, mean_auc(1), mean_auc(2), mean_auc(3), ...
            mean_sen(1), mean_sen(2), mean_sen(3), ...
            mean_spe(1), mean_spe(2), mean_spe(3), ...
            'VariableNames', {'Method', 'AUC_Age30', 'AUC_Age40', 'AUC_Age50', ...
                             'Sensitivity_Age30', 'Sensitivity_Age40', 'Sensitivity_Age50', ...
                             'Specificity_Age30', 'Specificity_Age40', 'Specificity_Age50'});
        
        % Append to the group table
        group_table = [group_table; temp_table];

    end
    
    filename = ['results_', group_pair, 'MultiLayer.xlsx'];
    % save(['Results/matrix/withConverters' filesep filename], 'group_table');

    % writetable(group_table, ['Results/matrix/withConverters/' filesep filename])
    % Optional: Display the table for this group pair
    disp(['Results for ', group_pair]);
    disp(group_table);
end