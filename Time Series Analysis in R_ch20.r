
# 20.2 칼만 필터의 분석사례

# 1) Nile River 시계열 자료에 대한 칼만 필터 분석: fkf

# (1) 입력자료

Nile
Time Series:
Start = 1871 
End = 1970 
Frequency = 1 
  [1] 1120 1160  963 1210 1160 1160  813 1230 1370 1140  995
 [12]  935 1110  994 1020  960 1180  799  958 1140 1100 1210
 [23] 1150 1250 1260 1220 1030 1100  774  840  874  694  940
 [34]  833  701  916  692 1020 1050  969  831  726  456  824
 [45]  702 1120 1100  832  764  821  768  845  864  862  698
 [56]  845  744  796 1040  759  781  865  845  944  984  897
 [67]  822 1010  771  676  649  846  812  742  801 1040  860
 [78]  874  848  890  744  749  838 1050  918  986  797  923
 [89]  975  815 1020  906  901 1170  912  746  919  718  714
[100]  740

y <- Nile
y[c(3, 10)] <- NA
y
Time Series:
Start = 1871 
End = 1970 
Frequency = 1 
  [1] 1120 1160   NA 1210 1160 1160  813 1230 1370   NA  995
 [12]  935 1110  994 1020  960 1180  799  958 1140 1100 1210
 [23] 1150 1250 1260 1220 1030 1100  774  840  874  694  940
 [34]  833  701  916  692 1020 1050  969  831  726  456  824
 [45]  702 1120 1100  832  764  821  768  845  864  862  698
 [56]  845  744  796 1040  759  781  865  845  944  984  897
 [67]  822 1010  771  676  649  846  812  742  801 1040  860
 [78]  874  848  890  744  749  838 1050  918  986  797  923
 [89]  975  815 1020  906  901 1170  912  746  919  718  714
[100]  740

# ------------------
# Set state space model:
# ------------------
build <- function(x){dlmModPoly(order=1, dV=exp(x[1]), dW=exp(x[2]))}
# ------------------
# Estimate parameters:
# ------------------
library(dlm)
fit <- dlmMLE(y, parm=c(1, 1), build)
fit
$par
[1] 9.609626 7.376469

$value
[1] 538.9973

$counts
function gradient 
      31       31 

$convergence
[1] 0

$message
[1] "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
# ------------------
# Modify model:
# ------------------
mod <- build(fit$par)
mod
$FF
     [,1]
[1,]    1

$V
         [,1]
[1,] 14907.59

$GG
     [,1]
[1,]    1

$W
         [,1]
[1,] 1597.938

$m0
[1] 0

$C0
      [,1]
[1,] 1e+07
# ------------------
# Filtering:
# ------------------
filt <- dlmFilter(y, mod)
# ------------------
# Smoothing:
# ------------------
smooth <- dlmSmooth(filt)
# ------------------
# Print Results
# ------------------
filt$m
Time Series:
Start = 1870 
End = 1970 
Frequency = 1 
  [1]    0.0000 1118.3331 1140.2123 1140.2123 1169.8801
  [6] 1166.4479 1164.4328 1060.5394 1109.1998 1182.9578
 [11] 1182.9578 1120.5401 1063.9124 1077.3691 1053.5846
 [16] 1044.1186 1020.5585 1065.0683  990.9200  981.7540
 [21] 1025.7942 1046.4408 1091.9429 1108.0933 1147.5677
 [26] 1178.8426 1190.2911 1145.7041 1132.9910 1033.1335
 [31]  979.4112  950.0899  878.8557  895.8636  878.3774
 [36]  829.0379  853.2274  808.3802  867.2446  918.0800
 [41]  932.2440  904.0819  854.5464  743.6863  766.0265
 [46]  748.2168  851.6324  920.7186  896.0405  859.3120
 [51]  848.6551  826.2200  831.4439  840.4997  846.4803
 [56]  805.1788  816.2555  796.1569  796.1132  863.9530
 [61]  834.7592  819.8055  832.3768  835.8881  865.9606
 [66]  898.7946  898.2954  877.0730  914.0481  874.2577
 [71]  819.1101  771.7921  792.4339  797.8764  782.3338
 [76]  787.5260  857.7544  858.3791  862.7242  858.6285
 [81]  867.3548  833.0423  809.6650  817.5467  882.2062
 [86]  892.1626  918.2645  884.5335  895.2333  917.4213
 [91]  888.9317  925.3898  919.9963  914.7123  985.7234
 [96]  965.2164  904.2389  908.3449  855.3983  816.0668
[101]  794.9080
smooth$s # Kalman Smoothing 결과 출력
Time Series:
Start = 1870 
End = 1970 
Frequency = 1 
  [1] 1136.0765 1136.2580 1138.1823 1137.7679 1137.3535
  [6] 1129.1521 1117.6442 1101.5962 1116.4827 1119.2013
 [11] 1095.0369 1070.8725 1054.8408 1051.6548 1042.2148
 [16] 1037.9430 1035.5944 1041.3488 1032.2413 1048.1347
 [21] 1073.6897 1092.1368 1109.7412 1116.5988 1119.8762
 [26] 1109.2056 1082.3715 1040.7850 1000.3546  949.2432
 [31]  916.9161  892.8336  870.7698  867.6539  856.7833
 [36]  848.4619  855.9470  856.9950  875.7287  878.9981
 [41]  863.9379  837.6161  812.0034  795.6095  815.6181
 [46]  834.7283  868.0655  874.3981  856.5484  841.3301
 [51]  834.4008  828.9078  829.9436  829.3655  825.0749
 [56]  816.8263  821.3147  823.2643  833.7101  848.1981
 [61]  842.1270  844.9662  854.6619  863.2494  873.7931
 [66]  876.8114  868.3402  856.7969  848.9835  823.9108
 [71]  804.5095  798.8832  809.3228  815.8309  822.7497
 [76]  838.3240  857.8991  857.9548  857.7913  855.8904
 [81]  854.8353  850.0109  856.5497  874.6167  896.6087
 [86]  902.1588  906.0108  901.2888  907.7455  912.5670
 [91]  910.6964  919.0835  916.6533  915.3651  915.6167
 [96]  888.6010  859.0772  841.6741  815.9825  800.7936
[101]  794.9080