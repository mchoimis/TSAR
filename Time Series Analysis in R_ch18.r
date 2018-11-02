
# 18.2 스펙트럴 분석의 분석사례

# (1) 자료입력 및 정상성 검정

data("wineind") # library(forecast) # 오스트레일리아의 포도 생산량

kpss.test(wineind) # library(tseries)
	KPSS Test for Level Stationarity

data:  wineind
KPSS Level = 0.83453, Truncation lag parameter = 3, p-value = 0.01

kpss.test(wineind, "Trend")
KPSS Test for Trend Stationarity

data:  wineind
KPSS Trend = 0.32687, Truncation lag parameter = 3, p-value = 0.01 # 추세의 존재와 상관없이 비정상 시계열

plot(decompose(wineind))

tsdisplay(wineind)

findfrequency(wineind)

# (2) 스펙트럴 분석결과

######## NOT WORKING #######
# d1 <- sprectrum(wineind, log="no") 
# d2 <- sprectrum(wineind, log="no", method="ar")

# (3) Periodogram

cpgram(wineind, main="Cumulative Periodogram: wineind") # Cumulative Periodogram 분석결과 유의수준 이내에 있다
# TSAR p. 49 참조 

# library(TSA) 
periodogram(wineind, main="Wineind") # 스펙트럴 밀도가 크게 나타나는 frequency는 0.25로, 따라서 주기는 1/0.25=4로 산정된다

# (4) 푸리에 급수를 이용한 장래 예측

wine.lm <- tslm(wineind ~ fourier(wineind, 3)) # 3차 푸리에 급수를 이용한 선형모형
# summary(wine.lm)

# Call:
# tslm(formula = wineind ~ fourier(wineind, 3))

# Residuals:
#     Min      1Q  Median      3Q     Max 
# -7973.0 -2732.4    35.2  2353.8  8851.3 

# Coefficients:
#                          Estimate Std. Error t value Pr(>|t|)    
# (Intercept)               25460.1      258.6  98.471  < 2e-16 ***
# fourier(wineind, 3)S1-12  -3036.5      365.7  -8.304 3.11e-14 ***
# fourier(wineind, 3)C1-12    896.7      365.7   2.452   0.0152 *  
# fourier(wineind, 3)S2-12  -1536.5      364.6  -4.214 4.07e-05 ***
# fourier(wineind, 3)C2-12   2033.1      366.7   5.544 1.12e-07 ***
# fourier(wineind, 3)S3-12  -3009.8      365.6  -8.233 4.75e-14 ***
# fourier(wineind, 3)C3-12   2984.8      365.6   8.165 7.14e-14 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Residual standard error: 3429 on 169 degrees of freedom
# Multiple R-squared:  0.602,	Adjusted R-squared:  0.5879 
# F-statistic: 42.61 on 6 and 169 DF,  p-value: < 2.2e-16

ff <- forecast(wine.lm, data.frame(fourier(wineind, 3, 36)))
summary(ff)

Forecast method: Linear regression model

Model Information:

Call:
tslm(formula = wineind ~ fourier(wineind, 3))

Coefficients:
             (Intercept)  fourier(wineind, 3)S1-12  fourier(wineind, 3)C1-12  fourier(wineind, 3)S2-12  
                 25460.1                   -3036.5                     896.7                   -1536.5  
fourier(wineind, 3)C2-12  fourier(wineind, 3)S3-12  fourier(wineind, 3)C3-12  
                  2033.1                   -3009.8                    2984.8  


Error measures:
                        ME     RMSE      MAE     MPE    MAPE    MASE        ACF1
Training set -4.085873e-14 3359.649 2675.989 -1.8528 11.1202 1.36018 -0.07936268

Forecasts:
         Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
