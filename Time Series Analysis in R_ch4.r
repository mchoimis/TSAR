
# 3) 4) ACF, PACF

> (acf(dd1)) ## 자동으로 plot 나옴

Autocorrelations of series ‘dd1’, by lag

  0.25   0.50   0.75   1.00   1.25   1.50   1.75   2.00 
-0.330 -0.241  0.095  0.005  0.308 -0.360 -0.071  0.062 
  2.25   2.50   2.75   3.00   3.25 
 0.234 -0.126 -0.164  0.212 -0.149 

acf(dd1, plot=F) ## plot 없이 숫자결과만 

 > (acf(dd2, type="covariance"))

Autocovariances of series ‘dd2’, by lag

  0.00   0.25   0.50   0.75   1.00   1.25   1.50   1.75 
 27222   -599 -19406  -4037  21956   -178 -15268  -3666 
  2.00   2.25   2.50   2.75   3.00   3.25 
 16184    101 -10928  -2684  10912   1032 

 pacf(dd1)

# 5) 교차상관 Cross Correlation: ccf

(dd.ts <- ts(data=cbind(dd1, dd2, dd4), s=c(2006, 1), f=4)) # 계열 3개를 합침 # 이제 열에 데이터 계열 나옴 
         dd1  dd2  dd4
2006 Q1 1342 1142 1142
2006 Q2 1442 1242 1242
2006 Q3 1252 1452 1452
2006 Q4 1343 1543 1543
2007 Q1 1425 1125 1225
2007 Q2 1362 1262 1362
2007 Q3 1456 1456 1556
2007 Q4 1272 1572 1672
2008 Q1 1243 1143 1343
2008 Q2 1359 1259 1459
2008 Q3 1412 1462 1662
2008 Q4 1253 1553 1753
2009 Q1 1201 1121 1421
2009 Q2 1478 1258 1558
2009 Q3 1322 1472 1772
2009 Q4 1406 1546 1846
2010 Q1 1254 1154 1554
2010 Q2 1289 1249 1649
2010 Q3 1497 1477 1877
2010 Q4 1208 1548 1948

plot(ccf(dd.ts[, 1], dd.ts[, 2], main="Cross Correlation Plot: dd1-dd2")) # 1열과 2열의 교차상관
plot(ccf(dd.ts[, 2], dd.ts[, 3], main="Cross Correlation Plot: dd1-dd2")) # 2열과 3열의 교차상관


# 6) 계졀변동 요인 제거: diff

plot(acf(dd2))
plot(pacf(dd2))

op <- par (mai=rep(0.4, 4), mfrow=c(4, 1)) # 그래프 옵션 par() 미리 저장 , NOT 텍스트 !
for(i in 1:4) { 
	plot(diff(dd2, lag=i), main = paste0("Difference Plot (Data: dd2, Time Lag = \"", i, "\" )") ) 
}

par(op) # op는 위에서 설정한 옵션을 뜻함

# 여러개의 그래프를 하나에 그릴 때 par() 또는 layout() 함수를 사용한다. 
# par()함수를 사용할 때는 인수인 mfrow=c(nrows,ncols)를 사용하여 nrows*ncols개의 plot으로 분할하는데 
# 그림이 그려지는 순서는 row에 의해 채워진다. 
# mfcol=c(nrows,ncols)를 사용해도 비슷한데 이때는 column을 기준으로 채워진다.

# ------
# Error in plot.new() : figure margins too large 
# 4.
# plot.new() 
# 3.
# plotts(x = x, y = y, plot.type = plot.type, xy.labels = xy.labels, 
#     xy.lines = xy.lines, panel = panel, nc = nc, xlabel = xlabel, 
#     ylabel = ylabel, axes = axes, ...) 
# 2.
# plot.ts(diff(dd2, lag = i), main = paste0("Difference Plot (Data: dd2, Time Lag = \"", i, "\" )")) 
# 1.
# plot(diff(dd2, lag = i), main = paste0("Difference Plot (Data: dd2, Time Lag = \"", i, "\" )")) 
# ------


# 7) tsdisplay (시계열 자료 및 ACF, PACF 의 Plot 동시 수행)

