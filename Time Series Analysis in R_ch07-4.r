
# 7.2 회귀모형 평활법의 분석사례 - 4

# 17) 초기값 무지정 점근적 비선형 회귀모형 분석사례 : SSasymp 
# (1) 귀무가설

# H0: 산출량(y)은 시간(t)과 독립이다. (비선형 모형과 무관)
# H1: 산출량(y)은 시간(t)과 종속이다. (비선형 모형을 따른다) 

# (2) 비선형 함수 선정

# Self-Starting Nls Asymptotic Regression Model
# This selfStart model evaluates the asymptotic regression function and its gradient. 
# It has an initial attribute that will evaluate initial estimates of the parameters Asym, R0, and lrc for a given set of data.

# Usage:	SSasymp(input, Asym, R0, lrc)
# Arguments
# input		a numeric vector of values at which to evaluate the model.
# Asym		a numeric parameter representing the horizontal asymptote on the right side (very large values of input).
# R0		a numeric parameter representing the response when input is zero.
# lrc		a numeric parameter representing the natural logarithm of the rate constant.

tt <- seq(1:15)
yy <- c(100, 85, 73, 61, 50,
		42, 36, 32, 29, 27, 
		26, 25, 24, 23, 23)
nn1 <- nls(yy ~ SSasymp(tt, Asym, respo, lrc)) # y = Asym + (R0-Asym)*exp(-exp(lrc)*X): 수정지수곡선으로 알려짐
summary(nn1)

Formula: yy ~ SSasymp(tt, Asym, respo, lrc)

Parameters:
       Estimate Std. Error t value Pr(>|t|)    
Asym   18.75167    1.26961   14.77 4.64e-09 *** # H0 기각 = 산출량은 시간에 대한 비선형 모형을 따른다
respo 125.44239    2.69699   46.51 6.37e-15 *** # H0 기각
lrc    -1.40692    0.05223  -26.94 4.21e-12 *** # H0 기각
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.737 on 12 degrees of freedom

Number of iterations to convergence: 0 
Achieved convergence tolerance: 2.491e-06

# 위 사례는 어떠한 초기조건도 없음. self-start 함수 중 SSasymp 적용함
# 곡선 y = Asym + (R0-Asym)*exp(-exp(lrc)*X)
# 즉 비선형함수 y = 18.75167 + (125.44239 - 18.75167)*exp(-exp(-1.40692)*tt)
# 				= 18.75167 + 106.7*exp(-0.25 * tt)
# 				(tt = 0 이면, y= 18.8 + 106.7 = 125.5,
# 				 tt = ∞ 이면, y=18.8
# 				따라서 Asym (점근값) = 18.8, Respo (초기값) = 125.5 이다)

# (3) 추정값 산정 및 그래프 작성 

plot(c(1, 20), c(20, 100), # X축 1~20, Y축 20~100 을 먼저 그렸음
	type="n", main="Non-Linear Regression Plot: \n Self-Start Asymptote",
	xlab="tt: 시간", ylab="yy: 산출량")

pp1 <- predict(nn1, data.frame(tt=dd)) # dd <- seq(1:20)
pp1 
 [1] 102.26765  84.12679  69.92638  58.81050  50.10915  43.29786  37.96608  33.79244
 [9]  30.52537  27.96795  25.96605  24.39898  23.17230  22.21208  21.46043  20.87205
[17]  20.41147  20.05094  19.76872  19.54780
attr(,"gradient")
           Asym       resp0        lrc
 [1,] 0.2172143 0.782785728 -20.452751
 [2,] 0.3872465 0.612753496 -32.020243
 [3,] 0.5203453 0.479654691 -37.597484
 [4,] 0.6245332 0.375466847 -39.241032
 [5,] 0.7060899 0.293910089 -38.396650
 [6,] 0.7699314 0.230068623 -36.067619
 [7,] 0.8199056 0.180094435 -32.938754
 [8,] 0.8590246 0.140975353 -29.467413
 [9,] 0.8896465 0.110353494 -25.950004
[10,] 0.9136169 0.086383140 -22.570326
[11,] 0.9323805 0.067619489 -19.434502
[12,] 0.9470684 0.052931571 -16.596055
[13,] 0.9585659 0.041434079 -14.073751
[14,] 0.9675660 0.032434005 -11.864173
[15,] 0.9746111 0.025388877  -9.950470
[16,] 0.9801259 0.019874050  -8.308358
[17,] 0.9844429 0.015557123  -6.910143
[18,] 0.9878221 0.012177894  -5.727347
[19,] 0.9904673 0.009532681  -4.732357
[20,] 0.9925380 0.007462047  -3.899391

lines(dd, pp1)
points(tt, yy, pch=17, col=4)
points(dd, pp1, pch=16, col=2)
grid()
legend("topright", legend=c("실험측정값", "모형추정값"), col=c(4,2), pch=c(17, 16))
abline(h=coef(nn1)[1], lty=2) # 점근선: tt = ∞ 일 때 산출량 aka 18.75167
aa <- signif(coef(nn1)[1], 3) # signif 는 rounding 의 한 방법  
text(7, 20, paste("Asymptotic Line: yy=", aa))

