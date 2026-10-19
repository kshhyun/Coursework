# 교육생 300명에 대한 설문조사 결과
setwd("D:/work")
data <- read.csv("two_samples.csv", fileEncoding = "euc-kr", header=TRUE)
str(data)

# 데이터 전처리(두 집단 subset 추출)
# 교육방법에 대한 빈도 수 추출 : 1(PT), 2(Coding)
n1 <- length(which(data$method==1))
n2 <- length(which(data$method==2))
n <- c(n1, n2)

# 만족도에 대한 빈도 수 추출: 0(불만족), 1(만족)
x1 <- length(which(data$method==1 & data$survey==1))
x2 <- length(which(data$method==2 & data$survey==1))
x <- c(x1, x2)

# 두 집단의 비율 차이 검정
# 양측 검정의 경우(two.sided)
# 귀무가설(H0) : 두 가지 교육방법에 대한 교육생의 만족도 비율에는 차이가 없다.
# 대립가설(H1) : 두 가지 교육방법에 대한 교육생의 만족도 비율에는 차이가 있다.

# 단측 검정의 경우(greater)
# 귀무가설(H0) : PT 교육방법이 Coding 교육방법보다 만족도가 낮다.
# 대립가설(H1) : PT 교육방법이 Coding 교육방법보다 만족도가 높다.

# 단측 검정의 경우(less)
# 귀무가설(H0) : PT 교육방법이 Coding 교육방법보다 만족도가 높다.
# 대립가설(H1) : PT 교육방법이 Coding 교육방법보다 만족도가 낮다.

# prop.test(x, n, alternative="two.sided", conf.level=0.95)
# prop.test(x, n, alternative="greater", conf.level=0.95)
# prop.test(x, n, alternative="less", conf.level=0.95)
# alternative : 검정 방법
# conf.level : 신뢰 구간(95%) = 0.95
prop.test(x, n, alternative = "two.sided", conf.level = 0.95)
prop.test(x, n, alternative = "greater", conf.level = 0.95)
prop.test(x, n, alternative = "less", conf.level = 0.95)