library(TSA)
library(forecast)
data(beersales)
> beersales
         Jan     Feb     Mar     Apr     May     Jun     Jul     Aug     Sep     Oct     Nov     Dec
1975 11.1179  9.8413 11.5732 13.0097 13.4182 14.4418 14.7534 13.8816 12.5123 11.8983 10.6088 11.5874
1976 10.8633 11.0000 10.9934 12.9140 13.5853 14.1553 15.0056 14.8590 13.4387 12.2184 10.5208 10.8335
1977 10.0067 10.4321 14.5477 14.2748 14.9986 15.7100 14.7980 14.6431 12.8878 11.6235 11.4853 11.5065
1978 10.6897 11.0093 14.7983 13.5984 14.9606 15.8187 15.2871 16.2773 13.9370 13.3270 12.0353 11.5670
1979 12.3244 12.0133 15.0094 14.9562 15.9268 15.5702 15.1282 15.5625 13.7112 13.6425 12.5158 11.7629
1980 12.5357 12.6446 14.0848 14.3271 16.1862 16.6604 17.0810 16.2811 14.5118 14.1594 12.5120 12.3830
1981 12.0798 12.4126 15.0092 15.4733 16.9966 17.2933 17.3701 16.2422 14.6808 13.8444 12.3871 12.9072
1982 11.9036 12.9126 15.6815 15.8119 16.5611 17.2255 16.1033 16.2590 14.8834 13.8291 13.1376 12.2662
1983 12.5696 12.6644 15.0723 15.5742 16.8397 17.0121 16.8476 17.3471 14.8442 13.8536 12.7904 11.9797
1984 12.4214 12.5443 15.3242 15.0629 16.8656 17.2300 17.3288 16.9654 13.6582 14.2932 12.4037 11.3818
1985 13.5114 12.7501 14.4642 15.8558 17.6043 16.1731 16.6319 16.0352 13.5914 14.0102 12.3939 12.1101
1986 13.9861 13.0120 14.6625 16.0165 17.1046 16.5952 17.0626 16.3092 14.0156 14.6417 12.4761 12.8391
1987 13.6094 13.7362 15.3119 15.9071 16.1350 16.6147 17.0362 15.8162 14.3066 14.4671 12.5856 12.3225
1988 13.8006 13.9416 15.2575 15.2452 16.4849 17.0435 16.4097 16.2246 14.4386 13.9469 13.2062 12.2347
1989 14.0913 13.1950 15.4059 14.8754 16.7768 16.9378 16.2259 17.4078 14.7684 14.3167 13.4048 12.0999
1990 14.2600 13.3800 15.8900 15.2300 16.9100 16.8854 17.0000 17.4000 14.7500 15.7700 14.5400 13.2200

plot(decompose(beersales))

tsdisplay(beersales, main="Beer Sales") 
taperedpacf(beersales, nsim=50, main="Beer Sales / Bootstrap Samples") # Bootstrap Sample 에 의한 PACF 추정



# 4.2 시계열 자료의 검정

# 2) 무작위성 검정(Randomness Test) - 중앙값 이용한 비모수검정 Runs Test

> library(tseries)
> ( xx1 <- factor( ifelse(dd1 >= median(dd1), 1, 0)) )
 [1] 0 1 0 1 1 1 1 0 0 1 1 0 0 1 0 1 0 0
[19] 1 0
Levels: 0 1

> runs.test(xx1, a="less")

	Runs Test

data:  xx1
Standard Normal = 0.91894, p-value = 0.8209 # 자료가 한쪽으로 치우치지 않고 무작위성 있다는 H0 기각할 수 없음
alternative hypothesis: less

> xx4 <- factor( ifelse(dd4 >= median(dd4), 1, 0)) 
> runs.test(xx4, a="less")

	Runs Test

data:  xx4
Standard Normal = -1.3784, p-value = 0.08404 # H0 기각할 수 없으나 애매, 무작위성에 문제가 있음
alternative hypothesis: less

# 3) 추세 검정(Trend Test) - Spearman rho Test

