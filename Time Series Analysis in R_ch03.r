## 3.2 시계열 그래프의 작성 사례

## 시계열 자료의 구간별 누적 그래프 cpgram

dd1 <- dd.ts

dd2 <- ts(data=dd2 <- matrix(c(1142, 1242, 1452, 1543, 
	1125, 1262, 1456, 1572, 
	1143, 1269, 1462, 1553, 
	1121, 1258, 1472, 1546, 
	1154, 1249, 1477, 1548)), start=c(2006, 1), f=4)

> dd1
     Qtr1 Qtr2 Qtr3 Qtr4
2006 1342 1442 1252 1343
2007 1425 1362 1456 1272
2008 1243 1359 1412 1253
2009 1201 1478 1322 1406
2010 1254 1289 1497 1208

> dd2
     Qtr1 Qtr2 Qtr3 Qtr4
2006 1142 1242 1452 1543
2007 1125 1262 1456 1572
2008 1143 1269 1462 1553
2009 1121 1258 1472 1546
2010 1154 1249 1477 1548

> window(dd2, c(2008, 2), c(2008, 2)) <-c(1259)
> dd2
     Qtr1 Qtr2 Qtr3 Qtr4
2006 1142 1242 1452 1543
2007 1125 1262 1456 1572
2008 1143 1259 1462 1553
2009 1121 1258 1472 1546
2010 1154 1249 1477 1548

ts.plot(dd1)
ts.plot(dd2)
cpgram(dd1, main="Cumulative Periodogram: dd1")
cpgram(dd2, main="Cumulative Periodogram: dd2")


# 2) 구간별 그래프(monthplot) # 이름은 monthplot 이지만 구간별 그래프임을 명심할 것. 분석사례는 분기별 그래프.

dd4 <- ts(data=dd4 <- matrix(c(1142, 1242, 1452, 1543, 
	1225, 1362, 1556, 1672, 
	1343, 1459, 1662, 1753, 
	1421, 1558, 1772, 1846, 
	1554, 1649, 1877, 1948)), start=c(2006, 1), f=4)

monthplot(dd1, main="Month Plot: dd1", xlab="Quarter: 2006-2010", ylab="Sales") # 분기별로 모은 값 
monthplot(dd4, main="Month Plot: dd4", xlab="Quarter: 2006-2010", ylab="Sales") # 횡으로 그려진 직선은 평균값

# 3) Cosine Taper: Cosine Bel 함수 적용사례


ddb.ts <- spec.taper(dd1, p=0.1)

> ddb.ts
          Qtr1      Qtr2      Qtr3      Qtr4
2006  196.5313 1230.8240 1252.0000 1343.0000
2007 1425.0000 1362.0000 1456.0000 1272.0000
2008 1243.0000 1359.0000 1412.0000 1253.0000
2009 1201.0000 1478.0000 1322.0000 1406.0000
2010 1254.0000 1289.0000 1277.7694  176.9075

ddc.ts <- spec.taper(dd4, p=.1)

> ddc.ts
         Qtr1     Qtr2     Qtr3     Qtr4
2006  167.242 1060.113 1452.000 1543.000
2007 1225.000 1362.000 1556.000 1672.000
2008 1343.000 1459.000 1662.000 1753.000
2009 1421.000 1558.000 1772.000 1846.000
2010 1554.000 1649.000 1602.120  285.278


plot(ddb.ts, main="Taper a Time Series by a Cosine Bell: ddb")
plot(ddc.ts, main="Taper a Time Series by a Cosine Bell: ddc")

# 4) decompose, tsdisplay: 요소분해법 및 ACF, PACF 적용사례


> decompose(dd1)
$x
     Qtr1 Qtr2 Qtr3 Qtr4
2006 1342 1442 1252 1343
2007 1425 1362 1456 1272
2008 1243 1359 1412 1253
2009 1201 1478 1322 1406
2010 1254 1289 1497 1208

$seasonal
          Qtr1      Qtr2      Qtr3      Qtr4
2006 -50.88281  36.92969  24.21094 -10.25781
2007 -50.88281  36.92969  24.21094 -10.25781
2008 -50.88281  36.92969  24.21094 -10.25781
2009 -50.88281  36.92969  24.21094 -10.25781
2010 -50.88281  36.92969  24.21094 -10.25781

$trend
         Qtr1     Qtr2     Qtr3     Qtr4
2006       NA       NA 1355.125 1355.500
2007 1371.000 1387.625 1356.000 1332.875
2008 1327.000 1319.125 1311.500 1321.125
2009 1324.750 1332.625 1358.375 1341.375
2010 1339.625 1336.750       NA       NA

$random
            Qtr1        Qtr2        Qtr3        Qtr4
2006          NA          NA -127.335938   -2.242188
2007  104.882812  -62.554688   75.789062  -50.617188
2008  -33.117188    2.945312   76.289062  -57.867188
2009  -72.867188  108.445312  -60.585938   74.882812
2010  -34.742188  -84.679688          NA          NA

