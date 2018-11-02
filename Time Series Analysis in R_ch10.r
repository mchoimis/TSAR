
# 10.2 확률모형 분석사례: IID 확률과정

# 1) 백색작음(white noise) 사례

set.seed(18)
w = rnorm(100)
w.ts= (ts(w))
plot(w.ts, xlab="time", main="White Noise")
abline(h=0)
acf(w.ts)
pacf(w.ts)
pp.test(w.ts)
	Phillips-Perron Unit Root Test

data:  w.ts
Dickey-Fuller Z(alpha) = -114.63, Truncation lag parameter = 3, p-value = 0.01 # H0 기각
alternative hypothesis: stationary

# 2) 비정상 시계열 자료의 정상 시계열 변환

# (1) Random Walk의 White Noise 변환

x= w= rnorm(300)
for(t in 2:300) x[t]=x[t-1]+w[t]
x.ts=ts(x)
kpss.test(x.ts)
	KPSS Test for Level Stationarity

data:  x.ts
KPSS Level = 6.0836, Truncation lag parameter = 3, p-value = 0.01 # 비정상시계열

kpss.test(diff(x.ts))
	KPSS Test for Level Stationarity

data:  diff(x.ts)
KPSS Level = 0.077332, Truncation lag parameter = 3, p-value = 0.1 # 정상시계열
tsdisplay(x.ts, main="Random Walk")
tsdisplay(diff(x.ts), main="Difference Random Walk")

# (2) 2차 차분에 따른 자료의 변환

data("SP")
kpss.test(SP)

	KPSS Test for Level Stationarity

data:  SP
KPSS Level = 5.4206, Truncation lag parameter = 2, p-value = 0.01
kpss.test(diff(SP))

	KPSS Test for Level Stationarity

data:  diff(SP)
KPSS Level = 0.066528, Truncation lag parameter = 2, p-value = 0.1
kpss.test(diff(log(SP)))
	KPSS Test for Level Stationarity

data:  diff(log(SP))
KPSS Level = 0.1052, Truncation lag parameter = 2, p-value = 0.1
kpss.test(diff(diff(SP)))

	KPSS Test for Level Stationarity

data:  diff(diff(SP))
KPSS Level = 0.009702, Truncation lag parameter = 2, p-value = 0.1
tsdisplay(SP)
tsdisplay(diff(diff(SP)))

# (3) Box-Cox 변환에 따른 자료의 변환

lambda = BoxCox.lambda(SP)
newSP = BoxCox(SP, lambda)
kpss.test(newSP)
data:  newSP
KPSS Level = 5.5181, Truncation lag parameter = 2, p-value = 0.01
kpss.test(diff(newSP))
data:  diff(newSP)
KPSS Level = 0.10134, Truncation lag parameter = 2, p-value = 0.1

kpss.test(diff(log(newSP)))
data:  diff(log(newSP))
KPSS Level = 0.10384, Truncation lag parameter = 2, p-value = 0.1

kpss.test(diff(diff(newSP)))
data:  diff(diff(newSP))
KPSS Level = 0.0089476, Truncation lag parameter = 2, p-value = 0.1

tsdisplay(newSP)
tsdisplay(diff(diff(newSP)))