tt <- seq(1:20)
rr1 <- rank(dd1)
rr4 <- rank(dd4)
( cbind (tt, rr1, rr4) )
      tt rr1 rr4
 [1,]  1  10   1
 [2,]  2  17   3
 [3,]  3   4   7
 [4,]  4  11   9
 [5,]  5  16   2
 [6,]  6  13   5
 [7,]  7  18  11
 [8,]  8   7  15
 [9,]  9   3   4
[10,] 10  12   8
[11,] 11  15  14
[12,] 12   5  16
[13,] 13   1   6
[14,] 14  19  12
[15,] 15   9  17
[16,] 16  14  18
[17,] 17   6  10
[18,] 18   8  13
[19,] 19  20  19
[20,] 20   2  20

cor.test(tt, rr1, method=c("spearman"))

	Spearman''s rank correlation rho

data:  tt and rr1
S = 1508, p-value = 0.5725 # 시간과 순위가 독립이라는 H0 기각 못함 --> 추세 없다
alternative hypothesis: true rho is not equal to 0
sample estimates:
       rho 
-0.1338346 # 낮음 

cor.test(tt, rr4, method=c("spearman"))

	Spearman''s rank correlation rho

data:  tt and rr4
S = 306, p-value = 0.000108 # 시간과 순위가 독립이라는 H0 기각 --> 추세 있다
alternative hypothesis: true rho is not equal to 0
sample estimates:
      rho 
0.7699248 # 높음 


# 4) 추세 검정(Trend Test) - Kendall tau Test

ddd1 <- rep(0, 20) # 0을 20번 반복해라

for(i in 1:20) {
	pp=qq=0
	kk=dd1[i]
	for(j in i+1:20) {
		ifelse (kk <= dd1[j], pp<-pp+1, qq <- qq+1) 
	}
	ddd1[i]=pp
}


ddd4 <- rep(0, 20) 

for(i in 1:20) {
	pp=qq=0
	kk=dd4[i]
	for(j in i+1:20) {
		ifelse (kk <= dd4[j], pp<-pp+1, qq<-qq+1) 
	}
	ddd4[i]=pp
}


ddd1
 [1] 10  3 14  8  3  5  2  7  9  4  2  6  7  1  2  1  2  1  0  0

ddd4
 [1] 19 17 13 11 15 13  9  5 11  9  5  4  7  5  3  2  3  2  1  0

tt <- seq(1:20)

cor.test(tt, ddd1, method=c("kendall"), exact=F)

	Kendall''s rank correlation tau

data:  tt and ddd1
z = -3.598, p-value = 0.0003206 # 시간과 순위가 독립이라는 H0 기각 = 추세가 없다
alternative hypothesis: true tau is not equal to 0
sample estimates:
       tau 
-0.5981442


cor.test(tt, ddd4, method=c("kendall"), exact=F)

	Kendall''s rank correlation tau

data:  tt and ddd4
z = -5.2149, p-value = 1.839e-07 # 시간과 순위가 독립이라는 H0 기각 = 추세가 없다 
alternative hypothesis: true tau is not equal to 0 # but 이는 계절적 변동이 추세변동보다 크기 때문, 
sample estimates: # 계절변동을 제거하면 추세변동은 존재
      tau 
-0.860414 



# 5) 독립성 검정 Box Test - Box-Pierce, Ljung-Box

> Box.test(dd1, t=c("B"))

	Box-Pierce test

data:  dd1
X-squared = 2.1755, df = 1, p-value = 0.1402 # 독립이며 자기상관이 없다는 H0 기각 불가 

> 
> 
> Box.test(dd4, t=c("L"))

	Box-Ljung test

data:  dd4
X-squared = 4.6402, df = 1, p-value = 0.03123 # 독립이며 자기상관이 없다는 H0 기각, 즉 자기상관 존재   

> 
> 
> Box.test(dd1, t=c("B"))

	Box-Pierce test

data:  dd1
X-squared = 2.1755, df = 1, p-value = 0.1402 # 독립이며 자기상관이 없다는 H0 기각 불가 

> 
> 
> Box.test(dd4, t=c("L"))

	Box-Ljung test

data:  dd4
X-squared = 4.6402, df = 1, p-value = 0.03123 # 독립이며 자기상관이 없다는 H0 기각, 즉 자기상관 존재 

# 6) 정상성 검정 Kwiatkowski-Phillips-Schmidt-Shin (KPSS) Test