$figure
[1] -50.88281  36.92969  24.21094 -10.25781

$type
[1] "additive"

attr(,"class")
[1] "decomposed.ts"


plot(decompose(dd1))

library(forecast)
tsdisplay(dd1, main="Time Series Display: dd1")

plot(decompose(dd4))


# 5) 시계열 자료 milk의 Time Lag Plot -- 주기 파악

library(TSA) 
data(milk) # 월 우유 매출 데이터 로드
lag.plot(milk, set=c(1:12), pch=".", main="Milk - Time Lag Plot", diag.col="red", do.lines=T)


# 6) Local Mean에 의한 적용사례 (wapply 사용)

library(gplots)
x <- 1:1000
y <- rnorm(1000, mean=1, sd=1 + x/1000)
(ww = wapply (x, y, fun=mean))
$x
 [1]    1.00000   21.38776   41.77551   62.16327   82.55102
 [6]  102.93878  123.32653  143.71429  164.10204  184.48980
[11]  204.87755  225.26531  245.65306  266.04082  286.42857
[16]  306.81633  327.20408  347.59184  367.97959  388.36735
[21]  408.75510  429.14286  449.53061  469.91837  490.30612
[26]  510.69388  531.08163  551.46939  571.85714  592.24490
[31]  612.63265  633.02041  653.40816  673.79592  694.18367
[36]  714.57143  734.95918  755.34694  775.73469  796.12245
[41]  816.51020  836.89796  857.28571  877.67347  898.06122
[46]  918.44898  938.83673  959.22449  979.61224 1000.00000

$y
 [1] 0.8898016 0.8252369 0.8113985 0.7855398 0.8489437 0.7985191
 [7] 0.8477094 0.8756244 0.9529308 0.8902978 0.9109401 0.8751572
[13] 1.0122928 1.1297353 1.0855169 1.1398610 1.0746783 1.0202677
[19] 0.8808003 0.8307668 0.8222650 0.9154708 0.8633681 0.8687593
[25] 0.8667514 0.9742279 0.9466240 0.9905449 0.9217791 0.9062578
[31] 0.6764072 0.7457633 0.7319693 0.8747086 0.8892384 0.9834742
[37] 0.8327904 0.9159689 0.6990015 0.7538209 0.7228135 0.6956833
[43] 0.7201268 0.8999924 0.9205402 0.9873289 1.0388301 1.1861503
[49] 1.0822719 1.1550113

plot(x, y, main="Wapply Plot by Local Mean")
lines( wapply (x, y, fun=mean, col="red", lwd=2))

CL <- function(x, sd) mean(x) + sd*sqrt(var(x))

lines( wapply (x, y, CL, sd= 1), col="blue", lwd=2)
lines( wapply (x, y, CL, sd=-1), col="blue", lwd=2)
lines( wapply (x, y, CL, sd= 2), col="green", lwd=2)
lines( wapply (x, y, CL, sd=-2), col="green", lwd=2)
legend("bottomleft", c("m +/- 2d", "m +/- d", "Local Mean"), col=c(3, 4, 2), lwd=c(2, 2, 2), cex=.6)


# 7) Fraction Mean 에 의한 Band Plot

library(gplots)
bandplot(x, y, add=F, 
	sd=c(-2:2), # 표준편차 구간 설정
	sd.lwd=c(2, 2, 3, 2, 2), # 선의 특성
	sd.col=c("magenta", "blue", "red", "blue", "magenta"), 
	sd.lty=c(2, 1, 1, 1, 2), # 선의 형태: 점선, 실선, 실선, 실선, 점선
	method="frac", 
	width=1/5, n=50)

bandplot(x, y, main="Band Plot by Fraction")
legend("bottomleft", c("m +/- 2d", "m +/- d", "Mean"), col=c("magenta", "blue", "red"), lwd=c(2, 2, 2), cex=.6)

# 8) Bivariate Time Series Plots

library(tsDyn)
( xx <- lynx ) # lynx 캐나다 야생 시라소니 개체수 데이터 불러왔음
Time Series:
Start = 1821 
End = 1934 
Frequency = 1 
  [1]  269  321  585  871 1475 2821 3928 5943 4950 2577  523   98
 [13]  184  279  409 2285 2685 3409 1824  409  151   45   68  213
 [25]  546 1033 2129 2536  957  361  377  225  360  731 1638 2725
 [37] 2871 2119  684  299  236  245  552 1623 3311 6721 4254  687
 [49]  255  473  358  784 1594 1676 2251 1426  756  299  201  229
 [61]  469  736 2042 2811 4431 2511  389   73   39   49   59  188
 [73]  377 1292 4031 3495  587  105  153  387  758 1307 3465 6991
 [85] 6313 3794 1836  345  382  808 1388 2713 3800 3091 2985 3790
 [97]  674   81   80  108  229  399 1132 2432 3574 2935 1537  529
