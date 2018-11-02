sessionInfo()
R version 3.4.4 (2018-03-15)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)

Matrix products: default

locale:
[1] LC_COLLATE=Korean_Korea.949  LC_CTYPE=Korean_Korea.949    LC_MONETARY=Korean_Korea.949
[4] LC_NUMERIC=C                 LC_TIME=Korean_Korea.949    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.18      rstudioapi_0.7    magrittr_1.5      uroot_2.0-9      
 [5] forecast_8.4      munsell_0.5.0     colorspace_1.3-2  lattice_0.20-35  
 [9] rlang_0.2.2       quadprog_1.5-5    TTR_0.23-3        plyr_1.8.4       
[13] tools_3.4.4       xts_0.11-0        nnet_7.3-12       parallel_3.4.4   
[17] quantmod_0.4-13   grid_3.4.4        nlme_3.1-137      timeDate_3043.102
[21] gtable_0.2.0      urca_1.3-0        tseries_0.10-45   yaml_2.2.0       
[25] lazyeval_0.2.1    lmtest_0.9-36     tibble_1.4.2      crayon_1.3.4     
[29] ggplot2_3.0.0     curl_3.2          fracdiff_1.4-2    compiler_3.4.4   
[33] pillar_1.3.0      scales_1.0.0      zoo_1.8-3

# 23.2 시계열 군집분석의 분석사례

# 1) R의 시계열 자료 "interest.rates"의 군집분석 사례

# (1) 분석자료

library(TSclust)
data(interest.rates)
describe(interest.rates)

head(interest.rates)
          EMU Spain Germany France Italy Netherlands   UK Ireland Denmark Portugal Austria Sweden Finland Switzerland Norway  USA Canada Japan
Jan 1995 9.34 11.86     7.6   8.23 12.37        7.71 8.73    8.67    9.06    11.79    7.72  11.00   10.24        5.28   8.16 7.78   9.33  4.61
Feb 1995 9.19 11.60     7.4   8.01 12.39        7.54 8.66    8.74    8.86    11.70    7.65  10.71   10.22        5.23   8.00 7.47   8.93  4.52
Mar 1995 9.43 12.26     7.3   8.02 13.45        7.42 8.59    8.86    8.96    11.98    7.51  11.18   10.18        5.04   7.98 7.20   8.62  4.11
Apr 1995 9.26 12.09     7.1   7.82 13.40        7.17 8.44    8.66    8.75    12.17    7.37  11.42    9.41        4.81   7.75 7.06   8.43  3.55
May 1995 8.78 11.41     6.9   7.52 12.30        6.92 8.18    8.10    8.32    11.91    7.13  10.74    8.84        4.66   7.47 6.63   8.03  3.39
Jun 1995 8.75 11.54     6.8   7.45 12.38        6.83 8.11    8.58    8.27    11.89    7.05  10.58    8.70        4.69   7.55 6.17   7.85  3.02

# (2) 분석자료 변환

trans.inter.rates <- log(interest.rates[2:215]) - log(interest.rates[1:214])
head(trans.inter.rates)
[1] -0.016190316  0.025780160 -0.018192048 -0.053227641 -0.003422707 -0.004581910

# (3) 비유사도 산정(1): ACF에 의한 비유사도 산정결과

tsdist <- diss( t(trans.inter.rates), "ACF", p=.05)
names(tsdist)
pvalues.clust(tsdist, .05)

print(tsdist, digits=2)

hc1 <- hclust(tsdist)
plot(hc1, main="Cluster Plot: ACF Dissimilarity")

# (4) 비유사도 산정(2): AR.MAH에 의한 비유사도 산정결과

mahdist <- diss( t(trans.inter.rates), "AR.MAH", p=.05)$p_value
names(mahdist)
pvalues.clust(mahdist, .05)

print(mahdist, digits=3)

hc2 <- hclust(mahdist)
plot(h2, main="Cluster Plot: ARMA - Maharaj Dissimilarity")


# 2) SAX 분석사례 

# (1) 분석자료

set.seed(12349)
n = 100
x <- rnorm(n) # generate sample series, white noise and a wiener process
y <- cumsum(rnorm(n))
w <- 20 # amount of equal-sized frames to divide series, parameters for PAA
alpha <- 4 # size of the alphabet, parameter for SAX
x <- (x - mean(x)) / sd(x) # normalize
y <- (y - mean(y)) / sd(y)
paax <- PAA(x, w) # generate PAA reductions
paay <- PAA(y, w) 

# -----
plot(x, type="l", main="PAA reduction of series x") # plot of PAA reduction
p <- rep(paax, each=length(x)/length(paax)) # just for plotting the PAA
lines(p, col="red", lty=2, lwd=2)
grid()
# -----------
plot(y, type="l", main="PAA reduction of series y") # repeat with y
py <- rep(paay, each=length(y)/length(paay))
lines(py, col="blue", lty=2, lwd=2)
grid()

# (2) 시계열 군집분석 결과

# convert to SAX representation
SAXx <- convert.to.SAX.symbol(paax, alpha)
SAXy <- convert.to.SAX.symbol(paay, alpha)

# calc the sax distnace
MINDIST.SAX(SAXx, SAXy, alpha, n)
[1] 3.694333

# this whole process can be computed using diss.MINDIST.SAX
diss.MINDIST.SAX(x, y, w, alpha, plot=T)
[1] 3.694333

grid()
z <- rnorm(n)^2
diss(rbind(x, y, z), "MINDIST.SAX", w, alpha)
         x        y
y 3.694333         
z 1.508205 5.437910

SAX.plot( as.ts(cbind(x, y, z) ), w=w, alpha=alpha)
title("ST.SAX Dissimilarity: x, y, z")
grid()

