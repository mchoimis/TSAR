
# 9.2 요소분해법의 분석사례

# 1) 시계열 자료의 분해: Decompose 분석사례 (1) (가법모형)

# (1) 분석자료ㅣ 1.2절의 계절변동 자료(dd2) 및 계절, 추세변동 자료(dd4)

# (2) 가법모형(additive) 분석결과: 다음의 3개 성분으로 표현된다

dd2.ts <- ts(data=dd2, start=c(2006, 1), frequency=4)
dd4.ts <- ts(dat=dd4, sta=c(2006, 1), freq=4)
     Qtr1 Qtr2 Qtr3 Qtr4
2006 1142 1242 1452 1543
2007 1225 1362 1556 1672ㅂ
2008 1343 1459 1662 1753
2009 1421 1558 1772 1846
2010 1554 1649 1877 1948

plot(decompose(dd2.ts, type="additive"))
plot(decompose(dd4.ts, type="additive"))

# (3) 분석결과

dd <- decompose(dd4.ts, type="a")
names(dd) # 분석결과의 내용
[1] "x"        "seasonal" "trend"    "random"   "figure"   "type" 

dd$seasonal # 계절변동 분석결과 
           Qtr1       Qtr2       Qtr3       Qtr4
2006 -178.85156  -83.53906   97.49219  164.89844
2007 -178.85156  -83.53906   97.49219  164.89844
2008 -178.85156  -83.53906   97.49219  164.89844
2009 -178.85156  -83.53906   97.49219  164.89844
2010 -178.85156  -83.53906   97.49219  164.89844

dd$trend # 추세변동 분석결과 
         Qtr1     Qtr2     Qtr3     Qtr4
2006       NA       NA 1355.125 1380.500
2007 1408.500 1437.625 1468.500 1495.375
2008 1520.750 1544.125 1564.000 1586.125
2009 1612.250 1637.625 1665.875 1693.875
2010 1718.375 1744.250       NA       NA

dd$ random # 우연변동 분석결과 
            Qtr1        Qtr2        Qtr3        Qtr4
2006          NA          NA  -0.6171875  -2.3984375
2007  -4.6484375   7.9140625  -9.9921875  11.7265625
2008   1.1015625  -1.5859375   0.5078125   1.9765625
2009 -12.3984375   3.9140625   8.6328125 -12.7734375
2010  14.4765625 -11.7109375          NA          NA
 
( ddd1 <- dd4 - dd$seasonal ) # 계절변동 제거자료 # 식 잘 살펴볼 것 
         Qtr1     Qtr2     Qtr3     Qtr4
2006 1320.852 1325.539 1354.508 1378.102 # 1320.852-178.852 = 1142 
2007 1403.852 1445.539 1458.508 1507.102
2008 1521.852 1542.539 1564.508 1588.102
2009 1599.852 1641.539 1674.508 1681.102
2010 1732.852 1732.539 1779.508 1783.102

( ddd2 <- dd4 - dd$trend ) # 추세변동 제거자료
         Qtr1     Qtr2     Qtr3     Qtr4
2006       NA       NA   96.875  162.500
2007 -183.500  -75.625   87.500  176.625
2008 -177.750  -85.125   98.000  166.875
2009 -191.250  -79.625  106.125  152.125
2010 -164.375  -95.250       NA       NA

plot(ddd1, main="계절변동을 제거한 시계열 자료: ddd1")
plot(ddd2, main="추세변동을 제거한 시계열 자료: ddd2")


# 2) 시계열 자료의 분해: Decompose 분석사례 (2) (승법모형)

# (1) 분석자료

# (2) 승법모형(multiplicative) 분석결과: 다음의 3개 성분으로 표현된다

plot(decompose(dd2.ts, type="multiplicative"))
plot(decompose(dd4.ts, "m"))

# (3) 분석결과

ddd <- decompose(dd4.ts, "m")
names(ddd)
[1] "x"        "seasonal" "trend"    "random"   "figure"   "type"

ddd$seasonal # 계절변동 분석결과
          Qtr1      Qtr2      Qtr3      Qtr4
