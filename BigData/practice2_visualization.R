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


# [Plot]
# 9-10 -------------------
