# height : inch
# weight : pound
data(women)
str(women)

# height^2 추가 : 2차 방정식으로 표현
height2 <- women$height^2
women2 <- cbind(height2, women)

# lm(종속변수(결과)~독립변수(원인), data=women2)
result = lm(weight~height + height2, data=women2)
summary(result)

# 회귀 방정식을 그래프로 표현
plot(weight~height, col="blue", pch=1, data=women2)
lines(women2$height, fitted(result), col='red')

# height^3 추가 : 3차 방정식으로 표현
height3 <- women$height^3
women3 <- cbind(height3, women2)

# lm(종속변수(결과)~독립변수(원인), data=women2)
result = lm(weight~height + height2 + height3, data=women3)
summary(result)

# 회귀 방정식을 그래프로 표현
plot(weight~height, col="blue", pch=1, data=women3)
lines(women3$height, fitted(result), col='green')


# car 패키지 설치가 필요함
library(car)

# scatterplot() 함수는 가로 및 세로축 변수의 boxplot을 그려주고 
# 가장 적합한 회귀직선을 그려줌
scatterplot(weight ~ height, data=women3, pch=19, col="green",
            main="Women Age 30~39",
            xlab="Height(inches)", ylab="Weight(lbs.)")