Sep 1994       23453.78 18953.16 27954.40 16548.14 30359.43
Oct 1994       25867.46 21365.88 30369.03 18960.34 32774.57
Nov 1994       33111.87 28610.29 37613.44 26204.75 40018.98
Dec 1994       31374.70 26874.08 35875.32 24469.05 38280.35
Jan 1995       21394.60 16897.41 25891.79 14494.22 28294.99
Feb 1995       17946.85 13450.61 22443.08 11047.92 24845.77
Mar 1995       23400.33 18904.10 27896.57 16501.42 30299.25
Apr 1995       25681.02 21184.85 30177.19 18782.20 32579.84
May 1995       22502.78 18006.60 26998.95 15603.95 29401.60
Jun 1995       23611.75 19115.52 28107.99 16712.84 30510.67
Jul 1995       28897.50 24401.26 33393.74 21998.57 35796.42
Aug 1995       28279.08 23781.90 32776.27 21378.70 35179.47
Sep 1995       23453.78 18953.16 27954.40 16548.14 30359.43
Oct 1995       25867.46 21365.88 30369.03 18960.34 32774.57
Nov 1995       33111.87 28610.29 37613.44 26204.75 40018.98
Dec 1995       31374.70 26874.08 35875.32 24469.05 38280.35
Jan 1996       21394.60 16897.41 25891.79 14494.22 28294.99
Feb 1996       17946.85 13450.61 22443.08 11047.92 24845.77
Mar 1996       23400.33 18904.10 27896.57 16501.42 30299.25
Apr 1996       25681.02 21184.85 30177.19 18782.20 32579.84
May 1996       22502.78 18006.60 26998.95 15603.95 29401.60
Jun 1996       23611.75 19115.52 28107.99 16712.84 30510.67
Jul 1996       28897.50 24401.26 33393.74 21998.57 35796.42
Aug 1996       28279.08 23781.90 32776.27 21378.70 35179.47
Sep 1996       23453.78 18953.16 27954.40 16548.14 30359.43
Oct 1996       25867.46 21365.88 30369.03 18960.34 32774.57
Nov 1996       33111.87 28610.29 37613.44 26204.75 40018.98
Dec 1996       31374.70 26874.08 35875.32 24469.05 38280.35
Jan 1997       21394.60 16897.41 25891.79 14494.22 28294.99
Feb 1997       17946.85 13450.61 22443.08 11047.92 24845.77
Mar 1997       23400.33 18904.10 27896.57 16501.42 30299.25
Apr 1997       25681.02 21184.85 30177.19 18782.20 32579.84
May 1997       22502.78 18006.60 26998.95 15603.95 29401.60
Jun 1997       23611.75 19115.52 28107.99 16712.84 30510.67
Jul 1997       28897.50 24401.26 33393.74 21998.57 35796.42
Aug 1997       28279.08 23781.90 32776.27 21378.70 35179.47

plot(ff)
mtext("1980-1998", side=3)

# 재 plotting
plot(ff, xlim=c(1990, 1998))
mtext("1991-1998", side=3)

# 2) 스펙트럴 AR 모형의 분석사례 (1): spec.ar 

# 우연변동 시계열 자료(dd1)의 Spectral AR 분석

# dd1.ts <- ts(dd1, s=c(2006, 1), f=4) # 중요, as.ts가 아니라 그냥 ts로 하는데, 형태가 달라짐

par("mfrow"=c(2, 2))
spec.ar(dd1.ts, method="yw"); mtext("method = Yule-Walker"); grid() # ar(2) 모형으로 판단됨
spec.ar(dd1.ts, method="burg"); mtext("method = Burg"); grid() # ar(13) 모형으로 판단됨
spec.ar(dd1.ts, method="ols"); mtext("method = OLS"); grid() # ar(8) 모형으로 판단됨
spec.ar(dd1.ts, method="mle"); mtext("method = MLE"); grid() # ar(8) 모형으로 판단됨

# OLS 돌릴 시 에러메시지 발생
# Warning message:
# In ar.ols(x, aic = aic, order.max = order.max, na.action = na.action,  :
#   model order:  10 singularities in the computation of the projection matrix results are only valid up to model order 9


# 3) 스펙트럴 AR 모형의 분석사례 (2): spec.ar

# 추세 및 계절변동 시계열 자료(dd4)의 Spectral AR 분석

par("mfrow"=c(2, 2))
spec.ar(dd4.ts, method="yw"); mtext("method = Yule-Walker"); grid() # ar(5) 모형으로 판단됨
spec.ar(dd4.ts, method="burg"); mtext("method = Burg"); grid() # ar(13) 모형으로 판단됨
spec.ar(dd4.ts, method="ols"); mtext("method = OLS"); grid() # ar(9) 모형으로 판단됨
dd4 <- c(dd4); spec.ar(dd4, method="mle"); mtext("method = MLE"); grid() # ar(10) 모형으로 판단됨

# Warning messages:
# 1: In arima0(x, order = c(i, 0L, 0L), include.mean = demean) :
#   수렴에 관한 문제: optim은 code = 1를 반환하였습니다
# 2: In arima0(x, order = c(i, 0L, 0L), include.mean = demean) :
#   수렴에 관한 문제: optim은 code = 1를 반환하였습니다
# 3: In arima0(x, order = c(i, 0L, 0L), include.mean = demean) :
#   수렴에 관한 문제: optim은 code = 1를 반환하였습니다