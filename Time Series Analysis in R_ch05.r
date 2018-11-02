
# 상태 공간 모형(state space model)이란 시계열 생성 구조를 다음과 같이 
# 상태 전이식(state transition equation)과 관측식(observation equation)이라는 
# 두 개의 수식으로 정의하는 시계열 모형을 말한다.

# 상태 전이식(state transition equation)
# 상태 전이식은 이전의 상태  xt−1 와 현재 생성된 innovation 입력  wt 에 의해 
# 현재의 상태  xt 가 생성되는 관계를 표현한 식이다.

# xt=f(xt−1,wt)
 
# 관측식(observation equation)
# 관측식은 현재의 상태  xt 와 관측 잡음  vt 에 의해 실제로 측정가능한 출력  yt 가 생성되는 관계를 표현한 식이다.

# yt=g(xt,vt)
 
# 동적 선형 모형 (DLM: Dynamic Linear Model)
# 동적 선형 모형은 상태 전이식과 관측식을 모두 선형 행렬 방정식으로 표현할 수 있는 모형으로 
# 선형 상태 공간 모형(linear state space model)이라고도 불린다. 
# 또 선형 동적 모형에서는 innovation 과정과 관측 잡음 과정이 가우시안 백색 잡음이라고 가정한다.

# 이 식에서 사용된 기호는 다음과 같다.

# xt∈RN  상태 변수 벡터
# Φt∈RN×N  전이 행렬(transition matrix)
# wt∈RN  innovation (또는 shock 벡터)
# Wt∈RN×N  innovation 공분산 (covariance) 행렬
# yt∈RM  출력 벡터
# At∈RN×M  관측 행렬(measurement matrix) 또는 설계 행렬(design matrix)
# vt∈RM  관측 잡음 벡터
# Vt∈RM×M  관측 잡음 공분산 (covariance) 행렬

# 상태 공간 모형의 예¶
# 히든 마코프 모형 (HMM: Hidden Markov Model)
# 상태 공간 모형에서 상태 변수  x 의 값이 연속 확률 변수가 아니라 1차원 이산 확률 변수(discrete random variable)인 경우에는 
# 히든 마코프 모형이 된다. 히든 마코프 모형의 상태 전이식은 다음과 같은 조건부 확률로 정의된다.

# P(xt=xi|xt−1=xj)
 
# 히든 마코프 모형은 주로 음성 처리에서 많이 사용되지만 
# 경제학 분야에서도 구조적 변화에 의한 시계열 특성이 변화하는 경우에 사용된다.

# 확률적 변동성 모형
# 주가(stock price) 등의 금융 시계열 모형으로 많이 사용되는 확률적 변동성 모형(stochastic volatility model)도 
# 상태 공간 모형의 한 예라고 볼 수 있다. 확률적 변동성 모형은 ARCH(Autoregressive conditional heteroskedasticity) 
# 혹은 GARCH(Generalized Autoregressive conditional heteroskedasticity) 모형과 달리 
# 변동성 자체를 하나의 독립적인 상태 변수로 가정한다. 확률적 변동성 모형 중 널리 사용되는 Heston 모형은 
# 다음과 같이 분산(variance) 상태 변수  ν 를 가지는 연속 시간 모형이다.

# 상태 공간 모형의 응용
# 상태 공간 모형을 사용하는 것은 기존의 예측 문제와 더불어 현재 혹은 상태 변수 값을 추정하는 것을 목표로 한다는 것을 뜻한다. 
# 이를 필터링(filtering) 문제와 스무딩(smoothing) 문제라고 한다.

# 필터링(filtering) 문제는 현재까지 수집한 관측치  y1,⋯,yt 를 이용해서 현재의 상태 변수 값  xt 을 추정하는 문제이다. 
# 필터링 문제는 앞에서 예를 들었던 지표면 온도에서 실제 온도를 추정하는 단순한 문제부터 
# 관측 잡음이 있는 GPS 신호를 기반으로 현재의 정확한 위치를 추정하는 항법 장치까지 널리 사용된다.

