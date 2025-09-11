function [pvals, tvals] = tt2(X1, X2, cov)

X_all = [X1; X2];           % (n × p)
group = [ones(size(X1,1),1); 2*ones(size(X2,1),1)];  % 1/2 group labels

% 协变量矩阵（添加常数项）
C = [ones(size(cov,1), 1), cov];  % (n × 4)

% 初始化输出
nVars = size(X_all, 2);
pvals = zeros(nVars, 1);
tvals = zeros(nVars, 1);

for i = 1:nVars
    y = X_all(:, i);  % 当前变量

    % 回归掉协变量 -> 残差
    b = regress(y, C);
    y_resid = y - C * b;

    % 分组残差
    y1 = y_resid(group == 1);
    y2 = y_resid(group == 2);

    % two-sample t-test on residuals
    [~, p, ~, stats] = ttest2(y1, y2);

    % 存储结果
    pvals(i) = p;
    tvals(i) = stats.tstat;
end

end