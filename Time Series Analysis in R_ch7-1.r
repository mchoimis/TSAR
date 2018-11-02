   
# 7.2 회귀모형 평활법의 분석사례

# 1) (선형, 다항식) 회귀모형 평활법 분석사례: lm

# (1) 자료입력 및 선형, 다항식 회귀모형 평활법 분석

tt <- seq(1:length(dd3))
plot(tt, dd3, type="b", main="Time Series Linear / Polynomial") # type="b" for both, 데이터포인트가 point 과 line 둘 다 표현됨 
> (la1 <- lm(dd3 ~ poly(tt, 1))) 

Call:
lm(formula = dd3 ~ poly(tt, 1))

Coefficients: # 1차식: 1415.8 + 411.1*t
(Intercept)  poly(tt, 1)  
     1415.8        411.1 

> (la3 <- lm(dd3 ~ poly(tt, 3))) 

Call:
lm(formula = dd3 ~ poly(tt, 3))

Coefficients: # 위 결과와 계수가 동일하다는 점 주목 # 아래 절 nls와 비교
 (Intercept)  poly(tt, 3)1  poly(tt, 3)2  poly(tt, 3)3  
     1415.80        411.05       -148.70         87.83 

> (la5 <- lm(dd3 ~ poly(tt, 5))) 

Call:
lm(formula = dd3 ~ poly(tt, 5))

Coefficients: # 위 결과와 계수가 동일하다는 점 주목 # 아래 절 nls와 비교
 (Intercept)  poly(tt, 5)1  poly(tt, 5)2  poly(tt, 5)3  poly(tt, 5)4  poly(tt, 5)5  
     1415.80        411.05       -148.70         87.83       -125.44       -176.53  

# (2) 분석결과

round(cbind(fitted(la1), fitted(la3), fitted(la5)), 0)
   [,1] [,2] [,3]
1  1264 1162 1172
2  1280 1222 1190
3  1296 1274 1246
4  1312 1317 1315
5  1328 1353 1378
6  1344 1382 1424
7  1360 1406 1450
8  1376 1424 1456
9  1392 1438 1447
10 1408 1449 1430
11 1424 1457 1413
12 1440 1463 1404
13 1456 1468 1410
14 1472 1473 1433
15 1488 1479 1472
16 1503 1485 1522
17 1519 1494 1570
18 1535 1506 1593
19 1551 1522 1560
20 1567 1542 1430

r1 <- 1 - sum((dd3-fitted(la1))^2) / sum((dd3 - mean(dd3))^2)
r3 <- 1 - sum((dd3-fitted(la3))^2) / sum((dd3 - mean(dd3))^2)
r5 <- 1 - sum((dd3-fitted(la5))^2) / sum((dd3 - mean(dd3))^2)
cbind(r1, r3, r5) # R-squared
           r1        r3        r5
[1,] 0.465878 0.5481143 0.6774194

plot(tt, dd3, type="b", main="Time Series Linear / Polynomial")
lines(tt, fitted(la1), lty=1, col=1, lwd=1) # 실선 검정색
lines(tt, fitted(la3), lty=2, col=2, lwd=2) # 파선 빨간색
lines(tt, fitted(la5), lty=3, col=3, lwd=3) # 점선 초록색
legend("bottomright", 
	c("Poly (Time, 1차)", "Poly (Time, 3차)", "Poly (Time, 5차)"), 
	col=c(1, 2, 3), 
	lty=c(1, 2, 3), 
	lwd=c(1, 2, 3)
)

# (3) 선형 함수의 추정에 따른 잔차 분석

tsdisplay(la1$residuals)
Box.test(la1$residuals, type="B")

	Box-Pierce test

data:  la1$residuals
X-squared = 1.5353, df = 1, p-value = 0.2153 # 자기상관 없음

hist(la1$residuals, 10, probability=T, col="light blue", 
	xlab="Time", ylab="Residuals", main="Histograms of Residuals") # 히스토그램
points(density(la1$residuals, bw=30), type='l', col='red', lwd=2) # 그 위에 선 그리기
title("\n \n - Linear Regression Smoothing") # 그 위에 제목 덧붙이기

## 그래프 그려보기
plot(dd3, ylim=c(1100, 1700), main="dd3: linear smoothing fitted", lty=2)
lines(la1.ts<-ts(data=fitted(la1), s=c(2006, 1), f=4), col=1)
lines(la3.ts<-ts(data=fitted(la3), s=c(2006, 1), f=4), col=2)
lines(la5.ts<-ts(data=fitted(la5), s=c(2006, 1), f=4), col=3)
legend("topleft", legend=c("1차", "3차", "5차"), col=1:3, lty=1)



