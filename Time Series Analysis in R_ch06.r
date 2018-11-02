
# 6.2 지수 평활법의 분석사례

# 1) 단순 지수평활법 분석사례: 고정된 alpha 값 사용

> dd1.ts <- ts(data=dd1, start=c(2006, 1), frequency=4)
> ho <- HoltWinters(dd1.ts, alpha=0.1, beta=F, gamma=F) # 평활화 지수 0.1로 하는 단순 지수평활
> ho
Holt-Winters exponential smoothing without trend and without seasonal component.

Call:
HoltWinters(x = dd1.ts, alpha = 0.1, beta = F, gamma = F)

Smoothing parameters:
 alpha: 0.1
 beta : FALSE # without trend
 gamma: FALSE # without seasonal

Coefficients:
      [,1]
a 1334.816

> summary(ho)
             Length Class  Mode     
fitted       38     mts    numeric  
x            20     ts     numeric  
alpha         1     -none- numeric  
beta          1     -none- logical  
gamma         1     -none- logical  
coefficients  1     -none- numeric  
seasonal      1     -none- character
SSE           1     -none- numeric  
call          5     -none- call

> ho$fitted # fitted(ho) 와 동일한 명령어
            xhat    level
2006 Q2 1342.000 1342.000
2006 Q3 1352.000 1352.000
2006 Q4 1342.000 1342.000
2007 Q1 1342.100 1342.100
2007 Q2 1350.390 1350.390
2007 Q3 1351.551 1351.551
2007 Q4 1361.996 1361.996
2008 Q1 1352.996 1352.996
2008 Q2 1341.997 1341.997
2008 Q3 1343.697 1343.697
2008 Q4 1350.527 1350.527
2009 Q1 1340.775 1340.775
2009 Q2 1326.797 1326.797
2009 Q3 1341.917 1341.917
2009 Q4 1339.926 1339.926
2010 Q1 1346.533 1346.533
2010 Q2 1337.280 1337.280
2010 Q3 1332.452 1332.452
2010 Q4 1348.907 1348.907

# 2) 단순 지수평활법 분석사례: HoltWinters(beta=False, gamma=False)

## (1) 자료입력 및 단순 지수 평활법 분석

> ha <- HoltWinters(dd1.ts, beta=F, gamma=F) # alpha 값이 없는 단순 지수평활 
> ha
Holt-Winters exponential smoothing without trend and without seasonal component.

Call:
HoltWinters(x = dd1.ts, beta = F, gamma = F)

Smoothing parameters:
 alpha: 6.610696e-05 # HoltWinters가 찾은 최적화된 alpha 값
 beta : FALSE
 gamma: FALSE

Coefficients:
      [,1]
a 1341.998

## (2) 분석 결과의 추정 

> names(ha) #분석결과의 구분
[1] "fitted"       "x"            "alpha"        "beta"         "gamma"        "coefficients" "seasonal"    
[8] "SSE"          "call" 

> ha$SSE # 잔차의 제곱합 # ho$SSE ==  177568.1 이었음  
[1] 161614.6

> ho$SSE > ha$SSE # 간단한 비교 불리언 값으로 # SSE는 () 처리가 안되네  
[1] TRUE

> ha$fitted # 분석결과 추정값
            xhat    level
2006 Q2 1342.000 1342.000
2006 Q3 1342.007 1342.007
2006 Q4 1342.001 1342.001
2007 Q1 1342.001 1342.001
2007 Q2 1342.006 1342.006
2007 Q3 1342.008 1342.008
2007 Q4 1342.015 1342.015
2008 Q1 1342.010 1342.010
2008 Q2 1342.004 1342.004
2008 Q3 1342.005 1342.005
2008 Q4 1342.010 1342.010
2009 Q1 1342.004 1342.004
2009 Q2 1341.994 1341.994
2009 Q3 1342.003 1342.003
2009 Q4 1342.002 1342.002
2010 Q1 1342.006 1342.006
2010 Q2 1342.001 1342.001
2010 Q3 1341.997 1341.997
2010 Q4 1342.007 1342.007

