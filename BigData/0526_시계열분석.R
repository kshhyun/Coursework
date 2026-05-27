# 시열 함수
# par()
x<- c(2,5,6,5,7,9,11,5,7,9,13,15,17)
y<- c(1,2,3,4,5,6,7,8,9,10,11,12,13)
plot(x,y, main="PLOT", xlab="x-lab", ylab="y-lab",type="p")  
# text()
#text(9,10, "Plotting", col="red")
# legend()
legend("center","(x,y)",pch=1,col='green', lty=1, title="center") # 한 줄씩 출력해야 함
legend("top","(x,y)",lty =1,title="top")
legend("left","(x,y)",lwd =10,title="left")
legend("right","(x,y)",col =,title="right")
legend("bottomleft","(x,y)",lty =1,title="bottomleft")

par(mfrow = c(1,2)) #2행4열의 그래프를 그릴수 있다.
plot(x,y, main="PLOT",sub = "type=p",xlab="x-lab",ylab="y-lab",type="p")
plot(x,y, main="PLOT",sub = "type=l",xlab="x-lab",ylab="y-lab",type="l")

# points()
z<-c(3.5,1.5,2.3,3.4,6.6)
points(z,pch=1,cex=1)
points(z,pch=3,cex=1)
points(z,pch=4,cex=1)
points(z,pch=5,cex=1)
points(z,pch=7,cex=1)
points(z,pch=9,cex=1)
points(z,pch=11,cex=4) #cex 1 -> 4로 변환

# lines()
plot(x, y, ylim=c(0,20), type="n")
lines(c(2,6),c(20,20),lty=1)
lines(c(2,6),c(19,19),lty=2)
lines(c(2,6),c(18,18),lty=3)
lines(c(2,6),c(17,17),lty=4)
lines(c(2,6),c(16,16),lty=5)
lines(c(2,6),c(15,15),lty=6)


# 6강 데이터셋 분석
#Using the 'Boston Housing' data frame
library(mlbench)
data("BostonHousing")
str(BostonHousing)
DF <- BostonHousing[ ,c("crim", "rm", "dis", "tax", "ptratio", "medv")]

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

