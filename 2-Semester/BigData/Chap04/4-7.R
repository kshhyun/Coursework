# galton 데이터셋을 사용하려면 UsingR 패키지를 설치해야 함
library(UsingR)
data(galton)
str(galton)

par(mfrow=c(1,2))
hist(galton$child, main="자녀의 키 분포", xlab="Child", col="blue")
hist(galton$parent, main="부모의 키 분포", xlab="Parent", col="green")

# 부모의 키와 자녀의 키 상관관계 확인
cor.test(galton$child, galton$parent)

# 단순 선형 회귀분석
# lm() 함수 사용 : linear model
# lm(종속변수(결과)~독립변수(원인), data=galton)
result = lm(child~parent, data=galton)
summary(result)

# 회귀 방정식을 그래프로 표현
plot(child~parent, col="blue", pch=1, data=galton)
abline(result, col='red')