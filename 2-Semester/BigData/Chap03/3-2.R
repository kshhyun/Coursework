# describe() 함수를 이용하려면 psych 패키지 설치해야 함
library(psych)
setwd("D:/work")
air_pol <- read.csv("air_pollution.csv", fileEncoding = "EUC-KR")
str(air_pol)

# subset 추출
# so2Value : 아황산가스 농도
# coValue : 일산화탄소 농도
# o3Value : 오존 농도
# no2Value : 이산화질소 농도
# pm10Value : 미세먼지 농도
air_data <- subset(air_pol, select=c(so2Value, coValue, o3Value, 
                                     no2Value, pm10Value))
# 기술통계 값 추출 
result <- describe(air_data)
result