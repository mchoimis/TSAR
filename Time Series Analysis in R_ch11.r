
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