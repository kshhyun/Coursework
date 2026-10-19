library(psych)

# 남녀 대학생의 학년별 휴대폰 사용 시간
setwd("D:/work")
data <- read.csv("mobile_usage.csv", fileEncoding = 'EUC-KR', header=TRUE)
str(data)

# 신입생(1학년) 남학생(M), 여학생(F) 표본 추출
data1 <- subset(data, data$Gender=="M" & data$Grade==1)
data2 <- subset(data, data$Gender=="F" & data$Grade==1)

# 기술 통계량
describe(data1$Usage_time)
describe(data2$Usage_time)

# 표본의 개수가 동일한 경우 t-검정, paired=TRUE
# 귀무가설(H0) : 신입생의 경우 남학생과 여학생의 휴대폰 사용시간은 차이가 없다.
# 대립가설(H1) : 신입생의 경우 남학생과 여학생의 휴대폰 사용시간은 차이가 있다.
# 유의수준(알파) = 0.05
# p-value가 유의수준 보다 크면 귀무가설 채택, 작으면 귀무가설 기각
result <- t.test(data1$Usage_time, data2$Usage_time, paired = TRUE)
result