
# 7.2 회귀모형 평활법의 분석사례 - 3

# 11) 선형 회귀모형의 예측 분석사례: lm (일반 선형회귀)

# (1) 자료입력 및 선형 추세변동 검정

dd4 <- matrix(c(1142, 1242, 1452, 1543, 	1225, 1362, 1556, 1672, 	1343, 1459, 1662, 1753, 	1421, 1558, 1772, 1846, 1554, 1649, 1877, 1948))
tt <- seq(1:20)

cor.test(tt, dd4, method="spearman") # 추세변동 여부 테스트

	Spearman''s rank correlation rho

data:  tt and dd4
S = 306, p-value = 0.000108 # p-value < 0.01
alternative hypothesis: true rho is not equal to 0
sample estimates:
      rho 
0.7699248 # 추세변동 있음

kpss.test(dd4.ts) # 정상시계열 여부 테스트 # library(tseries)

	KPSS Test for Level Stationarity

data:  dd4.ts
KPSS Level = 0.83203, Truncation lag parameter = 1, p-value = 0.01 # 영가설 기각, 정상시계열 아님

# (2) 분석결과 

ll1 <- lm(dd4 ~ tt)
summary(ll1)

Call:
lm(formula = dd4 ~ tt)

Residuals:
   Min     1Q Median     3Q    Max 
-205.8 -125.5    7.7  114.6  195.2 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 1236.642     65.817  18.789 2.82e-13 ***
tt            30.015      5.494   5.463 3.45e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 141.7 on 18 degrees of freedom
Multiple R-squared:  0.6238,	Adjusted R-squared:  0.6029 
F-statistic: 29.84 on 1 and 18 DF,  p-value: 3.447e-05

# (3) 잔차검토

plot(tt, ll1$res, xlab="Time", ylab="Residuals", main="Residuals Plot by Linear Regression: dd4"); grid()

# (4) 예측결과 

new <- data.frame(tt<-seq(1:28))
( pp1 <- predict(ll1, new, interval="prediction"))
        fit       lwr      upr
1  1266.657  942.5239 1590.790
2  1296.672  976.2600 1617.084
3  1326.687 1009.6193 1643.755
4  1356.702 1042.5897 1670.815
5  1386.717 1075.1603 1698.274
6  1416.732 1107.3211 1726.144
7  1446.747 1139.0635 1754.431
8  1476.762 1170.3804 1783.144
9  1506.777 1201.2665 1812.288
10 1536.792 1231.7180 1841.867
11 1566.808 1261.7330 1871.882
12 1596.823 1291.3116 1902.334
13 1626.838 1320.4556 1933.220
14 1656.853 1349.1687 1964.537
15 1686.868 1377.4564 1996.279
16 1716.883 1405.3257 2028.440
17 1746.898 1432.7852 2061.010
18 1776.913 1459.8448 2093.981
19 1806.928 1486.5156 2127.340
20 1836.943 1512.8096 2161.076
21 1866.958 1538.7396 2195.176
22 1896.973 1564.3191 2229.627
23 1926.988 1589.5618 2264.414
24 1957.003 1614.4819 2299.524
25 1987.018 1639.0934 2334.943
26 2017.033 1663.4106 2370.656
27 2047.048 1687.4475 2406.649
28 2077.063 1711.2177 2442.909

matplot(new, cbind(pp1), type="l", col=c(1, 2, 2), lty=c(1, 2, 2), xlab="Time") # matplot: Plot Columns of Matrices
lines(dd4)
title("Linear Regression Trend Variation: dd4")

text(25, 1500, "95% Lower")
text(25, 1885, "Fitted V.")
text(25, 2200, "95% Upper")
grid()

# matplot: Plot the columns of one matrix against the columns of another.

# 12) 선형 회귀모형의 예측 분석사례: tslm (시계열 선형회귀)

# (1) 자료입력 및 선형검정: 앞절에서 추세 확인

# (2) 분석결과
f1 <- tslm(dd4.ts ~ trend)
summary(f1)

Call:
tslm(formula = dd4.ts ~ trend)

Residuals:
   Min     1Q Median     3Q    Max 
-205.8 -125.5    7.7  114.6  195.2 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept) 1236.642     65.817  18.789 2.82e-13
trend         30.015      5.494   5.463 3.45e-05
               
(Intercept) ***
trend       ***
---
Signif. codes:  
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 141.7 on 18 degrees of freedom
Multiple R-squared:  0.6238,	Adjusted R-squared:  0.6029 
F-statistic: 29.84 on 1 and 18 DF,  p-value: 3.447e-05

# (3) 예측결과 
names(f1)
 [1] "coefficients"  "residuals"     "effects"      
 [4] "rank"          "fitted.values" "assign"       
 [7] "qr"            "df.residual"   "xlevels"      
[10] "call"          "terms"         "model"        
[13] "data"          "method"  

f1$fitted.values
         Qtr1     Qtr2     Qtr3     Qtr4