# 스무딩(smoothing) 문제는 필터링 문제와 달리 현재까지 수집한 관측치  y1,⋯,yt 를 이용해서 
# 현재까지의 상태 변수 히스토리  x1,⋯,xt 을 전체를 모두 재추정하는 문제를 말한다. 
# 금융 분야에서 팩터 모형(factor model)의 계수를 추정하는 문제도 스무딩 문제에 속한다. 
# 또한 시계열 자료 중 누락된 자료(missing data)가 있는 경우에도 스무딩 문제 해결을 통해 누락된 자료를 추정할 수 있다.




# 5.2 이동평균 평활법(MA smoothing)의 분석사례 

# 1) 이동평균 평활법 분석사례: filter EDA

# AirPassenger

> data("AirPassengers")
> AirPassengers
     Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
1949 112 118 132 129 121 135 148 148 136 119 104 118
1950 115 126 141 135 125 149 170 170 158 133 114 140
1951 145 150 178 163 172 178 199 199 184 162 146 166
1952 171 180 193 181 183 218 230 242 209 191 172 194
1953 196 196 236 235 229 243 264 272 237 211 180 201
1954 204 188 235 227 234 264 302 293 259 229 203 229
1955 242 233 267 269 270 315 364 347 312 274 237 278
1956 284 277 317 313 318 374 413 405 355 306 271 306
1957 315 301 356 348 355 422 465 467 404 347 305 336
1958 340 318 362 348 363 435 491 505 404 359 310 337
1959 360 342 406 396 420 472 548 559 463 407 362 405
1960 417 391 419 461 472 535 622 606 508 461 390 432

> ma3 <- filter(AirPassengers, filter=rep(1/3, 3)) # 
> ma3
          Jan      Feb      Mar      Apr      May      Jun      Jul      Aug      Sep      Oct      Nov      Dec
1949       NA 120.6667 126.3333 127.3333 128.3333 134.6667 143.6667 144.0000 134.3333 119.6667 113.6667 112.3333
1950 119.6667 127.3333 134.0000 133.6667 136.3333 148.0000 163.0000 166.0000 153.6667 135.0000 129.0000 133.0000
1951 145.0000 157.6667 163.6667 171.0000 171.0000 183.0000 192.0000 194.0000 181.6667 164.0000 158.0000 161.0000
1952 172.3333 181.3333 184.6667 185.6667 194.0000 210.3333 230.0000 227.0000 214.0000 190.6667 185.6667 187.3333
1953 195.3333 209.3333 222.3333 233.3333 235.6667 245.3333 259.6667 257.6667 240.0000 209.3333 197.3333 195.0000
1954 197.6667 209.0000 216.6667 232.0000 241.6667 266.6667 286.3333 284.6667 260.3333 230.3333 220.3333 224.6667
1955 234.6667 247.3333 256.3333 268.6667 284.6667 316.3333 342.0000 341.0000 311.0000 274.3333 263.0000 266.3333
1956 279.6667 292.6667 302.3333 316.0000 335.0000 368.3333 397.3333 391.0000 355.3333 310.6667 294.3333 297.3333
1957 307.3333 324.0000 335.0000 353.0000 375.0000 414.0000 451.3333 445.3333 406.0000 352.0000 329.3333 327.0000
1958 331.3333 340.0000 342.6667 357.6667 382.0000 429.6667 477.0000 466.6667 422.6667 357.6667 335.3333 335.6667
1959 346.3333 369.3333 381.3333 407.3333 429.3333 480.0000 526.3333 523.3333 476.3333 410.6667 391.3333 394.6667
1960 404.3333 409.0000 423.6667 450.6667 489.3333 543.0000 587.6667 578.6667 525.0000 453.0000 427.6667       NA

