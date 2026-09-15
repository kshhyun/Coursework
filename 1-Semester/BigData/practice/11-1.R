#Using the 'Boston Housing' data frame
library(mlbench)
data("BostonHousing")
str(BostonHousing)
DF <- BostonHousing[ ,c("crim", "rm", "dis", "tax", "ptratio", "medv")]

#max and min
#6강 p.10 참고해 코드 추가

par(mfrow=c(3, 2)) # 3행 2열로 표시
hist(DF[ ,1], main="타운별 범죄 비율", xlab="1인당 범죄 건수", 
     ylab="타운 수", col="red")

hist(DF[ ,2], main="가구당 평균 룸의 비율", xlab="룸의 개수", 
     ylab="타운 수", col="green")

hist(DF[ ,3], main="직업센터 접근 지수", xlab="직업센터까지의 거리", 
     ylab="타운 수", col="blue")

hist(DF[ ,4], main="재산세율", xlab="재산세(10,000$)", 
     ylab="타운 수", col="yellow")

hist(DF[ ,5], main="교사 비율", xlab="교사 수", 
     ylab="타운 수", col="magenta")

hist(DF[ ,6], main="주택가격 비율", xlab="주택가격(1,000$)", 
     ylab="타운 수", col="cyan")

