
# 11.2 AR 모형의 분석사례

# 1) AR 모형의 ACF 및 PACF 산정사례

x = w = rnorm(30)
for(t in 2:300) x[t]=0.7*x[t-1]+w[t]

x.ts=ts(x)
acf(x.ts, main="Yt = 0.7*Yt-1 + wt")
pacf(x.ts, main="Yt = 0.7*Yt-1 + wt")