> (112+118+132)/3 # 1949년 2월의 3점 이동평균 평활값 # 중심 있음
[1] 120.6667

ma6 <- filter(AirPassengers, filter=rep(1/6, 6))
ma12 <- filter(AirPassengers, f=rep(1/12, 12))

par(mfrow=c(4, 1)) 
plot(AirPassengers, main="Air Passengers: Original Data")
plot(ma3, main="3-points Moving Average")
plot(ma6, main="6-points Moving Average")
plot(ma12, main="12-points Moving Average")

# Milk

library(TSA) 
data(milk)

mm3 <- filter(milk, f=rep(1/3, 3))
mm6 <- filter(milk, f=rep(1/6, 6))
mm12 <- filter(milk, f=rep(1/12, 12))

par(mfcol=c(4, 2)) # mfcol 사용해서 컬럼별로 나눔
plot(milk, main="Milk: Original Data")
plot(mm3, main="3-points Moving Average")
plot(mm6, main="6-points Moving Average")
plot(mm12, main="12-points Moving Average")

plot(AirPassengers, main="Air Passengers: Original Data")
plot(ma3, main="3-points Moving Average")
plot(ma6, main="6-points Moving Average")
plot(ma12, main="12-points Moving Average")

# 2) 이동평균 평활법 분석사례: filter

# 단순 이동평균 평활법(Simple Moving Average Smoothing) 

dd1
     Qtr1 Qtr2 Qtr3 Qtr4
2006 1342 1442 1252 1343
2007 1425 1362 1256 1272
2008 1243 1359 1412 1253
2009 1201 1478 1322 1406
2010 1254 1289 1497 1208

( ff <- filter(dd1, filter=rep(1, 4)/4, method="convolution", sides=1) ) # 평활상수 filter = 0.25 (m=4)

        Qtr1    Qtr2    Qtr3    Qtr4
2006      NA      NA      NA 1344.75 # sum(1342, 1442, 1252, 1343)/4
2007 1365.50 1345.50 1396.50 1378.75
2008 1333.25 1332.50 1321.50 1316.75
2009 1306.25 1336.00 1313.50 1351.75
2010 1365.00 1317.75 1361.50 1312.00

# 참고: 시계열 선형 필터링

# filter: a vector of filter coefficients in reverse time order (as for AR or MA coefficients).

# method: If "convolution" a moving average is used; 
# if "recursive" an autoregression is used.

# sides: for convolution filters only. 
# If sides = 1 the filter coefficients are for past values only; 
# if sides = 2 they are centred around lag 0. 
# In this case the length of the filter should be odd, 
# but if it is even, more of the filter is forward in time than backward.

plot(dd1, main="Simple Moving Average Smoothing: dd1")
lines(ff, col="red", lty=2, lwd=2) # fitted line 진한 빨강 점선으로 
abline(h=mean(dd1), col="red")
res <- ff[-1:-3, ] - dd1[-1:-3, ] # NA 값이라 첫행 1열에서 3열까지 뺀 것 
# ff[-1:-3, ]
#  [1] 1344.75 1365.50 1345.50 1346.50 1328.75 1283.25 1282.50
#  [8] 1321.50 1316.75 1306.25 1336.00 1313.50 1351.75 1365.00
# [15] 1317.75 1361.50 1312.00

# dd1[-1:-3, ]
#  [1] 1343 1425 1362 1256 1272 1243 1359
#  [8] 1412 1253 1201 1478 1322 1406 1254
# [15] 1289 1497 1208

# # res
#  [1]    1.75  -59.50  -16.50   90.50   56.75   40.25  -76.50
#  [8]  -90.50   63.75  105.25 -142.00   -8.50  -54.25  111.00
# [15]   28.75 -135.50  104.00

tsdisplay(res, main="Residuals by Moving Average: dd1") # forecast 패키지에 포함된 함수
Box.test(res)

	Box-Pierce test