## 정상성 수준 검정 
kpss.test(dd1)

	KPSS Test for Level Stationarity

data:  dd1
KPSS Level = 0.095496, Truncation lag parameter = 1, p-value = 0.1 # 시계열자료가 정상이라는 H0 기각 불가

kpss.test(dd4)

	KPSS Test for Level Stationarity

data:  dd4
KPSS Level = 0.83203, Truncation lag parameter = 1, p-value = 0.01  # 시계열자료가 정상이라는 H0 기각  

## 추세를 고려한 정상성 검정 
kpss.test(dd1, "Trend")

	KPSS Test for Trend Stationarity

data:  dd1
KPSS Trend = 0.041883, Truncation lag parameter = 1, p-value = 0.1 # 추세를 고려한 정상성 H0 기각 불가

kpss.test(dd4, "T")

	KPSS Test for Trend Stationarity

data:  dd4
KPSS Trend = 0.036632, Truncation lag parameter = 1, p-value = 0.1 # 추세를 고려한 정상성 H0 기각 불가
# 즉, 계절변동 제거시 추세변동 존재

# 7) 자료 및 잔차의 정규성 검정 Jarque-Bera Test - jarque.bera.test

> jarque.bera.test(dd1) # 시계열 자료의 정규성 

	Jarque Bera Test

data:  dd1
X-squared = 1.2951, df = 2, p-value = 0.5233 # 정규성 H0 기각 불가, 즉 시계열 자료 정규성 존재

> library(forecast)
> ff <- rwf(dd1)
> rwf
function (y, h = 10, drift = FALSE, level = c(80, 95), fan = FALSE, 
    lambda = NULL, biasadj = FALSE, x = y) 
{
    fc <- lagwalk(x, lag = 1, h = h, drift = drift, level = level, 
        fan = fan, lambda = lambda, biasadj = biasadj)
    fc$model$call <- match.call()
    fc$series <- deparse(substitute(y))
    if (drift) 
        fc$method <- "Random walk with drift"
    else fc$method <- "Random walk"
    return(fc)
}
<bytecode: 0x0000000003431b88>
<environment: namespace:forecast>

> summary(ff)

Forecast method: Random walk

Model Information:
Call: rwf(y = dd1) 

Residual sd: 151.134 

Error measures:
                    ME    RMSE      MAE       MPE     MAPE
Training set -7.052632 147.272 127.0526 -1.154123 9.526336
                 MASE       ACF1
Training set 1.192283 -0.4634665

Forecasts:
        Point Forecast     Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1           1208 1019.2633 1396.737 919.3521 1496.648
2011 Q2           1208  941.0860 1474.914 799.7902 1616.210
2011 Q3           1208  881.0984 1534.902 708.0472 1707.953
2011 Q4           1208  830.5266 1585.473 630.7042 1785.296
2012 Q1           1208  785.9719 1630.028 562.5637 1853.436
2012 Q2           1208  745.6914 1670.309 500.9600 1915.040
2012 Q3           1208  708.6496 1707.350 444.3095 1971.691
2012 Q4           1208  674.1720 1741.828 391.5805 2024.420
2013 Q1           1208  641.7899 1774.210 342.0563 2073.944
2013 Q2           1208  611.1621 1804.838 295.2152 2120.785

> ff$residuals # 혹은 residuals(ff) 
     Qtr1 Qtr2 Qtr3 Qtr4
2006   NA  100 -190   91
2007   82  -63   94 -184
2008  -29  116   53 -159
2009  -52  277 -156   84
2010 -152   35  208 -289

> re <- matrix(c(ff$residuals[-1, ]))
> re
      [,1]
 [1,]  100
 [2,] -190
 [3,]   91
 [4,]   82
 [5,]  -63
 [6,]   94
 [7,] -184
 [8,]  -29
 [9,]  116
[10,]   53
[11,] -159
[12,]  -52
[13,]  277
[14,] -156
[15,]   84
[16,] -152
[17,]   35
[18,]  208
[19,] -289

> jarque.bera.test(re) # 잔차의 정규성 

	Jarque Bera Test

data:  re
X-squared = 0.57078, df = 2, p-value = 0.7517 # 정규성 H0 기각 불가, 즉 잔차 정규성 존재

