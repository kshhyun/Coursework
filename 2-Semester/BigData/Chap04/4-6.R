library(reshape2) # melt()
library(ggplot2)
library(dplyr)

# 6명의 환자를 대상으로 신약 투여 
# 투약전, 3개월후, 6개월후의 혈중농도 측정
# 시간에 따른 혈중농도의 차이 검정
name <- c("김**", "이**", "박**", "정**", "윤**", "신**") 
m0 <- c(45, 42, 36, 39, 51, 44)
m3 <- c(50, 42, 41, 35, 55, 49)
m6 <- c(55, 45, 43, 40, 59, 56)
data <- data.frame(name, m0, m3, m6) 
str(data)

# melt( ) : 데이터 재구조화 함수(스택형으로 재구조화)
# 범주형으로 변환
re_data <- melt(data, id.vars = "name") 
colnames(re_data) <- c("name","time","value") 
re_data$name <- factor(re_data$name) 
re_data$time <- factor(re_data$time)
str(re_data)

# 개인별 혈중농도의 변화 그래프
ggplot(re_data, aes(x=time, y=value))+
  geom_line(aes(group=name, col=name))+
  geom_point(aes(col=name))

# 반복 측정 분산분석
# 신약 투여 후 시간에 따른 혈중농도의 차이가 있는지 검정
# 귀무가설(H0) : 투약 후 시간에 따른 혈중농도의 차이가 없다.
# 대립가설(H1) : 투약 후 시간에 따른 혈중농도의 차이가 있다.
# 유의수준(알파) = 0.05
# p-value가 유의수준 보다 크면 귀무가설 채택, 작으면 귀무가설 기각
result <- aov(value~time + Error(name/time), data=re_data) 
summary(result)

# p-value가 유의수준 0.05보다 작으므로 귀무가설 기각
# 따라서 시간에 따른 혈중농도 변화는 유의한 차이가 있다고 할 수 있음
# 어느 정도의 차이가 있는지를 검정하려면 사후분석이 필요함
# 사후분석 : pairwise.t.test( ) 함수를사용하여 검정(t-검정)
with(re_data, pairwise.t.test(value, time, paired=T, p.adjust.method="bonferroni"))