data:  res
X-squared = 0.68668, df = 1, p-value = 0.4073 #독립이며 자기상관이 없다는 H0 기각 불가 

# 이중 이동평균 평활법(Double Moving Average Smoothing)

( ff1 <- filter(dd1, filter=rep(1, 3)/3, method="convolution", sides=1) ) # 평활상수 filter= 0.33 (m=3) #1번째

         Qtr1     Qtr2     Qtr3     Qtr4
2006       NA       NA 1345.333 1345.667
2007 1340.000 1376.667 1347.667 1296.667
2008 1257.000 1291.333 1338.000 1341.333
2009 1288.667 1310.667 1333.667 1402.000
2010 1327.333 1316.333 1346.667 1331.333

( ff2 <- filter(ff1, filter=rep(1, 3)/3, method="convolution", sides=1) ) # 평활상수 filter= 0.33 (m=3) #2번째

         Qtr1     Qtr2     Qtr3     Qtr4
2006       NA       NA       NA       NA
2007 1343.667 1354.111 1354.778 1340.333
2008 1300.444 1281.667 1295.444 1323.556
2009 1322.667 1313.556 1311.000 1348.778
2010 1354.333 1348.556 1330.111 1331.444

plot(dd1, main="Double Moving Average Smoothing: dd1")
lines(ff2, col="red", lty=2, lwd=2) # fitted line 진한 빨강 점선으로 
abline(h=mean(dd1), col="red")

res <- ff2[-1:-3, ] - dd1[-1:-3, ]
tsdisplay(res, main="Residuals by Moving Average: dd1")
Box.test(res)

	Box-Pierce test

data:  res
X-squared = 1.0548, df = 1, p-value = 0.3044

# 가중 이동평균 평활법(Weighted Moving Average Smoothing)

w1 <- c(0.4, 0.3, 0.2, 0.1) # 평활상수 filter = (0.4, 0.3, 0.2, 0.1) # 동일 가중이 아니라
( ff3 <- filter(dd1, filter=w1, method="convolution", sides=1) ) # 직전 시간에 40%, 그 이전 30% 등 차별 가중
       Qtr1   Qtr2   Qtr3   Qtr4
2006     NA     NA     NA 1335.4
2007 1367.5 1366.1 1330.3 1300.5
2008 1266.2 1296.5 1348.3 1320.9
2009 1274.6 1343.3 1337.7 1374.7
2010 1335.6 1305.2 1376.9 1315.5

plot(dd1, main="Weight Moving Average Smoothing: dd1")
lines(ff3, col="red", lty=2, lwd=2) # fitted line 진한 빨강 점선으로 
abline(h=mean(dd1), col="red")

res <- ff3[-1:-3, ] - dd1[-1:-3, ]
tsdisplay(res, main="Residuals by Moving Average: dd1")
Box.test(ff3[-1:-3, ] - dd1[-1:-3, ])

    Box-Pierce test

data:  ff3[-1:-3, ] - dd1[-1:-3, ]
X-squared = 1.6079, df = 1, p-value = 0.2048 # 자기상관은 없으나, Simple MA나 Double MA 보다는 p-value 낮음 

# 이중 가중 이동평균 평활법(Double Weight Moving Average Smoothing)

w1 <- c(0.4, 0.3, 0.2, 0.1)

ff3 <- filter(dd1, filter=w1, method="convolution", sides=1) 
( ff4 <- filter(ff3, filter=w1, method="convolution", sides=1) ) # 평활상수를 2번 연속 적용
        Qtr1    Qtr2    Qtr3    Qtr4
2006      NA      NA      NA      NA
2007      NA      NA 1348.99 1329.26
2008 1299.30 1291.59 1311.56 1318.77
2009 1305.42 1318.71 1325.08 1347.31
2010 1348.52 1331.47 1346.91 1333.87

