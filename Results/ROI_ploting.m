close all
% List of .mat files containing classification results
% fileNames = {
%     'classification_results_BaselinebinaryBalanced.mat',
%     'classification_results_perturbation_matrixClassification_Balanced.mat',
%     'classification_results_distance_matrixClassification_Balanced.mat',
%     'classification_results_correlation_matrixClassification_Balanced.mat',
%     'classification_results_divergence_matrixClassification_Balanced.mat',
%     'classification_results_deviation_matrixClassification_Balanced.mat'
% };
% fileNames = {
%     'classification_results_BaselinebinaryBalanced.mat',
%     'classification_baseline+GlobalEffiperturbation_Balanced.mat',
%     'classification_baseline+GlobalEffidistance_Balanced.mat',
%     'classification_baseline+GlobalEfficorrelation_Balanced.mat',
%     'classification_baseline+GlobalEffiDivergence_Balanced.mat',
%     'classification_baseline+GlobalEffideviation_Balanced.mat'
% };

% fileNames = {
%     'classification_BaselineWholeMatrix_Balanced.mat',
%     'classification_Perturbationhybrid_matrix_Balanced.mat',
%     'classification_Distancehybrid_matrix_Balanced.mat',
%     'classification_Correlationhybrid_matrix_Balanced.mat',
%     'classification_Divergencehybrid_matrix_Balanced.mat',
%     'classification_Deviationhybrid_matrix_Balanced.mat',
%     'classification_results_SUVR_Balanced.mat'
% };

% fileNames = {
%     'classification_BaselineWholeMatrix_Balanced.mat',
%     'classification_MultiplexWU_Perturbation_Balanced.mat',
%     'classification_MultiplexWU_Distance_Balanced.mat',
%     'classification_CorrelationMultiplexWU_Balanced.mat',
%     'classification_DivergenceMultiplexWU_Balanced.mat',
%     'classification_MultiplexWU_Deviation_Balanced.mat'
% };
% 
% fileNames = {'classification_BaselinehybridSUVRMatrix_Balanced.mat',
%     'classification_PerturbationhybridSUVRMatrix_Balanced.mat',
%     'classification_DistancehybridSUVRMatrix_Balanced.mat',
%     'classification_CorrelationhybridSUVRMatrix_Balanced.mat',
%     'classification_DivergencehybridSUVRMatrix_Balanced.mat',
%     'classification_DeviationhybridSUVRMatrix_Balanced.mat'
%     };

fileNames = {'classification_BaselinehybridSUVRMatrix_Balanced.mat',
    'classification_CombinedMultilayerConMx_SUVR_Balanced.mat',
    };
% Legends for each method corresponding to the files
legends = {'Baseline', 'CombinedMultilayer'};
% fileNames = {'classification_results_SUVR_Balanced.mat'}
% legends = {'SUVR'};
% Classification tasks to analyze
taskNames = {'CN_vs_AD', 'CN_vs_MCI', 'CN_vs_CN_pos'};

% Generate distinct colors for each method (excluding Baseline, which will be black)
colors = lines(length(fileNames) - 1); % Colors for non-Baseline methods
colors = [0 0 0; colors]; % Add black (Baseline) at the start

% Define common False Positive Rate (FPR) points for interpolation
common_fpr = linspace(0, 1, 1000);