plot(ha)
title("\n \n - Simple Exponential Smoothing -") # 분석결과 그래프

## (3) 예측 결과에 대한 잔차 분석

# library(forecast) #
fa <- forecast(ha)
names(fa)
 [1] "method"    "model"     "level"     "mean"     
 [5] "lower"     "upper"     "x"         "series"   
 [9] "fitted"    "residuals"

tsdisplay(fa$residuals)
Box.test(fa$residuals, type="Box-Pierce")

	Box-Pierce test

data:  fa$residuals
X-squared = 2.0761, df = 1, p-value = 0.1496

hist(fa$residuals, 10, probability=T, col="light blue", 
	xlab="Time", ylab="Residuals", main="Histograms of Residuals")
points(density(fa$residuals[-1], bw=30), type="l", col="red", lwd=2)
title("\n \n - Simple Exponential Smoothing -") # \n 은 줄바꿈의 뜻

## (4) 예측 결과

fa <- forecast(ha, h=4)
fa
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1341.998 1220.576 1463.421 1156.299 1527.698
2011 Q2       1341.998 1220.576 1463.421 1156.299 1527.698
2011 Q3       1341.998 1220.576 1463.421 1156.299 1527.698
2011 Q4       1341.998 1220.576 1463.421 1156.299 1527.698

accuracy(fa)
                    ME     RMSE      MAE        MPE     MAPE      MASE       ACF1
Training set -1.267407 92.22816 81.26555 -0.5680335 6.088734 0.7626093 -0.3305546

plot(forecast(ha, h=4))
lines(fa$fitted, col="red", lty=2, lwd=2)

plot(forecast(ha, h=4, fan=T)) # fan plot은 51-99% 유의 수준을 표시한 것 
lines(fa$fitted, col="red", lty=2, lwd=2)

# 3) 추세변동을 고려한 지수평활법 분석사례: HoltWinters(gamma=False)

## (1) 자료입력 및 단순 지수 평활법 분석

dd3 <- matrix( c(1142, 1242, 1252, 1343, 
				1225, 1562, 1356, 1572,
				1343, 1459, 1412, 1453,
				1401, 1478, 1322, 1606,
				1554, 1589, 1597, 1408))

dd3.ts <- ts(dd3, s=c(2006, 1), f=4)

( hb <- HoltWinters(dd3.ts, g=F) )
Holt-Winters exponential smoothing with trend and without seasonal component.

Call:
HoltWinters(x = dd3.ts, gamma = F)

Smoothing parameters:
 alpha: 0.2272783
 beta : 1 # with trend
 gamma: FALSE # witout seasonal

Coefficients:
         [,1]
a 1614.777636
b    4.278506

## (2) 분석 결과의 추정 

names(hb)
[1] "fitted"       "x"            "alpha"        "beta"         "gamma"       
[6] "coefficients" "seasonal"     "SSE"          "call"

hb$SSE
[1] 313861.9

hb$fitted
            xhat    level      trend
2006 Q3 1342.000 1242.000 100.000000
2006 Q4 1401.090 1321.545  79.544957
2007 Q1 1454.230 1387.887  66.342382
2007 Q2 1416.374 1402.131  14.243450
2007 Q3 1496.813 1449.472  47.341020
2007 Q4 1480.146 1464.809  15.337325
2008 Q1 1537.236 1501.023  36.213638
2008 Q2 1485.159 1493.091  -7.932075
2008 Q3 1465.336 1479.213 -13.877361
2008 Q4 1427.214 1453.214 -25.999469
2009 Q1 1412.936 1433.075 -20.138962
2009 Q2 1387.371 1410.223 -22.851742
2009 Q3 1405.715 1407.969  -2.253836
2009 Q4 1365.408 1386.689 -21.280547
2010 Q1 1453.490 1420.090  33.400731
2010 Q2 1532.578 1476.334  56.244414
2010 Q3 1614.470 1545.402  69.067831
2010 Q4 1675.597 1610.499  65.097374