# 8) 정상성(단위근) 검정 Unit Root Test - pp.test

pp.test(dd1)

	Phillips-Perron Unit Root Test

data:  dd1
Dickey-Fuller Z(alpha) = -21.954, Truncation lag parameter= 2, p-value = 0.01315
alternative hypothesis: stationary

# 9) 정상성(단위근) 검정 Unit Root Test - adf.test (Augemented Dicky-Fuller)

adf.test(dd1)

	Augmented Dickey-Fuller Test

data:  dd1
Dickey-Fuller = -3.4858, Lag order = 2, p-value = 0.06586 # 단위근 존재한다는 H0 기각 못함, 즉 차분이 필요
alternative hypothesis: stationary

adf.test(ddd1 <- diff(dd1)) # 차분한 자료

	Augmented Dickey-Fuller Test

data:  ddd1 <- diff(dd1)
Dickey-Fuller = -4.0933, Lag order = 2, p-value = 0.02 # 단위근 존재한다는 H0 기각, 즉 단위근 부존재, 차분 불필요 
alternative hypothesis: stationary

# 10) iid random variable 검정 - bds.test

> library(tseries)
> bds.test(google)

	 BDS Test 

data:  google 

Embedding dimension =  2 3 

Epsilon for close points =  0.0119 0.0239 0.0358 0.0477 

Standard Normal = 
      [ 0.0119 ] [ 0.0239 ] [ 0.0358 ] [ 0.0477 ]
[ 2 ]     0.9066     1.7161     2.7901     4.1116
[ 3 ]     2.6743     3.2276     3.8641     4.5778

p-value = 
      [ 0.0119 ] [ 0.0239 ] [ 0.0358 ] [ 0.0477 ] 
[ 2 ]     0.3646     0.0861     0.0053          0 # 1구간, 2구간에서 H0 채택, iid로 판단, but 다른 구간에서는 H0 기각
[ 3 ]     0.0075     0.0012     0.0001          0



# 11) 예측결과의 우열에 대한 검정 Diebold-Mariano Test - dm.test

f1 <- ets(WWWusage)
f2 <- auto.arima(WWWusage)

> summary(f1)
ETS(A,Ad,N) 

Call:
 ets(y = WWWusage) 

  Smoothing parameters:
    alpha = 0.9999 
    beta  = 0.9999 
    phi   = 0.8028 

  Initial states:
    l = 84.6792 
    b = 1.7806 

  sigma:  3.4611

     AIC     AICc      BIC 
720.8318 721.7351 736.4629 

Training set error measures:
                    ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set 0.2364937 3.461057 2.798415 0.2642011 2.208328 0.6183997 0.1999073

> summary(f2)
Series: WWWusage 
ARIMA(1,1,1) 

Coefficients:
         ar1     ma1
      0.6504  0.5256
s.e.  0.0842  0.0896

sigma^2 estimated as 9.995:  log likelihood=-254.15
AIC=514.3   AICc=514.55   BIC=522.08

Training set error measures:
                    ME     RMSE      MAE       MPE     MAPE      MASE        ACF1
Training set 0.3035616 3.113754 2.405275 0.2805566 1.917463 0.5315228 -0.01715517

> accuracy(f1)
                    ME     RMSE      MAE       MPE     MAPE
Training set 0.2364937 3.461057 2.798415 0.2642011 2.208328
                  MASE      ACF1
Training set 0.6183997 0.1999073

> accuracy(f2)
                    ME     RMSE      MAE       MPE     MAPE
Training set 0.3035616 3.113754 2.405275 0.2805566 1.917463
                  MASE        ACF1
Training set 0.5315228 -0.01715517

> dm.test(residuals(f1), residuals(f2))

	Diebold-Mariano Test

data:  residuals(f1)residuals(f2)
DM = 2.1293, Forecast horizon = 1, Loss function power = 2, p-value = 0.03571 # 두 분석방법에 차이가 있다
alternative hypothesis: two.sided

> dm.test(residuals(f2), residuals(f1))

	Diebold-Mariano Test

data:  residuals(f2)residuals(f1)
DM = -2.1293, Forecast horizon = 1, Loss function power =2, p-value = 0.03571 # 양측 검정이므로 위와 동일
alternative hypothesis: two.sided