% Loop through each classification task
for g = 1:length(taskNames)
    taskName = taskNames{g};
    
    % Create a new figure for the current task
    figure; hold on; grid on;
    title(['Mean ROC Curves: ', strrep(taskName, '_', ' ')]);
    xlabel('False Positive Rate');
    ylabel('True Positive Rate');
    xlim([0 1]); ylim([0 1]);
    
    % Add diagonal line representing random guessing
    plot([0 1], [0 1], 'k--', 'LineWidth', 1, 'DisplayName', 'Random');
    
    % Initialize array to store plot handles for ordering
    plot_handles = gobjects(length(fileNames), 1);
    
    % Loop through each method/file
    for i = 1:length(fileNames)
        % Load data and check for task results
        data = load(fileNames{i});
        if isfield(data, 'results') && isfield(data.results, taskName)
            taskResult = data.results.(taskName);
            
            if isfield(taskResult, 'ROC_X') && isfield(taskResult, 'ROC_Y')
                % Case 1: ROC_X and ROC_Y exist (cell arrays of individual curves)
                ROC_X = taskResult.ROC_X;
                ROC_Y = taskResult.ROC_Y;
                if ~iscell(ROC_X) || ~iscell(ROC_Y)
                    warning('ROC_X or ROC_Y is not a cell array in %s for %s', fileNames{i}, taskName);
                    continue;
                end
                if length(ROC_X) ~= length(ROC_Y)
                    warning('Mismatch in number of runs for %s in %s', taskName, fileNames{i});
                    continue;
                end
                y_interp_all = nan(length(ROC_X), length(common_fpr));
                for k = 1:length(ROC_X)
                    x = double(ROC_X{k});
                    y = double(ROC_Y{k});
                    % % Invert ROC_Y for CN_vs_AD task
                    % if strcmp(taskName, 'CN_vs_AD') & contains(fileNames{i}, 'SUVR')
                    %     y = 1 - y;
                    %     x = 1 - x;
                    % end
                    
                    [x_sorted, idx] = sort(x);
                    y_sorted = y(idx);
                    [x_unique, unique_idx] = unique(x_sorted);
                    y_unique = y_sorted(unique_idx);
                    y_interp_all(k, :) = interp1(x_unique, y_unique, common_fpr, 'linear', NaN);
                end
                mean_y = mean(y_interp_all, 1, 'omitnan');
                
                % Plot with specific style based on method
                if strcmp(legends{i}, 'Baseline')
                    % Baseline: Black solid line
                    plot_handles(i) = plot(common_fpr, mean_y, 'LineStyle', '-', ...
                        'LineWidth', 2, 'Color', colors(i, :), 'DisplayName', legends{i});
                else
                    % Other methods: Colored dashed lines
                    plot_handles(i) = plot(common_fpr, mean_y, 'LineStyle', '--', ...
                        'LineWidth', 2, 'Color', colors(i, :), 'DisplayName', legends{i});
                end
                
            elseif isfield(taskResult, 'x_mean') && isfield(taskResult, 'y_mean')
                % Case 2: x_mean and y_mean exist
                if iscell(taskResult.x_mean) && iscell(taskResult.y_mean)
                    % Subcase 2a: x_mean and y_mean are cell arrays
                    x_cells = taskResult.x_mean;
                    y_cells = taskResult.y_mean;
                    if length(x_cells) ~= length(y_cells)
                        warning('Mismatch in number of runs for %s in %s', taskName, fileNames{i});
                        continue;
                    end
                    y_interp_all = nan(length(x_cells), length(common_fpr));
                    for k = 1:length(x_cells)
                        x = double(x_cells{k});
                        y = double(y_cells{k});
                        % Invert y_cells for CN_vs_AD task
                        % if strcmp(taskName, 'CN_vs_AD') & ~contains(fileNames{i}, 'Baseline')
                        %     y = 1 - y;
                        %     x = 1 - x;
                        % end
                        [x_sorted, idx] = sort(x);
                        y_sorted = y(idx);
                        [x_unique, unique_idx] = unique(x_sorted);
                        y_unique = y_sorted(unique_idx);
                        y_interp_all(k, :) = interp1(x_unique, y_unique, common_fpr, 'linear', NaN);
                    end
                    mean_y = mean(y_interp_all, 1, 'omitnan');
                    
                    % Plot with specific style based on method
                    if strcmp(legends{i}, 'Baseline')
                        plot_handles(i) = plot(common_fpr, mean_y, 'LineStyle', '-', ...
                            'LineWidth', 2, 'Color', colors(i, :), 'DisplayName', legends{i});
                    else
                        plot_handles(i) = plot(common_fpr, mean_y, 'LineStyle', '--', ...
                            'LineWidth', 2, 'Color', colors(i, :), 'DisplayName', legends{i});
                    end                    
                end
            end
        end
    end
    
    % Reorder plots to bring Baseline to the top (highest z-order)
    for i = 1:length(plot_handles)
        if strcmp(legends{i}, 'Baseline')
            uistack(plot_handles(i), 'top');
        end
    end
    
    % Add legend
    legend('Location', 'southeast');
    hold off;
    
    % Optional: Save the figure as a PNG file (uncomment to enable)
    % saveas(gcf, ['Results/matrix/withConverters/ROC_', taskName, 'hybirdMatrix.png']);
end