plot(hb)
title("\n \n - Trend & Simple Exponential Smoothing -")

## (3) 예측 결과에 대한 잔차 분석

fb <- forecast(hb)
tsdisplay(fb$residuals)
Box.test(fb$residuals, type= "B")

	Box-Pierce test

data:  fb$residuals
X-squared = 0.66947, df = 1, p-value = 0.4132

hist(fb$residuals, 10, probability=T, col="light blue",
	xlab="Time", ylab="Residuals", main="Histograms of Residuals")
points(density(fb$residuals[-1:-2], bw=30), type="l", col="red", lwd=2) # 잔차 내 missing value 처리! 
title("\n \n - Trend & Simple Exponential Smoothing -")

## (4) 예측 결과 

( fb <- forecast(hb, h=4) )
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1619.056 1447.679 1790.434 1356.957 1881.155
2011 Q2       1623.335 1435.083 1811.587 1335.428 1911.241
2011 Q3       1627.613 1406.044 1849.182 1288.752 1966.474
2011 Q4       1631.892 1361.028 1902.755 1217.642 2046.142

accuracy (fb <- forecast(hb, h=4))
                    ME     RMSE      MAE       MPE     MAPE      MASE       ACF1
Training set -23.39802 132.0484 106.8888 -2.214214 7.555547 0.7812792 -0.1928539

plot(forecast(hb, h=4))
lines(fb$fitted, col="red", lty=2, lwd=2)

plot(forecast(hb, h=4, fan=T))
lines(fb$fitted, col="red", lty=2, lwd=2)


# 4) 계절, 추세변동을 고려한 지수 평활법 분석사례: HoltWinters(무제약)

## (1) 자료입력 및 단순 지수 평활법 분석

dd4 <- matrix( c(1142, 1242, 1452, 1543,
				1225, 1362, 1556, 1672,
				1343, 1459, 1662, 1753,
				1421, 1558, 1772, 1846, 
				1554, 1649, 1877, 1948))

dd4.ts <- ts(dd4, s=c(2006, 1), f=4)
( hc <- HoltWinters(dd4.ts) ) # 무제약 
Holt-Winters exponential smoothing with trend and additive seasonal component.

Call:
HoltWinters(x = dd4.ts)

Smoothing parameters:
 alpha: 0.6581644
 beta : 0 # with trend
 gamma: 0.2821196 # with seasonal 

Coefficients:
         [,1]
a  1790.67689
b    27.55000
s1 -178.84179 # 계절변동   
s2  -78.54490 # s1, s2, s3, s4의 값으로 산정 
s3   99.66519 # frequency = 4로 판단되었다
s4  161.13768 # 제9장 decompose 참조

## (2) 분석 결과의 추정

names(hc)
[1] "fitted"       "x"            "alpha"        "beta"         "gamma"       
[6] "coefficients" "seasonal"     "SSE"          "call"  

hc$SSE
[1] 6975.006 # 상당히 작은 값으로 판단됨 # plot에서도 판단됨 

hc$fitted
            xhat    level trend     season
2007 Q1 1170.550 1326.562 27.55 -183.56250
2007 Q2 1341.812 1389.950 27.55  -75.68750
2007 Q3 1555.149 1430.787 27.55   96.81250
2007 Q4 1648.884 1458.897 27.55  162.43750
2008 Q1 1350.899 1501.661 27.55 -178.31142
2008 Q2 1477.821 1524.012 27.55  -73.74060
2008 Q3 1663.619 1539.174 27.55   96.89457
2008 Q4 1757.876 1565.659 27.55  164.66676
2009 Q1 1438.477 1590.000 27.55 -179.07321
2009 Q2 1558.042 1606.047 27.55  -75.55568
2009 Q3 1757.858 1633.570 27.55   96.73844
2009 Q4 1862.174 1670.427 27.55  164.19657
2010 Q1 1534.124 1687.332 27.55 -180.75864
2010 Q2 1679.954 1727.964 27.55  -75.55970
2010 Q3 1860.793 1735.141 27.55   98.10224
2010 Q4 1963.544 1773.358 27.55  162.63677