2006 1266.657 1296.672 1326.687 1356.702
2007 1386.717 1416.732 1446.747 1476.762
2008 1506.777 1536.792 1566.808 1596.823
2009 1626.838 1656.853 1686.868 1716.883
2010 1746.898 1776.913 1806.928 1836.943

f1$ residuals
           Qtr1       Qtr2       Qtr3       Qtr4
2006 -124.65714  -54.67218  125.31278  186.29774
2007 -161.71729  -54.73233  109.25263  195.23759
2008 -163.77744  -77.79248   95.19248  156.17744
2009 -205.83759  -98.85263   85.13233  129.11729
2010 -192.89774 -127.91278   70.07218  111.05714

forecast(f1, h=8)
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1866.958 1659.116 2074.799 1538.740 2195.176
2011 Q2       1896.973 1686.323 2107.623 1564.319 2229.627
2011 Q3       1926.988 1713.316 2140.660 1589.562 2264.414
2011 Q4       1957.003 1740.104 2173.902 1614.482 2299.524
2012 Q1       1987.018 1766.698 2207.338 1639.093 2334.943
2012 Q2       2017.033 1793.105 2240.961 1663.411 2370.656
2012 Q3       2047.048 1819.334 2274.762 1687.447 2406.649
2012 Q4       2077.063 1845.395 2308.732 1711.218 2442.909

plot(forecast(f1, h=8))

t <- seq(2006.25, 2010.75, length=20)
ll <- lm(dd4~t)
abline(ll, col="red")
grid()

# 13) 비선형 (다항식) 회귀모형의 예측 분석사례: nls

# (1) 추세변동 검정

tt <- seq(1:length(dd3))
cor.test(tt, dd3, method="spearman") # 추세변동 확인

	Spearman''s rank correlation rho

data:  tt and dd3
S = 450.67, p-value = 0.001503
alternative hypothesis: true rho is not equal to 0
sample estimates:
      rho 
0.6611509 

( lb1 <- nls(dd3 ~ a + b*tt, start=c(a=1, b=1)) )
Nonlinear regression model
  model: dd3 ~ a + b * tt
   data: parent.frame()
      a       b 
1248.43   15.94 
 residual sum-of-squares: 193713

Number of iterations to convergence: 1 
Achieved convergence tolerance: 2.03e-09

( lb3 <- nls(dd3 ~ a + b*tt + c*tt^2 + d*tt^3, start=c(a=1, b=1, c=1, d=1)) )
Nonlinear regression model
  model: dd3 ~ a + b * tt + c * tt^2 + d * tt^3
   data: parent.frame()
        a         b         c         d 
1091.7701   75.3521   -5.2872    0.1322 
 residual sum-of-squares: 163888

Number of iterations to convergence: 1 
Achieved convergence tolerance: 3.017e-08

( lb5 <- nls(dd3 ~ a + b*tt + c*tt^2 + d*tt^3 + e*tt^4 + f*tt^5, start=c(a=1, b=1, c=1, d=1, e=1, f=1)) )
Nonlinear regression model
  model: dd3 ~ a + b * tt + c * tt^2 + d * tt^3 + e * tt^4 + f * tt^5
   data: parent.frame()
         a          b          c          d          e          f 
1232.28369 -113.83984   62.66502   -9.24864    0.54245   -0.01106 
 residual sum-of-squares: 116992

Number of iterations to convergence: 1 
Achieved convergence tolerance: 1.059e-06

# (2) 예측결과

nt <- seq(1:(length(dd3)+2))
p1 <- predict(lb1, list(tt=1:22))
p2 <- predict(lb3, list(tt=1:22))
p3 <- predict(lb5, list(tt=1:22))

plot(nt, p3, type="n", main="Linear / Polynomial Forecast: nls", ylab="") # type="n" for No plotting # 빈그래프
lines(tt, dd3, lty=1, col=1, lwd=1)
lines(nt, p1, lty=2, col=2, lwd=2); lines(nt, p2, lty=3, col=3, lwd=2); lines(nt, p3, lty=6, col=4, lwd=2)
grid()
legend("bottomright", c("Polynomial (Time, 1차)", "Polynomial (Time, 3차)", "Polynomial (Time, 5차)"), 
	col=c(2,3,4), lty=c(2,3,6), lwd=c(2,2,2))

# plot (type= ) options
# "p" for points,
# "l" for lines,
# "b" for both,
# "c" for the lines part alone of "b",
# "o" for both ‘overplotted’,
# "h" for ‘histogram’ like (or ‘high-density’) vertical lines,
# "s" for stair steps,
# "S" for other steps, see ‘Details’ below,
# "n" for no plotting.

# 평활화는 고차원 함수가 우수하나 예측은 저차원 함수가 타당한 것으로 나타났다

# 14) 비선형(Loess) 회귀모형의 예측 분석사례: loess

# (1) 자료입력 및 선형검정
tt <- seq(1, 20)
nt <- seq(1, 23)

lb1 <- loess(dd3 ~ tt, control=loess.control(surface="direct"))
Call:
loess(formula = dd3 ~ tt, control = loess.control(surface = "direct"))