plot(dd1, main="Simple Moving Average Smoothing: dd1")
lines(ff4, col="red", lty=2, lwd=2) # fitted line 진한 빨강 점선으로 
abline(h=mean(dd1), col="red")
res <- ff4[-1:-3, ] - dd1[-1:-3, ]
tsdisplay(res, main="Residuals by Moving Average: dd1")
Box.test(res)

    Box-Pierce test

data:  res
X-squared = 1.371, df = 1, p-value = 0.2416

# 이동평균 평활법의 예측결과

f1 <- forecast(ff, h=1)
f2 <- forecast(ff2, h=1)
f3 <- forecast(ff3, h=1)
f4 <- forecast(ff4, h=1)

accuracy(f1)
                    ME     RMSE      MAE        MPE     MAPE      MASE         ACF1
Training set -2.026467 25.86405 21.76616 -0.1808676 1.643768 0.5864457 -0.009415114

accuracy(f2)
                     ME     RMSE      MAE         MPE      MAPE      MASE      ACF1
Training set -0.6963529 17.97077 13.04021 -0.06133588 0.9863237 0.4014658 0.3144592

accuracy(f3)
                      ME     RMSE      MAE         MPE    MAPE      MASE      ACF1
Training set 0.004123116 32.14664 26.41459 -0.05867424 1.99514 0.6117757 0.1864105

accuracy(f4)
                    ME     RMSE      MAE         MPE     MAPE      MASE       ACF1
Training set -1.079628 15.55489 13.32646 -0.08740256 1.008039 0.6217147 0.08992033

# 시계열 예측결과 dm.test(residuals(f1), residuals(f2)) 비교 테스트 가능 


# 3) 이동평균 평활법 분석사례: ma

# 이동평균 평활법

dd1
     Qtr1 Qtr2 Qtr3 Qtr4
2006 1342 1442 1252 1343
2007 1425 1362 1456 1272
2008 1243 1359 1412 1253
2009 1201 1478 1322 1406
2010 1254 1289 1497 1208

library(forecast)
w1 <- rep(1, 4) / 4
( ff2 <- filter(dd1, filter=w1, method="convolution", sides=2) ) # 단순 이동평균 # mm2와 동일
        Qtr1    Qtr2    Qtr3    Qtr4
2006      NA 1344.75 1365.50 1345.50
2007 1396.50 1378.75 1333.25 1332.50
2008 1321.50 1316.75 1306.25 1336.00
2009 1313.50 1351.75 1365.00 1317.75
2010 1361.50 1312.00      NA      NA

( mm1 <- ma(dd1, order=4, centre=T) ) # 중심 이동평균 # 중심 있음 # m1 = (1342 + 1442 + 1252 + 1343 )/4 = 1344.75
         Qtr1     Qtr2     Qtr3     Qtr4
2006       NA       NA 1355.125 1355.500
2007 1346.000 1337.625 1306.000 1282.875
2008 1302.000 1319.125 1311.500 1321.125
2009 1324.750 1332.625 1358.375 1341.375
2010 1339.625 1336.750       NA       NA

( mm2 <- ma(dd1, order=4, centre=F) ) # 단순 이동평균 # 중심 없음 # m1' = (1342/2 + 1442 + 1252 + 1343 + 1425/2 )/4 = 1355.125
        Qtr1    Qtr2    Qtr3    Qtr4
2006      NA 1344.75 1365.50 1345.50
2007 1346.50 1328.75 1283.25 1282.50
2008 1321.50 1316.75 1306.25 1336.00
2009 1313.50 1351.75 1365.00 1317.75
2010 1361.50 1312.00      NA      NA

res2 <- mm1 - dd1

Box.test(res2)

    Box-Pierce test

data:  res2
X-squared = 1.3138, df = 1, p-value = 0.2517


# 이중 이동평균 평활법 # order=3을 2번 연속 적용

mm3 <- ma(dd1, order=3, centre=T) 
mm4 <- ma(mm3, order=3, centre=T)
mm4
         Qtr1     Qtr2     Qtr3     Qtr4