plot(hc)
title("\n \n - Trend, Seasonal & Simple Exponential Smoothing -")

## (3) 예측 결과에 대한 잔차 분석

fc <- forecast(hc)
tsdisplay(fc$residuals)
Box.test(fc$residuals, t="B")

	Box-Pierce test

data:  fc$residuals
X-squared = 0.16034, df = 1, p-value = 0.6888

hist(fc$residuals, 10, probability=T, col="light blue",
	xlab="Time", ylab="Residuals", main="Histograms of Residuals")
points(density(fc$residuals[-1:-4], bw=30), type="l", col="red", lwd=2)
title("\n \n - Trend, Seasonal & Simple Exponential Smoothing -")

## (4) 예측 결과 

( fc <- forecast(hc, h=4) )
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1639.385 1611.906 1666.865 1597.359 1681.411
2011 Q2       1767.232 1734.335 1800.129 1716.920 1817.544
2011 Q3       1972.992 1935.451 2010.533 1915.578 2030.406
2011 Q4       2062.015 2020.344 2103.685 1998.285 2125.744

accuracy (fc <- forecast(hc, h=4))
                  ME     RMSE      MAE       MPE     MAPE      MASE       ACF1
Training set 2.21396 20.87913 16.38973 0.2042069 1.083904 0.1590271 -0.1001062

plot(forecast(hc, h=4)) # 일반 예측 그래프는 80%, 95% 유의수준
lines(fc$fitted, col="red", lty=2, lwd=2) 

plot(forecast(hc, h=4, fan=T)) # fan plot은 51-99% 유의수준 표시
lines(fc$fitted, col="red", lty=2, lwd=2)

# 5) 단순 시계열 예측사례(단순 지수 평활의 예측): ses

# (1) 분석 자료 및 기본수식


# (2) 분석 결과

sa <- ses(dd1.ts)
summary(sa)

Forecast method: Simple exponential smoothing

Model Information:
Simple exponential smoothing 

Call:
 ses(y = dd1.ts) 

  Smoothing parameters:
    alpha = 1e-04 # 0에 가가까우며, 이에 따라 분석모형은 iid 모형이 됨

  Initial states:
    l = 1340.8032 

  sigma:  89.8864

     AIC     AICc      BIC 
245.8565 247.3565 248.8437 

Error measures:
                      ME     RMSE      MAE        MPE     MAPE      MASE       ACF1
Training set -0.01040481 89.88642 77.32325 -0.4502158 5.788169 0.7256141 -0.3298061

Forecasts:
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1340.803 1225.609 1455.997 1164.629 1516.977
2011 Q2       1340.803 1225.609 1455.997 1164.629 1516.977
2011 Q3       1340.803 1225.609 1455.997 1164.629 1516.977
2011 Q4       1340.803 1225.609 1455.997 1164.629 1516.977
2012 Q1       1340.803 1225.609 1455.997 1164.629 1516.977
2012 Q2       1340.803 1225.609 1455.997 1164.629 1516.977
2012 Q3       1340.803 1225.609 1455.997 1164.629 1516.977
2012 Q4       1340.803 1225.609 1455.997 1164.629 1516.977
2013 Q1       1340.803 1225.609 1455.997 1164.629 1516.977
2013 Q2       1340.803 1225.609 1455.997 1164.629 1516.97

# (3) 예측 결과 

