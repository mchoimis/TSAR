

# 19.2 상태공간 모형 평활법의 분석사례

# 1) 상태공간 모형 분석사례: 최적모형의 예측법(bats)3

# (1) 우연변동 시계열 예측

ba1 <- bats(dd1.ts)
baa1 <- forecast(ba1, h=4)
summary(baa1)

plot(baa1)

# (2) 추세변동 시계열 예측

ba3 <- bats(dd3.ts)
baa3 <- forecast(ba3, h=4)
summary(baa3)

Forecast method: BATS(1, {0,0}, 0.906, -)

Model Information:
BATS(1, {0,0}, 0.906, -)

Call: bats(y = dd3.ts)

Parameters
  Alpha: -0.1218335
  Beta: 0.01273946
  Damping Parameter: 0.905791

Seed States:
          [,1]
[1,] 1249.2132
[2,]   29.5649

Sigma: 94.92738
AIC: 252.0391

Error measures:
                    ME     RMSE      MAE       MPE    MAPE      MASE
Training set -21.30427 94.92738 82.02532 -2.083304 5.93297 0.5995455
                   ACF1
Training set -0.2192484

Forecasts:
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1504.098 1382.443 1625.752 1318.043 1690.152
2011 Q2       1506.839 1384.447 1629.231 1319.656 1694.021
2011 Q3       1509.322 1386.328 1632.315 1321.220 1697.423
2011 Q4       1511.570 1388.087 1635.054 1322.718 1700.422

plot(baa3)

# (3) 추세, 계절변동 시계열 예측

ba4 <- bats(dd4.ts)
baa4 <- forecast(ba4, h=4)
summary(baa4)

Forecast method: BATS(1, {0,0}, -, {4})

Model Information:
BATS(1, {0,0}, -, {4})

Call: bats(y = dd4.ts)

Parameters
  Alpha: 0.9427134
  Gamma Values: 0.4698814

Seed States:
           [,1]
[1,] 1290.78465
[2,]  192.46964
[3,]  109.28980
[4,]  -95.08961
[5,] -206.66982

Sigma: 34.81287
AIC: 215.9141

Error measures:
                   ME     RMSE      MAE      MPE     MAPE      MASE       ACF1
Training set 24.19154 34.81287 28.96939 1.657397 1.957745 0.2810856 -0.3216345

Forecasts:
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1635.043 1590.429 1679.658 1566.811 1703.275
2011 Q2       1713.539 1652.225 1774.853 1619.768 1807.310
2011 Q3       1912.953 1838.600 1987.306 1799.240 2026.665
2011 Q4       1953.402 1867.978 2038.826 1822.757 2084.046

plot(baa4)

# 2) 상태공간 모형 분석사례: 최적모형의 예측법(ets)

# (1) 우연변동 시계열 예측

fa1 <- ets(dd1.ts, model="ZZZ")
faa1 <- forecast(fa1, h=4)
summary(faa1)

plot(forecast(fa1))

# (2) 추세변동 시계열 예측

fa3 <- ets(dd3.ts, model="ZZZ")
faa3 <- forecast(fa3, h=4)
summary(faa3)

Forecast method: ETS(A,N,N) ###

Model Information:
ETS(A,N,N) 

Call:
 ets(y = dd3.ts, model = "ZZZ") 

  Smoothing parameters:
    alpha = 0.3687 

  Initial states:
    l = 1238.4164 

  sigma:  124.8947

     AIC     AICc      BIC 
256.9063 258.4063 259.8935 

Error measures:
                   ME     RMSE      MAE      MPE     MAPE     MASE       ACF1
Training set 35.84056 118.4855 92.42424 2.064671 6.385365 0.675554 -0.4001437

Forecasts:
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1502.688 1342.629 1662.747 1257.898 1747.477
2011 Q2       1502.688 1332.097 1673.278 1241.792 1763.583
2011 Q3       1502.688 1322.179 1683.196 1226.624 1778.751
2011 Q4       1502.688 1312.779 1692.597 1212.247 1793.128

plot(forecast(fa3))

# (3) 추세, 계절변동 시계열 예측

fa4 <- ets(dd4.ts, model="ZZZ")
faa4 <- forecast(fa4, h=4)
summary(faa4)

Forecast method: ETS(A,A,A) ###

Model Information:
ETS(A,A,A) 

Call:
 ets(y = dd4.ts, model = "ZZZ") 

  Smoothing parameters:
    alpha = 0.0123 
    beta  = 1e-04 
    gamma = 0.0016 

  Initial states:
    l = 1284.2801 
    b = 25.4738 
    s = 165.4518 99.6397 -87.1279 -177.9636

  sigma:  12.7398

     AIC     AICc      BIC 
169.4873 187.4873 178.4489 

Error measures:
                    ME     RMSE      MAE         MPE      MAPE      MASE
Training set 0.0257002 9.868199 8.927748 0.009006993 0.5890431 0.0866246
                   ACF1
Training set -0.2482756

Forecasts:
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1641.288 1624.961 1657.615 1616.318 1666.257
2011 Q2       1757.603 1741.275 1773.931 1732.631 1782.574
2011 Q3       1969.824 1953.495 1986.154 1944.851 1994.798
2011 Q4       2061.088 2044.758 2077.419 2036.113 2086.064

plot(forecast(fa4))