# (4) 초기값 없는 비선형 회귀모형 분석사례: NLSsaAsymptotic

# 비선형 회귀분석은 변수변환을 통하여 선형 회귀분석 모형으로 분석이 가능하다.
# 그러나 임의로 값을 적용해야 하는등 오차항의 증가가 예상되며, 이에 따라 선형 회귀분석 모형의 정확성은
# 비선형 회귀분석 모형에 비하여 떨어지는 것으로 판단된다.

tt <- seq(1, 15)
yy <- c(100, 85, 73, 61, 50,
		42, 36, 32, 29, 27, 
		26, 25, 24, 23, 23)
lm (log((yy-20)/120) ~ tt-1) # 변환자료 원점 회귀

Call:
lm(formula = log((yy - 20)/120) ~ tt - 1)

Coefficients:
     tt  
-0.2678

nls(yy ~ a1 + a2*exp(-a3*tt), start=list(a1=1, a2=1, a3=1)) # 무정보 초기값
Error in numericDeriv(form[[3L]], names(ind), env) : 
  Missing value or an infinity produced when evaluating the model

nls(yy ~ a1 + a2*exp(-a3*tt), start=list(a1=20, a2=120, a3=1)) # 개략 초기값 a1=20, a2=120으로 가정
Nonlinear regression model
  model: yy ~ a1 + a2 * exp(-a3 * tt)
   data: parent.frame()
      a1       a2       a3 
 18.7517 106.6907   0.2449 
 residual sum-of-squares: 36.22

Number of iterations to convergence: 8 
Achieved convergence tolerance: 2.463e-06

NLSstAsymptotic(sortedXyData(tt, yy)) ## 순서화된 자료 입력
         b0          b1         lrc   ## 수식은 다음과 같다
 125.442395 -106.690722   -1.406921   ## y= b0 + b1*(1-exp(-exp(lrc)*tt))

> b0 =  125.442395
> b1 = -106.690722
> lrc = -1.406921
> y = b0 + b1*(1-exp(-exp(lrc)*tt))
> y
 [1] 102.26766  84.12680  69.92640  58.81052  50.10917  43.29788  37.96609  33.79245
 [9]  30.52538  27.96796  25.96605  24.39899  23.17231  22.21209  21.46044

# sortedXyData(tt, yy)
#     x   y
# 1   1 100
# 2   2  85
# 3   3  73
# 4   4  61
# 5   5  50
# 6   6  42
# 7   7  36
# 8   8  32
# 9   9  29
# 10 10  27
# 11 11  26
# 12 12  25
# 13 13  24
# 14 14  23
# 15 15  23

# NLSstAsymptotic(xy)
# xy	a sortedXyData object
# Fit the Asymptotic Regression Model
# Fits the asymptotic regression model, in the form b0 + b1*(1-exp(-exp(lrc) * x) to the xy data. 
# This can be used as a building block in determining starting estimates for more complicated models.



# 18) 초기값 무지정 점근적 Offset 비선형 회귀모형 분석사례: SSasympOff

# (1) 귀무가설

# H0: 산출량(y)은 시간(t)과 독립이다. (비선형 Off 모형과 무관)
# H1: 산출량(y)은 시간(t)과 종속이다. (비선형 Off 모형을 따른다) 

# (2) 비선형 함수 선정

# y = Asym * (1-exp(-exp(lrc) * (input-c0))) # 절편형 수정 지수곡선

tt <- c(1, 2, 4, 5, 6, 8, 9, 10, 13, 15, 18, 20, 24, 28, 30) # note: 시간축 일정치 않음
yy <- c(2, 15, 29, 34, 45, 55, 63, 70, 76, 80, 83, 85, 86, 87, 87)
nn2 <- nls(yy ~ SSasympOff(tt, Asym, lrc, C0)) # 절편형 수정 지수곡선으로 알려짐
summary(nn2)

Formula: yy ~ SSasympOff(tt, Asym, lrc, C0)

Parameters:
     Estimate Std. Error t value Pr(>|t|)    
Asym 90.43057    1.77405  50.974 2.13e-15 *** # H0 기각: 산출요소는 시간에 대해 비선형 Offset 모형을 따른다
lrc  -1.95561    0.06669 -29.324 1.54e-12 ***
C0    0.95506    0.16791   5.688 0.000101 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.751 on 12 degrees of freedom

Number of iterations to convergence: 0 
Achieved convergence tolerance: 5.233e-0

# 비선형 함수 y = 90.4 + 1-exp(-exp(-1.96)*(tt-0.96))
				# (tt=0이면 y = -13.1, tt = 0.96이면 yy=1
				# tt =∞이면 y = 90.4로 예측된다 
				# 따라서 Asym(점근값) = 90.4 가 되며 Offset = 0.96)

# (3) 추정값 산정 및 그래프 작성 