forecast(sa, h=4)
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1340.803 1225.609 1455.997 1164.629 1516.977
2011 Q2       1340.803 1225.609 1455.997 1164.629 1516.977
2011 Q3       1340.803 1225.609 1455.997 1164.629 1516.977
2011 Q4       1340.803 1225.609 1455.997 1164.629 1516.977

accuracy(sa)
                     ME     RMSE      MAE        MPE     MAPE      MASE       ACF1
Training set -0.01040481 89.88642 77.32325 -0.4502158 5.788169 0.7256141 -0.3298061

plot(forecast(sa, h=4))
lines(sa$fitted, col="red", lty=2, lwd=2)

plot(forecast(sa, h=4, fan=T))
lines(sa$fitted, col="red", lty=2, lwd=2)

# 6) 단순 시계열 예측사례(단순 지수 평활의 Drift 예측): thetaf

# (1) 분석 자료 및 기본수식

# (2) 분석 결과

ss <- thetaf(dd1.ts, h=4)
summary(ss)

Forecast method: Theta

Model Information:
$alpha
       alpha 
0.0001000005 

$drift
        X 
-1.090226 

$sigma
[1] 8079.568

$call
thetaf(y = dd1.ts, h = 4)


Error measures:
                      ME     RMSE      MAE        MPE     MAPE      MASE       ACF1
Training set -0.01040481 89.88642 77.32325 -0.4502158 5.788169 0.7256141 -0.3298061

Forecasts:
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1319.019 1203.825 1434.213 1142.845 1495.193
2011 Q2       1317.929 1202.735 1433.123 1141.755 1494.103
2011 Q3       1316.839 1201.645 1432.033 1140.665 1493.013
2011 Q4       1315.749 1200.555 1430.943 1139.575 1491.923

# (3) 예측 결과 

forecast(ss, h=4)
accuracy(ss)
                      ME     RMSE      MAE        MPE     MAPE      MASE       ACF1
Training set -0.01040481 89.88642 77.32325 -0.4502158 5.788169 0.7256141 -0.3298061

plot(forecast(ss, h=4))
lines(ss$fitted, col="red", lty=2, lwd=2)

plot(forecast(ss, h=4, fan=T))
lines(ss$fitted, col="red", lty=2, lwd=2)

# 7) 단순 시계열 예측사례(지수 평활의 예측): ets 

# Exponential smoothing state space model
# ets == error, trend, seasonal 뜻함 
# error               trend               seasonal
# A: additive         N: none             N: none
# M: Multiplicative   A: additive         A: Additive
# Z: Autoatically     M: Multiplicative   M: Multiplicative
#                     Z: Autoatically     Z: Autoatically

# 예: ets(A, N, N) 단순 지수 평활 선형 모형 (Simple Exponential)
# 예: ets(A, A, N) 추세변동 고려 Holt Linear 모형 
# 예: ets(A, A, A) 추세, 계절변동 고려 Holt Winter's Linear 모형 
# 예: ets(M, N, N) 단순 지수 평활 비선형 (승법) 모형 

# (1) 분석자료 및 정상성 검정

library(TSA)
data(oilfilters)
library(tseries)
kpss.test(oilfilters) 

  KPSS Test for Level Stationarity

data:  oilfilters
KPSS Level = 0.087776, Truncation lag parameter = 1, p-value = 0.1 # 정상성 H0 채택 

kpss.test(oilfilters, "Trend")

  KPSS Test for Trend Stationarity

data:  oilfilters
KPSS Trend = 0.058515, Truncation lag parameter = 1, p-value = 0.1 # 추세를 고려한 정상성 H0 채택

tsdisplay(oilfilters, main="Oil Filters / Month (1983-1987)") # 자기 상관 존재
# ACF 그래프에서는 진동을 나타내고 있으며 Time Lag 1, 5, 12의 값이 임계값 넘었다 
# PACF 그래프에서는 Time Lag 1, 4, 12의 값이 임계를 넘었다

# (2) ets에 의한 예측 

( ee <- ets(oilfilters) )
ETS(A,N,A) 