> dm.test(residuals(f1), residuals(f2), alternative="less") # 단측검정

	Diebold-Mariano Test

data:  residuals(f1)residuals(f2)
DM = 2.1293, Forecast horizon = 1, Loss function power = 2, p-value = 0.9821 # f2 아리마가 낫다 
alternative hypothesis: less

> dm.test(residuals(f2), residuals(f1), a="l") # H0: f2$residuals - f1$residuals > 0 ?

	Diebold-Mariano Test

data:  residuals(f2)residuals(f1)
DM = -2.1293, Forecast horizon = 1, Loss function power =2, p-value = 0.01785 # 기각, f2 잔차가 더 작다 
alternative hypothesis: less

# 12) Frequency 탐색: findfrequency

library(tseries)
tsdisplay(lynx, main="Lynx/Year(1821~1934)")
findfrequency(lynx)
[1] 10

# 13) 시계열 자료의 이상값 여부 검정

x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 15)
tom <- function(x) {
	nn <- length(x)
	mu <- mean(x)
	ss <- sd(x, 1)
	t1 <- (x-mu)/ss
	(sqrt(nn-2)*t1/sqrt(nn-1-t1*t1))
}

tt1 <- qt(0.99, 8) # 기각역1 alpha = 0.01 
tt2 <- qt(0.95, 8) # 기각역2 alpha = 0.05 

tom(x);	tt1;	tt2
 [1] -1.2649111 -0.9773556 -0.7145896 -0.4681646 -0.2317138  0.0000000
 [7]  0.2317138  0.4681646  0.7145896  3.0645235 # 관측값 15의 검정통계량 3.0645 > 0.05 > 0.01 = alpha
[1] 2.896459
[1] 1.859548

# 다른 샘플로 테스트 
> x<-rnorm(1:15)
> x
 [1] -0.57801398  1.27698081  0.04138372
 [4] -0.67373466  2.58779061 -1.32201900
 [7] -0.97963635 -0.94432502 -0.88702218
[10] -0.22599294  0.66275731 -0.15166496
[13] -0.42913094 -0.53989648 -0.60541102
> tom(x); qt(0.99, 13); qt(0.95, 13) # 자유도는 n-2=15-2=13
 [1] -0.3765855  1.5079406  0.2154239 -0.4695950
 [5]  3.8726844 -1.1351396 -0.7740881 -0.7382341 # 5번 값의 검정통계량만 alpha 값 넘김   
 [9] -0.6804902 -0.0394708  0.8274769  0.0312836
[13] -0.2333172 -0.3397636 -0.4031229
[1] 2.650309
[1] 1.770933

# 14) 결측자료의 처리 및 분석 

x <- c(22, 34, NA, 36, 28, 
	35, 46, 42, 39, 25, 
	36, 25, 38, NA, 37) # x 자료
t <- seq(1:15) # t 자료
library(mice)
zz <- mice( matrix(c(x, t), nc=2))

iter imp variable
  1   1  V1
  1   2  V1
  1   3  V1
  1   4  V1
  1   5  V1
  2   1  V1
  2   2  V1
  2   3  V1
  2   4  V1
  2   5  V1
  3   1  V1
  3   2  V1
  3   3  V1
  3   4  V1
  3   5  V1
  4   1  V1
  4   2  V1
  4   3  V1
  4   4  V1
  4   5  V1
  5   1  V1
  5   2  V1
  5   3  V1
  5   4  V1
  5   5  V1

> zz
Multiply imputed data set
Call:
mice(data = matrix(c(x, t), nc = 2)) # Data should contain at least two columns
Number of multiple imputations:  5
Missing cells per column:
V1 V2 
 2  0 
Imputation methods:
   V1    V2 
"pmm"    "" 
VisitSequence:
V1 
 1 
PredictorMatrix:
   V1 V2
V1  0  1
V2  0  0
Random generator seed value:  NA 


t(complete(zz))
   [,1] [,2] [,3] [,4] [,5]
V1   22   34   25   36   28
V2    1    2    3    4    5
   [,6] [,7] [,8] [,9] [,10]