Number of Observations: 20 
Equivalent Number of Parameters: 4.45 
Residual Standard Error: 99.44 

( lp1 <- round(predict(lb1, data.frame(tt=nt)), 0) ) # round로 일의자리까지 반올림 # 1이면 소수점 첫째자리
   1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23 
1144 1213 1274 1326 1368 1402 1428 1447 1450 1442 1424 1415 1422 1452 1478 1496 1509 1519 1524 1523 1515 1499 1473 

lb2 <- loess(dd3 ~ tt, span=.35, control=loess.control(surface="direct"))
Call:
loess(formula = dd3 ~ tt, span = 0.35, control = loess.control(surface = "direct"))

Number of Observations: 20 
Equivalent Number of Parameters: 9.79 
Residual Standard Error: 127.6

( lp2 <- round(predict(lb2, data.frame(tt=nt)), 0) ) # round로 일의자리까지 반올림
   1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20   21   22   23 
1154 1216 1258 1269 1354 1410 1498 1444 1443 1400 1445 1422 1446 1398 1434 1513 1596 1607 1549 1427 1233  962  611

# (2) 예측결과

plot(nt, lp2, type="n", xlab="Time", ylab="", main="Local Polynomial Regression Forecast")
lines(tt, dd3); lines(nt, lp1, col=2, lty=2, lwd=2); lines(nt, lp2, col=4, lty=2, lwd=2); grid()
legend("bottomright", c("LOESS: span=0.75", "LOESS: span=0.35"), col=c(2, 4), lty=c(2, 6), cex=.8)

# 평활화는 span이 작을 수록 우수하나 예측은 span이 클수록 타당한 것으로 나타났다

# 15) 비선형 (smooth.spline) 회귀모형의 예측 분석사례: smooth.spline

# (1) 자료입력 및 선형검정

tt <- seq(1, length(dd3))
nt <- seq(1, (length(dd3)+4))
sa1 <- smooth.spline(x=tt, y=dd3)
Call:
smooth.spline(x = tt, y = dd3)

Smoothing Parameter  spar= 0.7649793  lambda= 0.03408847 (12 iterations)
Equivalent Degrees of Freedom (Df): 2.804372
Penalized Criterion (RSS): 172040.6
GCV: 11636.57

sa2 <- smooth.spline(tt, dd3, df=8) # df의 최대값은 10이다
Call:
smooth.spline(x = tt, y = dd3, df = 8)

Smoothing Parameter  spar= 0.4359586  lambda= 0.0001430623 (13 iterations)
Equivalent Degrees of Freedom (Df): 7.999049
Penalized Criterion (RSS): 107158.5
GCV: 14880.76

pa1 <- predict(sa1, nt)
pa2 <- predict(sa2, nt)
round(pa1$y, 0)
[1] 1225 1253 1281 1308 1333 1357 1379 1398 1414 1429 1443 1455 1467 1478 1490 1501 1512 1522 1531 1540 1548 1557 1565 1574
 
round(pa2$y, 0)
[1] 1157 1215 1263 1307 1355 1418 1449 1458 1440 1430 1426 1424 1422 1429 1457 1520 1567 1578 1541 1460 1371 1282 1192 1103

# (2) 예측결과

plot(pa2, type="n", main="Smoothing Spline Forecast")
lines(tt, dd3); lines(pa1, col=4, lty=2, lwd=2); lines(pa2, col=2, lty=2, lwd=2); grid()
legend("bottomright", c(paste("default[CV] -> df=", round(sa1$df, 1)), "Spline [CV] -> df=10"), col=c(2, 4), lty=c(2, 6))

# 평활화는 CV가 클수록 우수하나 예측은 CV가 작을수록 타당한 것으로 나타났다

# 16) 비선형 (spline) 회귀모형의 예측 분석사례: splinef

# (1) 자료입력 및 선형검정

ss <- splinef(dd3.ts)
summary(ss)
Forecast method: Cubic Smoothing Spline

Model Information:
$beta
[1] 233.8128

$call
splinef(y = dd3.ts)


Error measures:
                    ME     RMSE      MAE      MPE     MAPE      MASE       ACF1
Training set -13.97579 125.9379 107.4085 -1.30901 7.607021 0.7850782 -0.3032285

Forecasts:
        Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
2011 Q1       1548.778 1397.662 1699.895 1317.665 1779.891
2011 Q2       1557.453 1396.932 1717.975 1311.956 1802.950
2011 Q3       1566.129 1393.905 1738.352 1302.736 1829.521
2011 Q4       1574.804 1388.651 1760.956 1290.108 1859.500
2012 Q1       1583.479 1381.292 1785.665 1274.261 1892.696
2012 Q2       1592.154 1371.980 1812.328 1255.427 1928.880
2012 Q3       1600.829 1360.871 1840.788 1233.844 1967.814
2012 Q4       1609.504 1348.111 1870.897 1209.738 2009.270
2013 Q1       1618.179 1333.836 1902.523 1183.314 2053.045
2013 Q2       1626.855 1318.163 1935.546 1154.751 2098.958

# (2) 예측결과

plot(ss)


