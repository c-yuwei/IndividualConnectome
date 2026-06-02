% Define the list of .mat files
% 
% 
mat_files  = {'Classification_SUVRVectorWithoutStandardizeAndSemipositiveBalanced(CNpos)WithVOI.mat',
    'classification_SingleLayer_SUVR_Balanced(CN pos).mat',
    'classification_DistanceSingleLayer_Balanced(CN pos)NEW_ref_distance.mat',
    'classification_DistanceSUVRDoubleLayer_Balanced(CN pos)NEW_ref_distance.mat',
    'CorrelationSUVRDoubleLayer_Balanced(CN pos).mat',
    'PerturbationSUVRDoubleLayer_Balanced(CN_pos).mat',
    'DivergenceSUVRDoubleLayer_Balanced(CN pos).mat',
    'classification_CombinedMultilayerConMx_SUVR_BalancedNewDistance.mat'};
methods = {'SUVR Vector' 'SUVR Matrix'  'Distance Single' 'Distance Double' 'correlation' 'Perturbation' 'divergence' 'Multilayer' };

% 
% mat_files  = {'Classification_SUVRVectorWithoutStandardizeAndSemipositiveBalanced(CNpos)WithVOI.mat',
%     'classification_SingleLayer_SUVR_Balanced(CN pos).mat',
%     'classification_DistanceSingleLayer_Balanced(CN pos)NEW_ref_distance.mat',
%     'classification_CorrelationSingleLayer_Balanced(CN pos).mat',
%     'classification_PerturbationSingle_Balanced(CN_pos).mat',
%     'classification_DivergenceSingleLayer_Balanced(CN pos).mat'};
% methods = {'SUVR Vector' 'SUVR Matrix'  'Distance' 'correlation' 'Perturbation' 'divergence'};
group_pairs = {'CN_pos_vs_MCI', 'CN_pos_vs_AD'};

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

% Function to calculate mean and 95% CI
function [mean_val, ci] = calc_mean_ci(data)
    mean_val = mean(data);
    std_dev = std(data);
    n = length(data);
    ci = 1.96 * (std_dev / sqrt(n)); % 95% CI
end