[109]  485  662 1000 1590 2657 3396

autopairs(xx, type="levels") # Countour Levels
autopairs(xx, type="persp") # Perspective Plots
autopairs(xx, type="image") # Image Map
autopairs(xx, type="lines") # lines
autopairs(xx, type="points") # scatter
autopairs(xx, type="regression") # regression plot


# 9) Trivariate Time Series Plots

library(tsDyn)
head(log(lynx), 5) # 로그 변환
Time Series:
Start = 1821 
End = 1825 
Frequency = 1 
[1] 5.594711 5.771441 6.371612 6.769642 7.296413


autotriples(log(lynx), lags=0:1, type="levels") # Countour Levels: lag0-lag1
autotriples(log(lynx), lags=0:2, type="levels") # Countour Levels: lag0-lag2
autotriples(log(lynx), lags=1:2, type="levels") # Countour Levels: lag1-lag2
autotriples(log(lynx), type="persp") # Persp
autotriples(log(lynx), type="image") # Image Map
autotriples(log(lynx), type="points") # cloud # Not working?

# 10) 패키지 forecast의 ggplot2 이용

library(forecast)
data(airpass)

p <- autoplot(airpass, main="Airpassengers / Loess Line" )
p <- p + geom_ribbon(aes(ymin = airpass-50, ymax = airpass+50), fill = "lightblue") # +/- 50 영역 색 채움 
p <- p + geom_line(aes(y = airpass)) # 원 자료 선 추가
p <- p + stat_smooth(method="loess", se=F, col="red") # smooth line 추가
p

data(gold)
autoplot(gold) + stat_smooth(method="loess", se=T, col="red")

# 11) 패키지 forecast 에서  seasonal 요소 제외 그래프 

library(forecast)
data(airpass)

plot(airpass, main="Airpassengers / Seasonal Adjustment")
lines(seasadj(decompose(airpass)), col=2, lwd=2) # seasonal 요소 제외한 선 추가

data(milk)
plot(milk, main="Milk Sales / Seasonal Adjustment")
lines(seasadj(decompose(milk)), col=2, lwd=2)

data(gold)
plot(gold, main="Gold Price / Seasonal Adjustment")
Error in decompose(gold) : time series has no or less than 2 periods ## 피리어드 없어서(?) 에러 발생 

> gold
Time Series:
Start = 1 
End = 252 
Frequency = 1


# 12) Seasonal Plot

> AirPassengers
     Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
1949 112 118 132 129 121 135 148 148 136 119 104 118
1950 115 126 141 135 125 149 170 170 158 133 114 140
1951 145 150 178 163 172 178 199 199 184 162 146 166
1952 171 180 193 181 183 218 230 242 209 191 172 194
1953 196 196 236 235 229 243 264 272 237 211 180 201
1954 204 188 235 227 234 264 302 293 259 229 203 229
1955 242 233 267 269 270 315 364 347 312 274 237 278
1956 284 277 317 313 318 374 413 405 355 306 271 306
1957 315 301 356 348 355 422 465 467 404 347 305 336
1958 340 318 362 348 363 435 491 505 404 359 310 337
1959 360 342 406 396 420 472 548 559 463 407 362 405
1960 417 391 419 461 472 535 622 606 508 461 390 432

seasonplot(AirPassengers, col=rainbow(12), year.labels=T)
ggseasonplot(AirPassengers, year.labels=T, continuous=T)

> milk
      Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec
1994 1343 1236 1401 1396 1457 1388 1389 1369 1318 1354 1312 1370
1995 1404 1295 1453 1427 1484 1421 1414 1375 1331 1364 1320 1380
1996 1415 1348 1469 1441 1479 1398 1400 1382 1342 1391 1350 1418
1997 1433 1328 1500 1474 1529 1471 1473 1446 1377 1416 1369 1438
1998 1466 1347 1515 1501 1556 1477 1468 1443 1386 1446 1407 1489
1999 1518 1404 1585 1554 1610 1516 1498 1487 1445 1491 1459 1538
2000 1579 1506 1632 1593 1636 1547 1561 1525 1464 1511 1459 1519
2001 1549 1431 1599 1571 1632 1555 1552 1520 1472 1522 1485 1549
2002 1591 1472 1654 1621 1678 1587 1578 1570 1497 1539 1496 1575
2003 1615 1489 1666 1627 1671 1596 1597 1571 1511 1561 1517 1596
2004 1624 1531 1661 1636 1692 1607 1623 1601 1533 1583 1531 1610
2005 1643 1522 1707 1690 1760 1690 1683 1671 1599 1637 1592 1663

seasonplot(milk, col=rainbow(12), year.labels=T)
ggseasonplot(milk, year.labels=T, contitnuous=T)