V1   35   46   42   39    25
V2    6    7    8    9    10
   [,11] [,12] [,13] [,14]
V1    36    25    38    37
V2    11    12    13    14
   [,15]
V1    37
V2    15


# 15) 결측 자료 및 이상값(outlier) 보정 tsclean

library(forecast)
data(gold)
> table(is.na(gold)) # 테이블화 

FALSE  TRUE 
 1074    34 # 결측자료의 개수

> str(is.na(gold))
 logi [1:1108] FALSE FALSE FALSE FALSE FALSE FALSE ...

> for(i in 1:length(gold)) ifelse(is.na(gold[i]), print(i), next) # 결측자료의 위치 
[1] 68
[1] 69
[1] 89
[1] 104
[1] 169
[1] 256
[1] 257
[1] 261
[1] 323
[1] 324
[1] 349
[1] 364
[1] 429
[1] 517
[1] 518
[1] 522
[1] 598
[1] 599
[1] 609
[1] 624
[1] 694
[1] 778
[1] 779
[1] 783
[1] 848
[1] 849
[1] 869
[1] 889
[1] 954
[1] 1039
[1] 1040
[1] 1044
[1] 1103
[1] 1104

> tsoutliers(gold) # 이상값
$index
[1] 770 # 770번째 위치함

$replacements
[1] 494.9 # 이걸로 고치겠다

> gold[tsoutliers(gold)$index] # 원래 얼마였지? (770번째 값 찾아줘)
[1] 593.7 

> # na.interp(gold)
> newgold <- tsclean(gold) # 결측치 및 이상값 보정
> tsdisplay(gold)
> tsdisplay(newgold)

> table(is.na(newgold))

FALSE 
 1108 

# 혹은 
> par(mfrow=c(2, 1))
> ts.plot(gold, main="gold")
> ts.plot(newgold, main="new gold, outlier 보정")

# 혹은 
> par(mfrow=c(2, 1))

> plot(acf(gold), main="gold")
> plot(pacf(gold), main="gold")

> plot(acf(newgold))
> plot(pacf(newgold))


# 16) 시계열 자료의 일부에 대한 정상성 검정

beersales
         Jan     Feb     Mar     Apr     May     Jun     Jul     Aug     Sep     Oct     Nov     Dec
1975 11.1179  9.8413 11.5732 13.0097 13.4182 14.4418 14.7534 13.8816 12.5123 11.8983 10.6088 11.5874
1976 10.8633 11.0000 10.9934 12.9140 13.5853 14.1553 15.0056 14.8590 13.4387 12.2184 10.5208 10.8335
1977 10.0067 10.4321 14.5477 14.2748 14.9986 15.7100 14.7980 14.6431 12.8878 11.6235 11.4853 11.5065
1978 10.6897 11.0093 14.7983 13.5984 14.9606 15.8187 15.2871 16.2773 13.9370 13.3270 12.0353 11.5670
1979 12.3244 12.0133 15.0094 14.9562 15.9268 15.5702 15.1282 15.5625 13.7112 13.6425 12.5158 11.7629
1980 12.5357 12.6446 14.0848 14.3271 16.1862 16.6604 17.0810 16.2811 14.5118 14.1594 12.5120 12.3830
1981 12.0798 12.4126 15.0092 15.4733 16.9966 17.2933 17.3701 16.2422 14.6808 13.8444 12.3871 12.9072
1982 11.9036 12.9126 15.6815 15.8119 16.5611 17.2255 16.1033 16.2590 14.8834 13.8291 13.1376 12.2662
1983 12.5696 12.6644 15.0723 15.5742 16.8397 17.0121 16.8476 17.3471 14.8442 13.8536 12.7904 11.9797
1984 12.4214 12.5443 15.3242 15.0629 16.8656 17.2300 17.3288 16.9654 13.6582 14.2932 12.4037 11.3818
1985 13.5114 12.7501 14.4642 15.8558 17.6043 16.1731 16.6319 16.0352 13.5914 14.0102 12.3939 12.1101
1986 13.9861 13.0120 14.6625 16.0165 17.1046 16.5952 17.0626 16.3092 14.0156 14.6417 12.4761 12.8391
1987 13.6094 13.7362 15.3119 15.9071 16.1350 16.6147 17.0362 15.8162 14.3066 14.4671 12.5856 12.3225
1988 13.8006 13.9416 15.2575 15.2452 16.4849 17.0435 16.4097 16.2246 14.4386 13.9469 13.2062 12.2347
1989 14.0913 13.1950 15.4059 14.8754 16.7768 16.9378 16.2259 17.4078 14.7684 14.3167 13.4048 12.0999
1990 14.2600 13.3800 15.8900 15.2300 16.9100 16.8854 17.0000 17.4000 14.7500 15.7700 14.5400 13.2200

