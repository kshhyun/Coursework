# 남녀 대학생의 학년별 휴대폰 사용 시간
setwd("D:/work")
data <- read.csv("mobile_usage.csv", fileEncoding = "euc-kr", header=TRUE)
str(data)

# 학년을 범주형으로 변환
grade <- as.factor(data$Grade)

# 휴대폰 사용시간과 학년만을 데이터 프레임으로 변환
DF <- data.frame(Usage_time = data$Usage_time, grade)
str(DF)

# 1, 2, 3, 4학년 집단 간 휴대폰 사용시간의 모평균에 차이가 있는지 검정
# 귀무가설(H0) : 학년별 휴대폰 사용시간은 차이가 없다.
# 대립가설(H1) : 학년별 휴대폰 사용시간은 차이가 있다.
# 유의수준(알파) = 0.05
# p-value가 유의수준 보다 크면 귀무가설 채택, 작으면 귀무가설 기각
result <- aov(Usage_time ~ grade, data = DF)
summary(result)