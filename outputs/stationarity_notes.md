# Stationarity analysis (training data, store 1 / item 1)

| Series | ADF | KPSS | Conclusion |
|---|---|---|---|
| Raw | reject unit root (p <= 0.001) | reject stationarity (p <= 0.01) | Non-stationary |
| diff(1) | reject unit root (p <= 0.001) | do not reject (p >= 0.1) | Stationary |
| diff(7) | reject unit root (p <= 0.001) | do not reject (p >= 0.1) | Stationary |

Notes:
- MATLAB clips p-values at its table limits, so they are reported as bounds.
- ADF with 7 lags on diff(7) gave an invalid-statistic warning (over-differencing at the weekly cycle).
- Decision: SARIMA tested with (d=0, D=1) and (d=1, D=1); the better setting is chosen by test error.

Screenshots: outputs/05_stationarity_table.png, outputs/05_stationarity_plots.png
