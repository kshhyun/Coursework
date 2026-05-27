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


# 11-1 -------------------