# height : inch
# weight : pound
data(women)
str(women)

par(mfrow=c(1,2))
hist(women$weight, main="몸무게 분포", xlab="Weight", col="blue")
hist(women$height, main="키 분포", xlab="Height", col="green")

# 키와 몸무게의 상관관계 확인
cor.test(women$weight, women$height)

# lm(종속변수(결과)~독립변수(원인), data=women)
result = lm(weight~height, data=women)
summary(result)

# 회귀 방정식을 그래프로 표현
plot(weight~height, col="blue", pch=1, data=women)
abline(result, col='red')