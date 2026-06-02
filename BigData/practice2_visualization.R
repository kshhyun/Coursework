# [0428] ====================================================
# 9-5 -------------------
No <- c(1:40)
Blood <- c("A", "B", "A", "O", "AB", "O", "O", "AB", "A","A",
           "AB", "A", "A", "O", "O", "O", "A", "AB", "O","O",
           "A", "B", "O", "O", "B", "A", "A", "AB", "A","A",
           "O", "B", "B", "O", "AB", "AB", "O", "AB", "O","O")

student <- data.frame(No, Blood)

setwd("~/Study/CourseWork/Coursework/BigData/practice")  #저장할 경로 설정
write.csv(student, "student_blood_types.csv", row.names = F)

# 도수분포표
student_freq <- table(student$Blood)
student_freq
#상대도수
student_Rfreq <- prop.table(student_freq)
student_Rfreq

barplot(student_Rfreq)

# 9-5-1 -------------------
setwd("~/Study/CourseWork/Coursework/BigData/practice")
student <- read.csv("student_blood_types.csv")
str(student)
student_freq <- table(student$Blood)

barplot(student_freq, main="학생들의 혈액형 분포", 
        col=rainbow(4), xlab="혈액형", ylab="명 수")

# 9-5-2 -------------------
setwd("~/Study/CourseWork/Coursework/BigData/practice")
student <- read.csv("student_blood_types.csv")
str(student)
student_freq <- table(student$Blood)

# 한글 깨짐 이슈
#par(family = "AppleGothic")

barplot(student_freq, main="학생들의 혈액형 분포", 
        col=rainbow(4), xlab="학생 수",
        ylab="혈액형", horiz=T)

# 9-5-3 -------------------
setwd("~/Study/CourseWork/Coursework/BigData/CSV")
Class_A <- read.csv("student_blood_types_A.csv")
Class_B <- read.csv("student_blood_types_B.csv")
A_freq <- table(Class_A$Blood)
B_freq <- table(Class_B$Blood)
student_freq <- rbind(A_freq, B_freq)
student_freq

remark <- c("A반", "B반")
barplot(student_freq, main="학생들의 혈액형 분포", 
        col=c("green", "blue"), xlab="혈액형",
        ylab="학생 수", legend.text=remark, 
        args.legend=list(x="top", ncol=2))

# [0512] ====================================================
# [PieChart]
# 9-6-1 -------------------
city <- c("서울", "부산", "대구", "인천", "광주", "대전", "울산")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)
colors <- c("red", "orange", "yellow", "green", "lightblue", "blue", "violet")
pie(pm25, labels=city, col=colors, main="지역별 초미세먼지 농도",
    init.angle=90, clockwise=T)
# init.angle :기준선이 90도
# clockwise=T : ?ð? ????��?? ǥ??

#9-6-2 -------------------
library(RColorBrewer)
# 한글 깨짐 이슈
par(family = "AppleGothic")
greens <- brewer.pal(7, 'Pastel1') #Green
city <- c("서울", "부산", "대구", "인천", "광주", "대전", "울산")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)
pct <- round(pm25/sum(pm25)*100, 1)
city_labels <- paste(city, ",", pct, "%", sep="")
pie(pm25, labels=city_labels, col=greens, main="지역별 초미세먼지 농도)",
    init.angle=90, clockwise=T)

#9-6 -------------------
setwd("~/Study/CourseWork/Coursework/BigData/CSV")
student <- read.csv("student_blood_types.csv")
student_freq <- table(student$Blood)
student_freq
pie(student_freq)

# [Histogram]
# 9-7 -------------------
setwd("~/Study/CourseWork/Coursework/BigData/CSV")
student <- read.csv("student_body.csv")
str(student)
par(family = "AppleGothic")
hist(student$Height, main="피지섬의 지진 발생 분포", 
     col=rainbow(5), xlab="지진 강도", ylab="발생건수")