Call:
 ets(y = oilfilters) 

  Smoothing parameters:
    alpha = 0.1201 
    gamma = 2e-04 

  Initial states:
    l = 3738.2874 
    s=393.8923 316.4413 1146.749 -407.0074 1799.935 2137.056
           -1015.478 -1200.843 -996.3706 -1269.626 -714.1204 -190.6279

  sigma:  615.1592

     AIC     AICc      BIC 
832.3182 847.3182 860.3863 

( ff <- forecast(ee) ) # ets 모형에서 예측기간의 지정이 없으면 디폴트로 h=24 (24개 lag) 예측이 수행된다
         Point Forecast    Lo 80    Hi 80     Lo 95    Hi 95
Jul 1987       3035.208 2246.850 3823.566 1829.5181 4240.898
Aug 1987       2511.817 1717.791 3305.844 1297.4586 3726.176
Sep 1987       1956.444 1156.790 2756.099  733.4780 3179.410
Oct 1987       2229.633 1424.390 3034.877  998.1197 3461.147
Nov 1987       2025.092 1214.298 2835.886  785.0903 3265.094
Dec 1987       2210.505 1394.199 3026.811  962.0723 3458.937
Jan 1988       5362.998 4541.217 6184.780 4106.1920 6619.805
Feb 1988       5026.043 4198.822 5853.264 3760.9177 6291.168
Mar 1988       2818.948 1986.323 3651.572 1545.5585 4092.337
Apr 1988       4372.761 3534.767 5210.754 3091.1603 5654.361
May 1988       3542.409 2699.081 4385.738 2252.6503 4832.169
Jun 1988       3619.561 2770.914 4468.208 2321.6670 4917.455
Jul 1988       3035.208 2181.293 3889.123 1729.2573 4341.159
Aug 1988       2511.817 1652.666 3370.969 1197.8591 3825.776
Sep 1988       1956.444 1092.089 2820.799  634.5268 3278.362
Oct 1988       2229.633 1360.105 3099.161  899.8044 3559.462
Nov 1988       2025.092 1150.421 2899.763  687.3987 3362.785
Dec 1988       2210.505 1330.722 3090.288  864.9926 3556.017
Jan 1989       5362.998 4478.133 6247.864 4009.7130 6716.284
Feb 1989       5026.043 4136.123 5915.962 3665.0282 6387.057
Mar 1989       2818.948 1924.003 3713.893 1450.2479 4187.648
Apr 1989       4372.761 3472.819 5272.703 2996.4182 5749.103
May 1989       3542.409 2637.498 4447.321 2158.4666 4926.352
Jun 1989       3619.561 2709.690 4529.431 2228.0338 5011.088

plot(ff)
Box.test(ff$resid, type="L")

  Box-Ljung test

data:  ff$resid
X-squared = 0.10694, df = 1, p-value = 0.7437

# (3) ets 모형으로 추정한 값 및 시뮬레이션

plot(oilfilters, ylim=c(1500, 7000), main="Oil Filter")
plot(oilfilters, ylim=c(1500, 7000), main="Oil Filter: Fitted values", lty=2) 
lines(fitted(ee, h=2), col=1)
lines(fitted(ee, h=3), col=2)
legend("topleft", 
      legend=paste("h =", 2:3), 
      col=1:2, 
      lty=1)


## h에 따라 exponential smoothing 한(fitted) 값 바뀜 
> oilfilters
      Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec
1983                               2385 3302 3958 3302 2441 3107
1984 5862 4536 4625 4492 4486 4005 3744 2546 1954 2285 1778 3222
1985 5472 5310 1965 3791 3622 3726 3370 2535 1572 2146 2249 1721
1986 5357 5811 2436 4608 2871 3349 2909 2324 1603 2148 2245 1586
1987 5332 5787 2886 5475 3843 2537                              

