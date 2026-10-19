# MASS 패키지 설치가 필요함
library(MASS)

# 종속변수(반응변수) : bwt (신생아 몸무게(grams))
# 독립변수(예측변수) : age, lwt, race, smoke, ptl, ht, ui
# age : 산모의 나이
# lwt : 산모의 체중
# race : 산모의 인종(백인 : 1, 흑인 : 2, 그외 : 3)
# smoke : 임신중 흡연상태
# ptl : 과거의 조산 회수
# ht : 고혈압내력
# ui : 자궁 과민반응 여부
# ftv: 첫번째 3분기 동안 의사 방문 회수
data(birthwt)
str(birthwt)

# 독립변수의 상관관계를 분석하여 그래프로 표시
library(psych)
pairs.panels(birthwt)

# 다중 회귀분석
result <- lm(bwt~age + lwt + factor(race) + smoke + ptl + ht + ui + ftv, data=birthwt)
summary(result)

# coefplot 패키지를 이용하면 계수 플롯을 만들 수 있음
# 독립변수의 신뢰구간이 0을 포함하지 않으면 통계적으로 유의하다고 볼 수 있음
# coefplot 패키지 설치가 필요함
library(coefplot)
coefplot(result)

# age, ptl, ftv을 제거한 후 다중 회귀분석
result1 <- lm(bwt ~ lwt + factor(race) + smoke + ht + ui, data=birthwt)
summary(result1)

# 분산분석표를 이용한 F-검정
anova(result1, result)

# 다중공선성 확인
library(car)
vif(result1)

# 예측변수들의 상대적 중요도 파악(Robert I. Kabacoff)
relweights <- function(fit){
  R <- cor(fit$model)
  nvar <- ncol(R)
  rxx <- R[2:nvar, 2:nvar]
  rxy <- R[2:nvar, 1]
  svd <- eigen(rxx)
  evec <- svd$vectors
  ev <- svd$values
  delta <- diag(sqrt(ev))
  lambda <- evec %*% delta %*% t(evec)
  lambdasq <- lambda ^ 2
  beta <- solve(lambda) %*% rxy
  rsquare <- colSums(beta ^ 2)
  rawwgt <- lambdasq %*% beta ^ 2
  import <- (rawwgt / rsquare) * 100
  import <- as.data.frame(import)
  row.names(import) <- names(fit$model[2:nvar])
  names(import) <- "Weights"
  dotchart(import$Weights, labels=row.names(import),
           xlab="% of R-Square", pch=19, col="red",
           main="예측변수의 상대적 중요도")
  
  return(import)
}

fit <- lm(bwt~lwt + race + smoke + ht + ui, data=birthwt)
relweights(fit)

# Another sample
states <- as.data.frame(state.x77[,c("Murder", "Population", "Illiteracy", "Income", "Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
relweights(fit)