# 2) (선형 및 다항식) 회귀모형 평활법 분석사례: nls

# (1) 선형 및 다항식 회귀모형 분석결과 

> (lb1 <- nls(dd3 ~ a+b*tt, start=c(a=1, b=1)))

Nonlinear regression model
  model: dd3 ~ a + b * tt
   data: parent.frame()
      a       b 
1248.43   15.94 
 residual sum-of-squares: 193713

Number of iterations to convergence: 1 
Achieved convergence tolerance: 2.03e-09

> (lb3 <- nls(dd3 ~ a+b*tt+c*tt^2+d*tt^3, start=c(a=1, b=1, c=1, d=1)))

Nonlinear regression model
  model: dd3 ~ a + b * tt + c * tt^2 + d * tt^3
   data: parent.frame()
        a         b         c         d 
1091.7701   75.3521   -5.2872    0.1322 
 residual sum-of-squares: 163888

Number of iterations to convergence: 1 
Achieved convergence tolerance: 3.017e-08

> (lb5 <- nls(dd3 ~ a+b*tt+c*tt^2+d*tt^3+e*tt^4+f*tt^5, start=c(a=1, b=1, c=1, d=1, e=1, f=1)))

Nonlinear regression model
  model: dd3 ~ a + b * tt + c * tt^2 + d * tt^3 + e * tt^4 + f * tt^5
   data: parent.frame()
         a          b          c          d          e          f 
1232.28369 -113.83984   62.66502   -9.24864    0.54245   -0.01106 
 residual sum-of-squares: 116992

Number of iterations to convergence: 1 
Achieved convergence tolerance: 1.059e-06

# (2) 분석결과 요약
plot(tt, dd3, type="b", main="Time Series Linear / Polynomial - nls")
lines(tt, fitted(lb1), lty=1, col=1, lwd=1)
lines(tt, fitted(lb3), lty=2, col=2, lwd=2)
lines(tt, fitted(lb5), lty=3, col=3, lwd=3)
legend("bottomright", c("Poly (Time, 1차)", "Poly (Time, 3차)", "Poly (Time, 5차)"), 
	col=c(1,2,3), lty=c(1, 2, 3), lwd=c(1,2,3))

# 3) (비선형 함수식) 회귀모형 평활법 분석사례: nls (Gompertz 등)

# (1) 비선형 함수식 회귀모형 평활법 분석

> tt <- seq(1:length(dd3)) # 시간을 이렇게 변환 

> (lc1 <- nls(dd3 ~ SSgompertz(tt, Asym, b2, b3))) 

Nonlinear regression model
  model: dd3 ~ SSgompertz(tt, Asym, b2, b3)
   data: parent.frame()
     Asym        b2        b3 
1509.3385    0.3289    0.8040 
 residual sum-of-squares: 164229

Number of iterations to convergence: 2 
Achieved convergence tolerance: 3.567e-06
  
# Self-Starting Nls Gompertz Growth Model
#   SSgompertz(x, Asym, b2, b3)
# x   : a numeric vector of values at which to evaluate the model.
# Asym: a numeric parameter representing the asymptote.
# b2  : a numeric parameter related to the value of the function at x = 0
# b3  : a numeric parameter related to the scale the x axis.

# Value: a numeric vector of the same length as input. It is the value of the expression Asym*exp(-b2*b3^x). 
# If all of the arguments Asym, b2, and b3 are names of objects, 
# the gradient matrix with respect to these names is attached as an attribute named gradient.

> (lc2 <- nls(dd3 ~ SSmicmen(tt, vm, k)))

Nonlinear regression model
  model: dd3 ~ SSmicmen(tt, vm, k)
   data: parent.frame()
       vm         k 
1513.3551    0.4192 
 residual sum-of-squares: 180529

Number of iterations to convergence: 0 
Achieved convergence tolerance: 2.557e-07

# Self-Starting Nls Michaelis-Menten Model
#   SSmicmen(input, Vm, K)
# Vm  : a numeric parameter representing the maximum value of the response.
# K   : a numeric parameter representing the input value at which half the maximum response is attained. 
# In the field of enzyme kinetics this is called the Michaelis parameter.