# 9-7-1 -------------------
#Using the 'quakes' data frame
str(quakes)
mag <- quakes$mag
par(mfrow=c(1,2)) # multiple figure: 2개 표시(1행 2열)
# row(행우선) / col(열우선)
hist(mag, main="피지섬의 지진 발생 분포",
     xlab="지진 강도", ylab="발생건수",
     col=brewer.pal(10, "Pastel2"), breaks=seq(4.0, 6.7, by=0.5))

#잘개 쪼개려고 by=0.5 -> by=0.1로 수정
hist(mag, main="피지섬의 지진 발생 분포",
     xlab="지진 강도", ylab="발생건수",
     #잘개 쪼개려고 by=0.2 -> by=0.1로 수정
     col=rainbow(10), breaks=seq(4.0, 6.7, by=0.1))
# 9-7-2 -------------------
mag <- quakes$mag
par(mfrow=c(1,2)) # multiple figure: 2개 표시(1행 2열)

hist(mag, main="피지섬의 지진 발생 분포",
     xlab="지진 강도", ylab="발생건수",
     col=rainbow(10), breaks=seq(4.0, 6.7, by=0.2), freq=F)
lines(density(mag), lwd=5)

hist(mag, main="피지섬의 지진 발생 분포",
     xlab="지진 강도", ylab="발생건수",
     col=brewer.pal(10, "Pastel2"), breaks=seq(4.0, 6.7, by=0.1), freq=F)
lines(density(mag), col="red", lwd=2)

# [BoxPlot]
# 9-8 -------------------
str(quakes)
Q <- quantile(quakes$mag)
value.upper <- Q[4] + 1.5*IQR(quakes$mag)
value.lower <- Q[2] - 1.5*IQR(quakes$mag)
# IQR(quakes$mag)
boxplot(quakes$mag, main="피지섬의 지진 규모 분포", 
        ylab="지진 강도", col='skyblue')

# [Scatter Diagram]
# 9-9 -------------------
#using the 'student_body.csv' file 
setwd("~/Study/CourseWork/Coursework/BigData/CSV")
DF <- read.csv("student_body.csv")
str(DF)
male <- subset(DF, Gender == "MALE")
female <- subset(DF, Gender == "FEMALE")
male
female

#하나의 화면에 여러개 시각화
par(mfrow=c(1, 2))
male_height <- male$Height
male_weight <- male$Weight
plot(male_height, male_weight, main="남성의 키와 몸무게 분포", 
     xlab="키", ylab="몸무게", pch=21,
     col="blue", bg="red", cex=1.5)

female_height <- female$Height
female_weight <- female$Weight
plot(female_height, female_weight, main="여성의 키와 몸무게 분포", 
     xlab="키", ylab="몸무게", pch=21,
     col="blue", bg="green", cex=1.5)

# [0519] ====================================================
# [Plot]
# 9-10 -------------------
setwd("~/Study/CourseWork/Coursework/BigData/CSV")
DF <- read.csv("adv_sales.csv")
par(family="AppleGothic")
str(DF)

time <- DF$ADV
sales <- DF$Sales
plot(time, sales, main="광고 시간과 판매량 추이", 
     xlab="시간(분)", ylab="판매량(잔)", pch=22,
     col="blue", bg="red", cex=1.5)

# 10-3 -------------------
# pairs() 함수
str(mtcars)

vars <- c("mpg", "disp", "wt", "cyl")
target <- mtcars[ , vars]
head(target)
par(family="AppleGothic")
pairs(target, main="연비, 배기량, 무게, 실린더 수에 따른 산포도",
      col=rainbow(4))

# 10-4 -------------------
str(iris)
#Select 'Petal.Length' and 'Petal.Width'
vars <- iris[ , 3:4]
point <- as.numeric(iris$Species)
plot_color <- c("red", "green", "blue")
remark <- c("setosa", "versicolor", "virginica")
plot(vars, main="품종에 따른 꽃잎의 길이와 폭의 산포도",
     xlab="꽃잎의 길이(Petal.Length)",
     ylab="꽃잎의 폭(Petal.Width)",
     pch=c(point), col=plot_color[point])