> fitted(ee) # ee <- ets(oilfilters)
          Jan      Feb      Mar      Apr      May      Jun      Jul      Aug      Sep      Oct      Nov      Dec
1983                                                       3547.660 2884.495 2379.145 2842.070 2692.850 2847.960
1984 6031.613 5674.116 3330.450 5039.723 4143.616 4262.198 3646.545 3135.080 2509.042 2715.393 2459.072 2562.723
1985 5794.370 5418.326 3198.863 4604.020 3676.224 3747.039 3159.828 2661.765 2091.273 2301.946 2078.544 2284.761
1986 5369.284 5030.535 2917.616 4413.227 3606.651 3595.613 2981.350 2449.279 1878.886 2118.871 1917.769 2142.671
1987 5228.157 4903.519 2802.720 4366.330 3669.354 3767.650                                                      
> fitted(ee, h=2)
          Jan      Feb      Mar      Apr      May      Jun      Jul      Aug      Sep      Oct      Nov      Dec
1983                                                             NA       NA 2328.990 2652.400 2637.598 2878.215
1984 6000.494 5694.492 3467.174 4884.206 4209.415 4221.067 3677.443 3123.372 2579.809 2782.071 2510.776 2644.541
1985 5715.170 5457.053 3211.876 4752.246 3773.893 3753.553 3162.356 2636.516 2106.501 2364.327 2097.278 2264.284
1986 5437.010 5032.011 2823.857 4471.084 3583.253 3683.988 3010.976 2457.970 1893.936 2152.013 1914.269 2103.360
1987 5295.031 4891.044 2696.586 4356.325 3536.167 3746.789                                                      
> fitted(ee, h=3)
          Jan      Feb      Mar      Apr      May      Jun      Jul      Aug      Sep      Oct      Nov      Dec
1983                                                             NA       NA       NA 2602.245 2447.927 2822.963
1984 6030.749 5663.373 3487.550 5020.930 4053.899 4286.866 3636.312 3154.270 2568.102 2852.838 2577.454 2696.245
1985 5796.988 5377.853 3250.603 4765.260 3922.119 3851.223 3168.870 2639.044 2081.253 2379.555 2159.659 2283.018
1986 5416.533 5099.736 2825.333 4377.326 3641.110 3660.589 3099.351 2487.596 1902.627 2167.063 1947.412 2099.861
1987 5255.720 4957.918 2684.111 4250.191 3526.163 3613.603                                                      



(s1 <- simulate(ee, 30))
          Jan      Feb      Mar      Apr      May      Jun      Jul      Aug      Sep      Oct      Nov      Dec
1987                                                       2300.241 2110.073 1584.536 1567.207 1683.754 2045.277
1988 4566.062 4504.776 2845.944 3849.716 3601.407 3725.072 2858.673 2869.057 1401.509 1245.660 1866.508 1033.047
1989 5457.500 4671.272 3801.142 4248.195 2793.304 3032.022 3045.919 2456.742 2190.232 1231.022 1672.345 1458.577

(s2 <- simulate(ee, 30, bootstrap=T))
          Jan      Feb      Mar      Apr      May      Jun      Jul      Aug      Sep      Oct      Nov      Dec
1987                                                       2604.773 1993.903 2132.340 2190.603 3153.114 1825.992
1988 6579.752 4730.262 3899.244 5013.613 3797.687 3908.474 3141.166 3181.973 2453.345 2056.708 2129.537 1384.222
1989 5140.318 4456.737 1674.018 3734.947 2878.450 3872.151 3190.036 2619.963 2022.844 1739.152 1421.622 1990.785

plot(forecast(ee), xlim=c(1984, 1990), main="Oil Filter: Forecast")
plot(oilfilters, xlim=c(1984, 1990), main="Oil Filter: Simulation")
lines(s1, col="red", lwd=2); lines(s2, col="blue", lwd=2)
legend("topleft", 
      legend=c("Simulation", "bootstrap"), 
      col=c(2,4), 
      lty=1)