# Value: a numeric vector of the same length as input. It is the value of the expression Vm*input/(K+input). 
# If both the arguments Vm and K are names of objects, 
# the gradient matrix with respect to these names is attached as an attribute named gradient.

> summary(lc1)

Formula: dd3 ~ SSgompertz(tt, Asym, b2, b3)

Parameters:
      Estimate Std. Error t value Pr(>|t|)    
Asym 1.509e+03  5.207e+01  28.987 6.48e-16 ***
b2   3.289e-01  9.596e-02   3.427  0.00321 ** 
b3   8.040e-01  9.820e-02   8.187 2.66e-07 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 98.29 on 17 degrees of freedom

Number of iterations to convergence: 2 
Achieved convergence tolerance: 3.567e-06

> summary(lc2)

Formula: dd3 ~ SSmicmen(tt, vm, k)

Parameters:
    Estimate Std. Error t value Pr(>|t|)    
vm 1513.3551    34.4769  43.895   <2e-16 ***
k     0.4192     0.1223   3.428    0.003 ** 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 100.1 on 18 degrees of freedom

Number of iterations to convergence: 0 
Achieved convergence tolerance: 2.557e-07

# (2) 분석결과

plot(tt, dd3, type="b", main="Nonlinear Regression Smoothing: dd3")
lines(tt, predict(lc1, data.frame(tt)), col="red", lty=2, lwd=2)
lines(tt, predict(lc2, data.frame(tt)), col="blue", lty=3, lwd=2)
legend("bottomright", c("Gompertz Curve", "Michaelis-Menton Curve"), col=c("red", "blue"), lty=c(2, 3), lwd=c(2, 2))
# Michaelis-Menton 커브(분수 커브 모양)는 시간축 앞을 높게, Gompertz 커브(expoential 커브 모양) 는 시간축 뒤를 높게 예측

# predict(Nls Gompertz Model, h=20)
round(predict(lc1, data.frame(tt)) , 0)
 [1] 1159 1220 1272 1316 1351 1381 1405 1425 1441 1454 
[11] 1465 1474 1480 1486 1491 1494 1497 1500 1501 1503
attr(,"gradient")
           Asym         b2        b3
 [1,] 0.7676345 -931.55760 -381.0679
 [2,] 0.8084655 -788.83353 -645.3689
 [3,] 0.8428644 -661.22635 -811.4543
 [4,] 0.8715804 -549.75414 -899.5414
 [5,] 0.8953768 -454.08322 -928.7485
 [6,] 0.9149799 -373.08672 -915.7010
 [7,] 0.9310521 -305.23956 -874.0404
 [8,] 0.9441791 -248.87988 -814.4650
 [9,] 0.9548676 -202.37047 -745.0446
[10,] 0.9635490 -164.18989 -671.6439
[11,] 0.9705863 -132.97664 -598.3574
[12,] 0.9762818 -107.54369 -527.9087
[13,] 0.9808852  -86.87535 -461.9900
[14,] 0.9846023  -70.11449 -401.5397
[15,] 0.9876011  -56.54538 -346.9613
[16,] 0.9900188  -45.57510 -298.2910
[17,] 0.9919670  -36.71554 -255.3239
[18,] 0.9935362  -29.56685 -217.7059
[19,] 0.9947996  -23.80266 -185.0000
[20,] 0.9958167  -19.15746 -156.7330

# predict(Nls Michaelis-Menten Model, h=20)
round(predict(lc2, data.frame(tt)), 0)
 [1] 1066 1251 1328 1370 1396 1415 1428 1438 1446 1452 
[11] 1458 1462 1466 1469 1472 1475 1477 1479 1481 1482
attr(,"gradient")
             vm          k
 [1,] 0.7046335 -751.39359
 [2,] 0.8267273 -517.17250
 [3,] 0.8774040 -388.34601
 [4,] 0.9051458 -309.96880
 [5,] 0.9226493 -257.65829
 [6,] 0.9346992 -220.36030
 [7,] 0.9435008 -192.45420
 [8,] 0.9502116 -170.80144
 [9,] 0.9554975 -153.51733
[10,] 0.9597687 -139.40360
[11,] 0.9632918 -127.66266
[12,] 0.9662476 -117.74337
[13,] 0.9687628 -109.25276
[14,] 0.9709292 -101.90322
[15,] 0.9728145  -95.47941
[16,] 0.9744703  -89.81690
[17,] 0.9759359  -84.78802
[18,] 0.9772423  -80.29212
[19,] 0.9784143  -76.24876
[20,] 0.9794714  -72.59294