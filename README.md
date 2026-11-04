# AI/ML-Based Demand Forecasting (SCM Project, ME F421)

Individual project for Supply Chain Management (ME F421), BITS Pilani, Hyderabad Campus.
Theme 2: Demand Prediction Using Advanced Forecasting Models.

Author: Boppana Sri Sai Siva Nandu (2024A4PS0640H)

## Overview
This project forecasts daily retail demand for one product and compares traditional
time-series methods with machine learning models.

- Dataset: Kaggle Store Item Demand Forecasting Challenge (5 years, 10 stores, 50 items)
- Series used: store 1, item 1 (1,826 daily observations, 2013-01-01 to 2017-12-31)
- Split: first 1,736 days for training, last 90 days for testing (chronological)
- Models: seasonal naive, SARIMA (two differencing settings), Holt-Winters, XGBoost, LSTM
- Metrics: MAE, RMSE, MAPE on the raw test values
- Stationarity (ADF and KPSS) was tested in MATLAB

Raw data: https://www.kaggle.com/c/demand-forecasting-kernels-only/data (not committed, 16.5 MB)

## Results (90-day test set)

| Model | Training data | MAE | RMSE | MAPE % |
|---|---|---|---|---|
| LSTM | raw | 3.88 | 4.66 | 24.32 |
| XGBoost | raw | 3.88 | 4.70 | 22.60 |
| SARIMA (d=0, D=1) | raw | 4.59 | 5.54 | 30.28 |
| Holt-Winters | raw | 4.67 | 5.66 | 31.01 |
| SARIMA (d=1, D=1) | raw | 4.92 | 6.06 | 33.23 |
| Seasonal naive | filtered | 5.28 | 6.56 | 35.83 |
| Seasonal naive | raw | 6.46 | 7.76 | 39.13 |

Full table (all 12 configurations): `outputs/results_all.csv`

## Key findings
1. LSTM and XGBoost are effectively tied for best (MAE 3.88), about 15% better than the best traditional model.
2. Stationarity tests show one difference (regular or seasonal) is enough. Using both (d=1, D=1) over-differences and hurts SARIMA.
3. Noise filtering of the training data helped only the seasonal naive benchmark and made every other model worse.
4. MAPE is inflated by small daily sales values, so MAE and RMSE are the more reliable metrics here.

## Repository structure
```
data/        series.csv, train_raw.csv, train_filtered.csv, test_raw.csv (train.csv not committed)
notebooks/   numbered notebooks, see run order below
matlab/      stationarity.m (ADF and KPSS tests)
outputs/     plots, prediction files and result tables
```

## Run order
1. `01_data_prep.ipynb` - extract store 1 / item 1 series
2. `02_eda.ipynb` - trend and seasonality plots
3. `03_preprocess_split.ipynb` - Hampel + moving average filter, 90-day split
4. `matlab/stationarity.m` - ADF and KPSS tests on the training data
5. `04_traditional_models.ipynb` - seasonal naive, SARIMA, Holt-Winters
6. `05_xgboost.ipynb` - XGBoost with lag and calendar features
7. `07_lstm.ipynb` - LSTM direct 90-day forecast
8. `06_evaluation.ipynb` - combined comparison (run after 07, it reads the LSTM results)

## Setup
```
pip install pandas numpy matplotlib statsmodels scikit-learn xgboost torch notebook
```
Download `train.csv` from Kaggle and place it in `data/`. MATLAB (Econometrics Toolbox) is needed only for `stationarity.m`.

