
# 11.2 AR 모형의 분석사례

# 1) AR 모형의 ACF 및 PACF 산정사례

x = w = rnorm(30)
for(t in 2:300) x[t]=0.7*x[t-1]+w[t]

x.ts=ts(x)
acf(x.ts, main="Yt = 0.7*Yt-1 + wt")
pacf(x.ts, main="Yt = 0.7*Yt-1 + wt")

# 2) AR 모형의 분석사례 (우연변동의 시계열 자료): ar

# (1) 분석자료 및 정상성 검정

dd1 <- matrix()

dd1.ts <- ts(data=dd1, start=c(2006, 1), frequency=4)

kpss.test(dd1.ts)

kpss.test(dd1.ts, "Trend")

tsdisplay(dd1.ts, main="Time Series Display: dd1.ts")

# (2) method=Yule-Walker 모형: 모형은 AR(2)로 구성되며 결과는 다음과 같다.

(a1 <- ar(dd1.ts, m=c("yule-walker")))

(f1 <- forecast(a1))

accuracy(f1)

plot(f1, xlab="Time", ylab="Series")
abline(h=mean(dd1)) ; grid()
title("\n \n dd1.ts: method=Yule-Walker")

Box.test(a1$resid, type="Ljung-Box" # 잔차의 독립성 검정
temp <- window(a1$resid, start=c(2006, 3))
jarque.bera.test(temp)

# (3) method = Burg: 모형은 AR(13)로 구성되며, 결과는 다음과 같다

(a2 <- ar(dd1.ts, m=c("burg")))

(f2 <- forecast(a2))

accuracy(f2)

plot(f2, xlab="Time", ylab="Series")
abline(h=mean(dd1)) ; grid()
title("\n \n dd1.ts: method=Burg")

Box.test(a2$resid, type="Ljung-Box" # 잔차의 독립성 검정
temp <- window(a2$resid, start=c(2009, 2))
jarque.bera.test(temp)

# (4) method=OLS: 모형은 AR(8)로 구성되며 결과는 다음과 같다


(a4 <- ar(dd1.ts, m=c("ols")))

(f4 <- forecast(a4))

accuracy(f4)

plot(f4, xlab="Time", ylab="Series")
abline(h=mean(dd1)) ; grid()
title("\n \n dd1.ts: method=OLS")

Box.test(a4$resid, type="Ljung-Box" # 잔차의 독립성 검정
temp <- window(a4$resid, start=c(2008, 1))
jarque.bera.test(temp)

# (5) method=MLE: 모형은 AR(8)로 구성되며 결과는 다음과 같다

dd1 <- c(dd1)

(a5 <- ar(dd1, m=c("mle")))

(f5 <- forecast(a5))

accuracy(f5)

plot(f5, xlab="Time", ylab="Series")
abline(h=mean(dd1)) ; grid()
title("\n \n dd1.ts: method=MLE")

Box.test(a5$resid, type="Ljung-Box" # 잔차의 독립성 검정
temp <- window(a5$resid, start=9)
jarque.bera.test(temp)


# 3) AR 모형의 분석사례(추세, 계절변동의 시계열 자료): ar

# (1) 추세 및 계절변동 시계열 자료 dd4의 정상성 검정

dd4 <- matrix( )
dd4.ts <- ts(data=dd4, start=c(2006, 1), frequency=4)
kpss.test(dd4.ts)

kpss.test(dd4.ts, "Trend")

tsdisplay(dd4.ts, main="Time Series Display: dd4.ts")

# (2) method=Yule-Walker: 모형은 AR(5)로 구성

(c1 <- ar(dd4.ts, m=c("yule-walker")) )

fc1 <- forecast(c1)

accuracy(fc1)

plot(fc1, xlab="Time", ylab="Series")
title("\n \n dd4.ts: method=Yule-Walker")

Box.test(c1$resid, type="Ljung-Box" # 잔차의 독립성 검정
temp <- window(c1$resid, start=c(2007, 2))
jarque.bera.test(temp)

# (3) method=Burg: 모형은 AR(13)로 구성