dd = seq(1, 40)
pp2 <- predict(nn2, data.frame(tt=dd))
plot(dd, pp2, type="n", xlab="tt", ylab="yy", main="Non-Linear Regression Plot: \n Self-Start Asymptote - Offset")
round(pp2, 1)
 [1]  0.6 12.4 22.7 31.7 39.4 46.1 52.0 57.1 61.5 65.3 68.6 71.5 74.0 76.1 78.0 79.7
[17] 81.1 82.3 83.4 84.3 85.1 85.8 86.4 87.0 87.4 87.8 88.2 88.5 88.7 88.9 89.1 89.3
[33] 89.5 89.6 89.7 89.8 89.9 90.0 90.0 90.1
attr(,"gradient")
             Asym       lrc           C0
 [1,] 0.006337245  0.571261 -12.71287110
 [2,] 0.137427047 11.531612 -11.03571480
 [3,] 0.251222715 19.590113  -9.57981876
 [4,] 0.350005794 25.321664  -8.31599304
 [5,] 0.435756831 29.199980  -7.21889861
 [6,] 0.510195090 31.614287  -6.26653929
 [7,] 0.574813018 32.883366  -5.43982077
 [8,] 0.630906171 33.267368  -4.72216780
 [9,] 0.679599188 32.977734  -4.09919181
[10,] 0.721868337 32.185521  -3.55840245
[11,] 0.758561092 31.028376  -3.08895719
[12,] 0.790413125 29.616375  -2.68144389
[13,] 0.818063051 28.036902  -2.32769213
[14,] 0.842065237 26.358719  -2.02060937
[15,] 0.862900915 24.635362  -1.75403877
[16,] 0.880987828 22.907956  -1.52263572
[17,] 0.896688610 21.207565  -1.32176071
[18,] 0.910318053 19.557126  -1.14738631
[19,] 0.922149420 17.973052  -0.99601639
[20,] 0.932419923 16.466558  -0.86461609
[21,] 0.941335482 15.044744  -0.75055088
[22,] 0.949074849 13.711487  -0.65153381
[23,] 0.955793192 12.468167  -0.56557966
[24,] 0.961625213 11.314259  -0.49096509
[25,] 0.966687839 10.247810  -0.42619410
[26,] 0.971082574  9.265827  -0.36996808
[27,] 0.974897530  8.364584  -0.32115973
[28,] 0.978209195  7.539870  -0.27879046
[29,] 0.981083965  6.787177  -0.24201079
[30,] 0.983579479  6.101856  -0.21008331
[31,] 0.985745770  5.479232  -0.18236789
[32,] 0.987626272  4.914688  -0.15830885
[33,] 0.989258686  4.403738  -0.13742382
[34,] 0.990675743  3.942065  -0.11929407
[35,] 0.991905854  3.525561  -0.10355610
[36,] 0.992973681  3.150342  -0.08989437
[37,] 0.993900634  2.812766  -0.07803498
[38,] 0.994705298  2.509429  -0.06774015
[39,] 0.995403806  2.237174  -0.05880347
[40,] 0.996010163  1.993079  -0.05104578

lines(dd, pp2)
points(tt, yy, pch=17, col=4)
points(dd, pp2, pch=16, col=2)
legend("bottomright", legend=c("실험측정값", "모형추정값"), col=c(4, 2), pch=c(17, 16))
abline(h=coef(nn2)[1], lty=2)
aa <- signif(coef(nn2)[1], 3)
cc <- signif(coef(nn2)[3], 3)
text(10, 88, paste("Asymptotic Line: yy =", aa), cex=.8)
text(10, 85, paste("Offset Values: C0 =", cc), cex=.8)

# 19) 초기값 무지정 점근적 원점회귀 비선형 회귀모형 분석사례: SSasympOrig

# (1) 귀무가설

# (2) 비선형 함수 선정

# (3) 추정값 산정 및 그래프 작성 

# 20) 초기값 무지정 이중 지수 비선형 회귀모형 분석사례: SSbiexp

# (1) 귀무가설

# (2) 비선형 함수 선정

# (3) 추정값 산정 및 그래프 작성 

# 21) 초기값 무지정 1차 분할 비선형 회귀분석 사례: SSfol

# (1) 귀무가설

# (2) 비선형 함수 선정

# (3) 추정값 산정 및 그래프 작성 

# 22) 초기값 무지정 로지스틱 비선형 회귀분석 사례: SSfpl, SSlogis

# (1) 귀무가설

# (2) 비선형 함수 선정

# (3) 추정값 산정 및 그래프 작성 

# 23) 초기값 무지정 곰페르츠 비선형 회귀분석 사례: SSfgompertz

# (1) 귀무가설

# (2) 비선형 함수 선정

# (3) 추정값 산정 및 그래프 작성 


# 24) 초기값 무지정 Michaelis-Menten 비선형 회귀분석 사례: SSmicmen

# (1) 귀무가설

# (2) 비선형 함수 선정

# (3) 추정값 산정 및 그래프 작성 


# 25) 초기값 무지정 Weibull 비선형 회귀분석 사례: SSweibull

# (1) 귀무가설

# (2) 비선형 함수 선정

# (3) 추정값 산정 및 그래프 작성 