( dd <- subset(beersales, month="Jul") ) # subset 기능 사용, 전체 연도에 걸쳐 7월만 뽑기
Time Series:
Start = 1975.5 # 1975년도의 중간에서부터?
End = 1990.5 
Frequency = 1 
 [1] 14.7534 15.0056 14.7980 15.2871 15.1282 17.0810 17.3701 16.1033 16.8476 17.3288 16.6319 17.0626
[13] 17.0362 16.4097 16.2259 17.0000

kpss.test(dd)

	KPSS Test for Level Stationarity

data:  dd
KPSS Level = 0.90756, Truncation lag parameter = 0, p-value = 0.01 # 당연히 한달 

kpss.test(dd, "T")

	KPSS Test for Trend Stationarity

data:  dd
KPSS Trend = 0.23309, Truncation lag parameter = 0, p-value = 0.01

tsdisplay(beersales, main="Beer Sales/ Month (1975-1990)")
tsdisplay(dd, main="Beer Sales/ Month (1975-1990)")

# 혹은 

( beersubset1 <- subset(beersales, month=c("Jul", "Oct")) ) # 7월과 10월만
Time Series:
Start = c(1975, 2) 
End = c(1991, 1) # 잘 모르겠네...
Frequency = 2 
 [1] 14.7534 11.8983 15.0056 12.2184 14.7980 11.6235
 [7] 15.2871 13.3270 15.1282 13.6425 17.0810 14.1594
[13] 17.3701 13.8444 16.1033 13.8291 16.8476 13.8536
[19] 17.3288 14.2932 16.6319 14.0102 17.0626 14.6417
[25] 17.0362 14.4671 16.4097 13.9469 16.2259 14.3167
[31] 17.0000 15.7700

kpss.test(beersubset1)
	KPSS Test for Level Stationarity

data:  beersubset1
KPSS Level = 1.0732, Truncation lag parameter = 1, p-value = 0.01 # 영가설 기각, 정상성 아님

kpss.test(beersubset1, "T")

	KPSS Test for Trend Stationarity

data:  beersubset1
KPSS Trend = 0.23328, Truncation lag parameter = 1, p-value = 0.01

( beersubset2 <- subset(beersales, month=c("Jul", "Oct", "Mar")) ) # 7월, 10월, 3월만
Time Series:
Start = 1975.16666666667 
End = 1990.83333333333 
Frequency = 3 
 [1] 11.5732 14.7534 11.8983 10.9934 15.0056 12.2184 # 디스플레이되는 값은 3월치부터 나옴
 [7] 14.5477 14.7980 11.6235 14.7983 15.2871 13.3270
[13] 15.0094 15.1282 13.6425 14.0848 17.0810 14.1594
[19] 15.0092 17.3701 13.8444 15.6815 16.1033 13.8291
[25] 15.0723 16.8476 13.8536 15.3242 17.3288 14.2932
[31] 14.4642 16.6319 14.0102 14.6625 17.0626 14.6417
[37] 15.3119 17.0362 14.4671 15.2575 16.4097 13.9469
[43] 15.4059 16.2259 14.3167 15.8900 17.0000 15.7700

kpss.test(beersubset2)
	KPSS Test for Level Stationarity

data:  beersubset2
KPSS Level = 1.2829, Truncation lag parameter = 1, p-value = 0.01  # 영가설 기각, 정상성 아님

kpss.test(beersubset2, "T")

	KPSS Test for Trend Stationarity

data:  beersubset
KPSS Trend = 0.20299, Truncation lag parameter = 1, p-value = 0.01488 # 영가설 기각.... (계절변동 제거 고려)