2006 0.8837622 0.9463204 1.0633044 1.1066129
2007 0.8837622 0.9463204 1.0633044 1.1066129
2008 0.8837622 0.9463204 1.0633044 1.1066129
2009 0.8837622 0.9463204 1.0633044 1.1066129
2010 0.8837622 0.9463204 1.0633044 1.1066129

ddd$trend # 추세변동 분석결과
         Qtr1     Qtr2     Qtr3     Qtr4
2006       NA       NA 1355.125 1380.500
2007 1408.500 1437.625 1468.500 1495.375
2008 1520.750 1544.125 1564.000 1586.125
2009 1612.250 1637.625 1665.875 1693.875
2010 1718.375 1744.250       NA       NA

ddd$random # 우연변동 분석결과
          Qtr1      Qtr2      Qtr3      Qtr4
2006        NA        NA 1.0076962 1.0100289
2007 0.9841104 1.0011364 0.9965016 1.0103932
2008 0.9992698 0.9984691 0.9993938 0.9987316
2009 0.9973010 1.0053442 1.0003770 0.9848149
2010 1.0232874 0.9990189        NA        NA

ddd1 <- dd4/ddd$seasonal # 계절변동 제거자료
         Qtr1     Qtr2     Qtr3     Qtr4
2006 1292.203 1312.452 1365.554 1394.345
2007 1386.119 1439.259 1463.363 1510.917
2008 1519.640 1541.761 1563.052 1584.113
2009 1607.899 1646.377 1666.503 1668.153
2010 1758.392 1742.539 1765.252 1760.326

ddd2 <- dd4/ddd$trend # 추세변동 제거자료
          Qtr1      Qtr2      Qtr3      Qtr4
2006        NA        NA 1.0714879 1.1177110
2007 0.8697196 0.9473959 1.0595846 1.1181142
2008 0.8831169 0.9448717 1.0626598 1.1052092
2009 0.8813770 0.9513778 1.0637053 1.0898089
2010 0.9043428 0.9453920        NA        NA

plot(ddd1, main="계절변동을 제거한 시계열 자료: ddd1")
plot(ddd2, main="추세변동을 제거한 시계열 자료: ddd1")

# 3) 시계열 자료의 분해: Decompose 분석사례 (3)

# (1) 분석자료: 국제 항공여객 자료 1960-1972

# (2) 가법(additive) 및 승법모형(multiplicative) 분석결과

library(TSA)
data(airpass)
plot(decompose(airpass, "a"))
plot(decompose(airpass, "m"))
ddd <- decompose(airpass, "m")
plot(airpass/ddd$seasonal, main="계절변동을 제거한 시계열자료: airpass")
plot(airpass/ddd$trend, main="추세변동을 제거한 시계열자료: airpass")

# (2) 가법(additive) 및 승법모형(multiplicative)의 검정결과

library(tseries)

da <- decompose(airpass, "addi")
dm <- decompose(airpass, "multi")

kpss.test(da$random)
	KPSS Test for Level Stationarity

data:  da$random
KPSS Level = 0.016514, Truncation lag parameter = 2, p-value = 0.1

kpss.test(dm$random)
	KPSS Test for Level Stationarity

data:  dm$random
KPSS Level = 0.030875, Truncation lag parameter = 2, p-value = 0.1

tsdisplay(da$random, main="Random / Additive Model")

tsdisplay(dm$random, main="Random / Multiplicative Model")

# 4) 시계열 자료의 분해: Decompose 분석사례 (4)

# 승법모형은 log 변환하여 가법모형으로 산정

library(ggplot2)

autoplot(decompose(airpass, type="a"))
autoplot(decompose(airpass, type="m"))

ddd <- decopmose(airpass, "m")

autoplot(airpass/ddd$seasonal, main="계절변동을 제거한 시계열")
autoplot(airpass/ddd$trend, main="추세변동을 제거한 시계열")

# 5) STL (Seasonal Decomposition of Time Series by Loess) 분석사례 (1)

library(TSA)
data(airpass)
airpass

plot(stl(airpass, "per"), main="Additive Model / STL")
plot(stl(log(airpass), "per"), main="Multiplicative Model / STL")