2006       NA       NA 1343.667 1354.111
2007 1354.778 1340.333 1300.444 1281.667
2008 1295.444 1323.556 1322.667 1313.556
2009 1311.000 1348.778 1354.333 1348.556
2010 1330.111 1331.444       NA       NA

res3 <- mm4 - dd1
Box.test(res3)

    Box-Pierce test

data:  res3
X-squared = 1.3138, df = 1, p-value = 0.2517

plot(forecast(mm1, h=2), main="Forecast Simple Moving Avg")
plot(forecast(mm4, h=2), main="Forecast Double Moving Avg")

f1 <- forecast(mm1, h=1)
f2 <- forecast(mm2, h=1)
f3 <- forecast(mm3, h=1)
f4 <- forecast(mm4, h=1)
 
accuracy(f1) # 중심 이동평균 (m=4)
                    ME     RMSE      MAE         MPE      MAPE     MASE      ACF1
Training set -1.269018 14.45113 11.19124 -0.09991682 0.8305776 0.456591 0.1445795

accuracy(f2) # 단순 이동평균 (m=4)
                    ME     RMSE      MAE        MPE     MAPE      MASE       ACF1
Training set -4.263954 25.66645 23.66941 -0.3489138 1.764847 0.6770128 0.04612742

accuracy(f3) # 단순 이동평균 (m=3)
                      ME     RMSE    MAE        MPE     MAPE      MASE      ACF1
Training set -0.01434823 31.90496 23.122 -0.0569389 1.715374 0.6061947 0.3007149

accuracy(f4) # 이중 이동평균 (m=3, 3)
                    ME     RMSE      MAE        MPE     MAPE      MASE      ACF1
Training set -0.750478 17.16945 12.23632 -0.0642774 0.910245 0.4033953 0.3147462

# 다른 방법

> summary(f1)

Forecast method: ETS(M,N,N)

Model Information:
ETS(M,N,N) 

Call:
 ets(y = object, lambda = lambda, allow.multiplicative.trend = allow.multiplicative.trend) 

  Smoothing parameters:
    alpha = 0.9999 

  Initial states:
    l = 1357.0525 

  sigma:  0.0106

     AIC     AICc      BIC 
135.4661 137.4661 137.7839 

Error measures:
                    ME     RMSE      MAE         MPE      MAPE     MASE      ACF1
Training set -1.269018 14.45113 11.19124 -0.09991682 0.8305776 0.456591 0.1445795

Forecasts:
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2010 Q3        1336.75 1318.523 1354.978 1308.874 1364.626

> summary(f4)

Forecast method: ETS(M,N,N)

Model Information:
ETS(M,N,N) 

Call:
 ets(y = object, lambda = lambda, allow.multiplicative.trend = allow.multiplicative.trend) 

  Smoothing parameters:
    alpha = 0.9999 

  Initial states:
    l = 1343.4508 

  sigma:  0.0128

     AIC     AICc      BIC 
141.2512 143.2512 143.5689 

Error measures:
                    ME     RMSE      MAE        MPE     MAPE      MASE      ACF1
Training set -0.750478 17.16945 12.23632 -0.0642774 0.910245 0.4033953 0.3147462

Forecasts:
        Point Forecast    Lo 80    Hi 80    Lo 95   Hi 95
2010 Q3       1331.444 1309.667 1353.222 1298.139 1364.75

> dm.test(residuals(f1), residuals(f2)) 

    Diebold-Mariano Test

data:  residuals(f1)residuals(f2)
DM = -3.5619, Forecast horizon = 1, Loss function power = 2, p-value = 0.0026
alternative hypothesis: two.sided

> dm.test(residuals(f1), residuals(f4)) 

    Diebold-Mariano Test

data:  residuals(f1)residuals(f4)
DM = -0.6716, Forecast horizon = 1, Loss function power = 2, p-value = 0.512
alternative hypothesis: two.sided
