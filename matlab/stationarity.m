% Stationarity Analysis
% Store 1, Item 1 - Training Data Only

projectRoot = fileparts(fileparts(mfilename('fullpath')));

T = readtable(fullfile(projectRoot, 'data', 'train_raw.csv'));
y = T.sales;

% Raw series
[h_adf, p_adf] = adftest(y, 'Model', 'TS', 'Lags', 7);
[h_kpss, p_kpss] = kpsstest(y, 'Lags', 7, 'Trend', true);

% First difference
d1 = diff(y);

[h_adf1, p_adf1] = adftest(d1, 'Lags', 7);
[h_kpss1, p_kpss1] = kpsstest(d1, 'Lags', 7);

% Seasonal difference (lag 7)
d7 = y(8:end) - y(1:end-7);
[h_adf7, p_adf7] = adftest(d7);
[h_kpss7, p_kpss7] = kpsstest(d7, 'Lags', 7);

% Results table
Series = ["Raw"; "diff(1)"; "diff(7)"];

ADF_h = [h_adf; h_adf1; h_adf7];
ADF_p = [p_adf; p_adf1; p_adf7];

KPSS_h = [h_kpss; h_kpss1; h_kpss7];
KPSS_p = [p_kpss; p_kpss1; p_kpss7];

results = table(Series, ADF_h, ADF_p, KPSS_h, KPSS_p);

disp(results);

% Save results
if ~exist('outputs','dir')
    mkdir('outputs');
end

writetable(results, fullfile(projectRoot, 'outputs', 'stationarity_results.csv'));

% Plot all three series
figure;

subplot(3,1,1);
plot(y);
title('Raw Series');

subplot(3,1,2);
plot(d1);
title('First Difference');

subplot(3,1,3);
plot(d7);
title('Seasonal Difference (Lag 7)');

saveas(gcf, fullfile(projectRoot, 'outputs', '05_stationarity_plots.png'));