# 10-5 -------------------
#bal(blood alcohol level)
bottle <- c(5, 2, 9, 8, 3, 7, 3, 5, 3, 5)
bal <- c(0.1, 0.03, 0.19, 0.12, 0.04, 0.095, 0.07, 0.06, 0.02, 0.05)
table <- data.frame(bottle, bal)

plot(table, main="음주정도와 혈중알콜농도의 산포도",
     xlab="음주량(bottle)",
     ylab="혈중알콜농도(bal)",
     pch=19, col="red")

res <- lm(bal~bottle, data=table)
abline(res, lwd=2, col="blue")
cor(bottle, bal)

# 10-6 -------------------
setwd("~/Study/CourseWork/Coursework/BigData/CSV")
DF <- read.csv("adv_sales.csv")
str(DF)

time <- DF$ADV
sales <- DF$Sales
table <- data.frame(time, sales)

plot(table, main="광고 시간과 커피 판매량 추이", 
     xlab="시간(분)", ylab="판매량(잔)", 
     pch=8, col="blue")

res <- lm(sales~time, data=table)
abline(res, lwd=2, col="red")
cor(time, sales)

# [0519] ====================================================
# [6강 데이터셋 분석]
# 11-1 -------------------
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

# [0526] ====================================================
# [5강 시계열 분석]
# [par]
x<- c(2,5,6,5,7,9,11,5,7,9,13,15,17)
y<- c(1,2,3,4,5,6,7,8,9,10,11,12,13)
plot(x,y, main="PLOT", xlab="x-lab", ylab="y-lab",type="p")  
# [text()]
# text(9,10, "Plotting", col="red")
# legend()
legend("center","(x,y)",pch=1,col='green', lty=1, title="center") # 한 줄씩 출력해야 함
legend("top","(x,y)",lty =1,title="top")
legend("left","(x,y)",lwd =10,title="left")
legend("right","(x,y)",col =,title="right")
legend("bottomleft","(x,y)",lty =1,title="bottomleft")

par(mfrow = c(1,2)) #2행4열의 그래프를 그릴수 있다.
plot(x,y, main="PLOT",sub = "type=p",xlab="x-lab",ylab="y-lab",type="p")
plot(x,y, main="PLOT",sub = "type=l",xlab="x-lab",ylab="y-lab",type="l")

# [points()]
z<-c(3.5,1.5,2.3,3.4,6.6)
points(z,pch=1,cex=1)
points(z,pch=3,cex=1)
points(z,pch=4,cex=1)
points(z,pch=5,cex=1)
points(z,pch=7,cex=1)
points(z,pch=9,cex=1)
points(z,pch=11,cex=4) #cex 1 -> 4로 변환

# [lines()]
plot(x, y, ylim=c(0,20), type="n")
lines(c(2,6),c(20,20),lty=1)
lines(c(2,6),c(19,19),lty=2)
lines(c(2,6),c(18,18),lty=3)
lines(c(2,6),c(17,17),lty=4)
lines(c(2,6),c(16,16),lty=5)
lines(c(2,6),c(15,15),lty=6)

# [6강 데이터셋 분석]
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

# [0602] ====================================================
# 11-2 -------------------
#Using the 'Boston Housing' data frame
library(mlbench)
data("BostonHousing")
str(BostonHousing)
DF <- BostonHousing[ ,c("crim", "rm", "dis", "tax", "ptratio", "medv")]
par(family="AppleGothic")

#Max and Min
val_max <- max(DF$medv)
val_min <- min(DF$medv)
val_dif <- val_max - val_min

# H : High price, M : Medium price, L : Low price
factor_medv <- c( )
for(i in 1:nrow(DF)){
  if(DF$medv[i] >= (val_dif*0.75)){
    factor_medv[i] <- "H"
  }else if(DF$medv[i] <= (val_dif*0.25)){
    factor_medv[i] <- "L"
  }else{
    factor_medv[i] <- "M"
  }
}

factor_medv <- factor(factor_medv, levels = c("H", "M", "L"))
DF <- data.frame(DF, factor_medv)

