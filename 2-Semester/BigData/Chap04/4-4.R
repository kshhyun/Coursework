# iris의 종류별 Sepal.Length의 모평균이 차이가 있는지 검정
data("iris")
str(iris)

#일원배치 분산분석
result <- aov(Sepal.Length ~ Species, data=iris)
summary(result)