#주택 가격이 1인당 범죄율에 미치는 영향
boxplot(DF$crim~DF$factor_medv, 
        main="주택가격과 1인당 범죄건 수", xlab="주택 가격", 
        ylab="범죄건 수", col="red")
# 주택 가격이 평균 룸의 개수에 미치는 영향
boxplot(DF$rm~DF$factor_medv, 
        main="주택 가격과 평균 룸의 개수", xlab="주택 가격", 
        ylab="평균 룸의 개수", col="green")
# 주택 가격이 직업센터까지의 접근성에 미치는 영향
boxplot(DF$dis~DF$factor_medv, 
        main="주택 가격과 직업센터까지의 거리", xlab="주택 가격", 
        ylab="직업센터까지 거리", col="blue")
# 주택 가격이 학생 또는 교사 수에 미치는 영향
boxplot(DF$ptratio~DF$factor_medv, 
        main="주택 가격과 학생 수", xlab="주택 가격", 
        ylab="학생 수", col="yellow")
# [산포도] ----------------------------
# 주택 가격에 따른 범죄율과의 상관 분석
vars <- c("crim", "medv")
target <- DF[ , vars]
point <- as.integer(DF$factor_medv)
color <- c("red", "green", "blue")
remark <- c("H","M", "L")
plot(target, main="주택가격에 따른 1인당 범죄율 산포도",
     xlab="범죄건 수", ylab="타운 수",
     pch = point, col = color[point])

legend(x="top", ncol=3, legend=c("H,", "M,", "L"), 
       col=c("red", "green", "blue"), pch=c(1,2,3), 
       bg = "white", cex = 1)

cor(DF$crim, DF$medv)

# 주택 가격에 따른 룸의 개수와의 상관 분석
vars <- c("rm", "medv")
target <- DF[ , vars]
point <- as.integer(DF$factor_medv)
color <- c("red", "green", "blue")
remark <- c("H","M", "L")
plot(target, main="주택가격에 따른 룸의 개수 산포도",
     xlab="룸의 개수", ylab="타운 수",
     pch = point, col = color[point])

legend(x="topleft", ncol=3, legend=c("H,", "M,", "L"), 
       col=c("red", "green", "blue"), pch=c(1,2,3), 
       bg = "white", cex = 1)

cor(DF$rm, DF$medv)

# 주택 가격에 따른 학생 수의 상관 분석
vars <- c("ptratio", "medv")
target <- DF[ , vars]
point <- as.integer(DF$factor_medv)
color <- c("red", "green", "blue")
remark <- c("H","M", "L")
plot(target, main="주택가격에 따른 학생 수 산포도",
     xlab="학생 수", ylab="타운 수",
     pch = point, col = color[point])

legend(x="bottomleft", ncol=3, legend=c("H,", "M,", "L"), 
       col=c("red", "green", "blue"), pch=c(1,2,3), 
       bg = "white", cex = 1)

cor(DF$ptratio, DF$medv)

# [treemap]
# 11-9 -------------------
library(treemap)
data(GNI2014)
str(GNI2014)
par(family="AppleGothic")
treemap(GNI2014,
        index=c("continent","iso3"),
        vSize="population",
        vColor="GNI",
        type="value",
        bg.labels="red",
        title="전 세계 국민총소득")
# 대륙별 인구 분포
treemap(GNI2014,
        index="continent",
        vSize="population",
        type="index",
        title="대륙별 인구 분포")

# 11-11 -------------------
# 미국 50개 주의 면적과 수입에 대한 트리맵
library(treemap)
DF <- data.frame(state.x77)
par(family="AppleGothic")

New_DF <- data.frame(DF, state.name) #include USA state names

treemap(New_DF,
        index="state.name",
        vSize="Area",
        vColor="Income",
        type="value",
        title="미국 50개 주의 면적과 수입")
# 미국 50개 주의 수입과 문맹률
treemap(New_DF,
        index="state.name",
        vSize="Income",
        vColor="Illiteracy",
        type="value",
        title="미국 50개 주의 수입과 문맹률?")