### --- File: example_1.R --- ###
# 산술연산과 주석
3+5+8
9-3
7*5
8/3
8%%3
2^3

### --- File: example_4.R --- ###
# R의 문자형
size_1 <- "M"
size_2 <- 'L'
menu_1 <- "Americano"
menu_2 <- 'Latte'
print(size_1)
print(size_2)
print(menu_1)
print(menu_2)


### --- File: example_5.R --- ###
# 벡터를 생성하는 함수의 활용
a <- c(1:20)
b <- seq(1, 15)
c <- seq(1, 30, by = 2)

menu <- c("Americano", "Cappuccino")
d <- rep(menu, times = 2)

num <- c(1, 3, 5)
e <- rep(num, times = 3)


### --- File: example_6.R --- ###
# 벡터의 원소에 이름을 지정하는 방법
score <- c(99, 87, 78, 65, 93)
names(score) <- c("Kim", "Lee", "Park", "Choi", "Youn")
score

# 데이터 추출(벡터의 인덱스, 벡터의 이름)
score[1]
score["Kim"]


### --- File: example_7.R --- ###
# 벡터에서 조건을 주어 데이터 추출하기
score <- c(98, 88, 67, 90, 40, 87, 79, 99, 100)
score[c(1, 3, 5)]          # 1, 3, 5번째 값 추출
score[c(1:5)]              # 1부터 5번째 값까지 추출
score[seq(1, 9, by = 2)]   # 홀수번째 값 추출
score[-c(2)]               # 2번째 값을 제외하고 추출
score[-c(3:5)]             # 3부터 5까지 제외하고 추출


### --- File: example_8.R --- ###
n <- c(1, 4, 3, 7, 8)

# 벡터와 숫자의 연산
n1 <- 2*n
n2 <- (3*n)+5

# 벡터와 벡터의 연산
x <- c(1, 2, 3)
y <- c(4, 5, 6)
z1 <- x+y 
z2 <- x*y
z3 <- x/y


### --- File: example_9.R --- ###
# 벡터 연산 함수의 활용
score <- c(95, 78, 79, 99, 88, 83, 89, 97, 67, 72)

# 평균을 구하는 2가지 방법
sum(score) / length(score)
mean(score)

# 오름차순 정렬
sort(score, decreasing = FALSE)

# 중간 값
median(score)

# 최대값과 최소값
max(score)
min(score)

# 분산과 표준편차
var(score)
sd(score)


### --- File: example_10.R --- ###
# list() 함수의 활용
score <- c(95, 88, 92, 76, 82)
student <- list(name="KIM", ID="20220001", class="A", grade=score)
student     # 리스트에 저장된 모든 데이터 출력
student[1]  # 리스트에 저장된 1번째 데이터 출력
student[4]  # 리스트에 저장된 4번째 데이터 출력


### --- File: example_11.R --- ###
# 범주형 데이터
gender <- c("남", "여", "남", "여", "여")
group <- factor(gender)
group


### --- File: example_12.R --- ###
# 매트릭스 데이터
score <- c(90, 85, 69, 78, 85, 96, 49, 95, 90, 80, 70, 60)
score_table <- matrix(score, nrow = 3, ncol = 4)          #3행 4열의 매트릭스 생성
colnames(score_table) <- c("Kim", "Lee", "Park", "Choi")  #열이름 지정
rownames(score_table) <- c("English", "Math", "Science")  #행이름 지정
score_table


### --- File: example_13.R --- ###
# 데이터 프레임
score <- c(90, 85, 69, 78, 85, 96, 49, 95, 90, 80, 70, 60)
grade <- c("A0", "B+", "D+", "C+", "B+", "A+", "F", "A+", "A0", "B0", "C0", "D0")
score_table <- data.frame(score, grade) #데이터 프레임 생성
score_table


### --- File: example_14.R --- ###
# iris 데이터프레임
head(iris)
tail(iris)
str(iris)
summary(iris)


### --- File: example_15.R --- ###
#경로 설정
setwd("D:/source")

#csv 파일을 읽어와 데이터 프레임 score_table에 저장
score_table <- read.csv("score.csv")  
score_table

#지진 규모가 5.0 이상인 데이터만 추출
quakes_5 <- subset(quakes, mag > 5.0)

#지정된 경로인 "D:/source" 폴더에 csv 파일로 저장
write.csv(quakes_5, "quakes_5.csv", row.names = F)


### --- File: example_16.R --- ###
No <- c(1:10)
Blood <- c("A", "B", "A", "O", "AB", "O", "O", "AB", "A","A")

# No와 Blood 벡터를 이용하여 데이터프레임 생성
student <- data.frame(No, Blood)
str(student)

# 빈도수를 구함
table(student$Blood)


### --- File: example_17.R --- ###
No <- c(1:10)
Blood <- c("A", "B", "A", "O", "AB", "O", "O", "AB", "A","A")

# No와 Blood 벡터를 이용하여 데이터프레임 생성
student <- data.frame(No, Blood)

# 빈도수를 구함
student_freq <- table(student$Blood)

# 상대 빈도수를 구함
prop.table(student_freq)


### --- File: example_18.R --- ###
# 학생들의 혈액형이 저장된 파일을 읽어와서 실행
setwd("D:/source")
student <- read.csv("student_blood_types.csv")
str(student)

# 빈도수를 구함
student_freq <- table(student$Blood)

# 수직 막대 그래프로 시각화
barplot(student_freq, main="학생들의 혈액형 분포", 
        col=rainbow(4), xlab="혈액형", ylab="명 수")


### --- File: example_19.R --- ###
# 학생들의 혈액형이 저장된 파일을 읽어와서 실행
setwd("D:/source")
student <- read.csv("student_blood_types.csv")
str(student)

# 빈도수를 구함
student_freq <- table(student$Blood)

# 수평 막대 그래프로 시각화
barplot(student_freq, main="학생들의 혈액형 분포", 
        col=rainbow(4), xlab="혈액형", ylab="명 수",
        horiz = T)


### --- File: example_2.R --- ###
# R의 수학 함수
log(10)
log(10, base=2)
sqrt(36)
max(3, 9, 5)
min(3, 9, 5)
abs(-10)
factorial(5)
sin(pi/2)


### --- File: example_20.R --- ###
setwd("D:/source")
Class_A <- read.csv("student_blood_types_A.csv")
Class_B <- read.csv("student_blood_types_B.csv")
A_freq <- table(Class_A$Blood)
B_freq <- table(Class_B$Blood)

# A반의 빈도수와 B반의 빈도수를 묶어줌
student_freq <- rbind(A_freq, B_freq)

# 범례를 표시하여 스택형 막대 그래프로 시각화
remark <- c("A반", "B반")
barplot(student_freq, main="학생들의 혈액형 분포", 
        col=c("green", "blue"), xlab="혈액형",
        ylab="학생 수", legend.text=remark, 
        args.legend=list(x="top", ncol=2))


### --- File: example_21.R --- ###
city <- c("서울", "부산", "대구", "인천", "광주", "대전", "울산")
pm25 <- c(8, 11, 13, 14, 17, 18, 25) # 초미세먼지 농도
pct <- round(pm25/sum(pm25)*100, 1)  # 백분율로 표현(소수점 이하 1자리)

# 색상 팔레트 설정(RColorBrewer 패키지를 설치해야 함)
library(RColorBrewer)
colors <- brewer.pal(7, 'Greens')

# 파이 차트 작성
# init.angle=90 : 90도 기준
# clockwise=T : 시계 방향으로 표시
city_labels <- paste(city, ",", pct, "%", sep="")
pie(pm25, labels=city_labels, col=colors, main="지역별 초미세먼지 농도(%)",
    init.angle=90, clockwise=T)


### --- File: example_22.R --- ###
setwd("D:/source")
student <- read.csv("student_body.csv")
str(student)

# 학생들의 키를 히스토그램으로 시각화
hist(student$Height, main="히스토그램 분포도", 
     col=rainbow(6), xlab="학생들의 키", ylab="명 수")


### --- File: example_23.R --- ###
# R에서 제공하는 'quakes' 데이터프레임 사용
str(quakes)
mag <- quakes$mag

# 지진의 강도를 히스토그램으로 시각화
# breaks : 계급의 최소, 최대, 구간 수를 설정하는 인수
hist(mag, main="피지섬의 지진 발생 분포",
     xlab="지진 강도", ylab="발생건수",
     col=terrain.colors(12), breaks=seq(4.0, 6.7, by=0.2))


### --- File: example_24.R --- ###
str(quakes)
mag <- quakes$mag              #quakes에서 mag 변수만 추출
value.min <- min(mag)          #최소값
value.max <- max(mag)          #최대값
value.mid <- median(mag)       #중앙값
Q <- quantile(mag)             #Q
IQR <- Q[4]-Q[2]               #IQR
value.upper <- Q[4] + 1.5*IQR  #상한값
value.lower <- Q[2] - 1.5*IQR  #하한값

# 박스 플롯으로 시각화
boxplot(mag, main="피지섬의 지진 규모 분포", 
        ylab="지진 강도", col='red')


### --- File: example_25.R --- ###
#Using the 'mtcars' data frame
str(mtcars)

wt <- mtcars$wt
mpg <- mtcars$mpg
plot(wt, mpg, main="자동차 중량과 연비 분포도",
     xlab="중량(1000 lbs)", ylab="연비(miles per gallon)", 
     col='red', pch=19, cex=0.8)


### --- File: example_26.R --- ###
#Using the 'mtcars' data frame
vars <- c("mpg", "disp", "wt")
target <- mtcars[ ,vars]
pairs(target, 
      main="연비, 배기량, 무게에 따른 산포도",
      col=rainbow(3), 
      pch=19)


### --- File: example_27.R --- ###
# Using the 'iris' data frame
str(iris)

# Select 'Petal.Length' and 'Petal.Width'
var <- iris[ , 3:4]
point <- as.numeric(iris$Species)
color <- c("red", "green", "blue")

# plot() 함수를 이용한 시각화
plot(var, main="품종에 따른 꽃잎의 길이와 폭의 산포도",
     xlab="꽃잎의 길이(Petal.Length)",
     ylab="꽃잎의 폭(Petal.Width)",
     pch=c(point), col=color[point])

# 범례 표시
remark <- c("setosa", "versicolor", "virginica")
legend("topleft", legend = remark, pch = c(1, 2, 3), 
       col = color)


### --- File: example_28.R --- ###
# bal(blood alcohol level)
bottle <- c(5, 2, 9, 8, 3, 7, 3, 5, 3, 5)
bal <- c(0.1, 0.03, 0.19, 0.12, 0.04, 0.095, 0.07, 0.06, 0.02, 0.05)
table <- data.frame(bottle, bal)

# 시각화
plot(table, main="음주정도와 혈중알콜농도의 산포도",
     xlab="음주량(bottle)",
     ylab="혈중알콜농도(bal)",
     pch=19, col="green")

# 선형 모델을 이용한 회귀식 도출
res <- lm(bal~bottle, data=table)

# 도출된 회귀식을 이용하여 직선을 그림
abline(res, lwd=2, col="red")

# 상관계수값 계산
cor(bottle, bal)


### --- File: example_29.R --- ###
# using the 'D:/source/adv_sales.csv' file 
setwd("D:/source")
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


### --- File: example_3.R --- ###
# R의 숫자형
a <- 10
b <- 20
c <- a+b
print(c) #변수 c에 저장된 값 출력

d <- "A"
e <- a+d
print(e)


### --- File: example_30.R --- ###
# A, B, C반의 월별 지각회수
month <- c(1:12)
A <- c(5, 8, 7, 9, 4, 6, 12, 13, 8, 6, 6, 4)
B <- c(2, 5, 10, 5, 8, 5, 3, 10, 9, 3, 4, 2)
C <- c(4, 6, 2, 3, 3, 5, 4, 8, 10, 2, 5, 2)

# plot() 함수를 사용하여 A반 시각화
plot(month, A, main="월별 지각생 추이", type="b",
     lty=3, lwd=1, xlab="Month", ylab="지각 회수",
     col="red", ylim=c(1, 15))

# lines() 함수를 사용하여 B, C반 시각화
lines(month, B, type="b", lty=3, col="green", ylim=c(1, 15))
lines(month, C, type="b", lty=3, col="blue", ylim=c(1, 15))

# 범례 표시
remark <- c("A반", "B반", "C반")
legend("topright", legend = remark, pch = 1, 
       col = c("red", "green", "blue"))


### --- File: example_31.R --- ###
library(treemap)
data("GNI2014")
str(GNI2014)

# treemap() 함수를 이용한 시각화
# index : 순서대로 큰 타일과 작은 타일을 설정함
# vSize : 특정 변수를 사각형의 크기로 설정함
# vColor : 특정 변수를 크기에 비례하여 설정함
# type : value, index
# bg.labels : 배경색
# title : 제목
treemap(GNI2014,
        index=c("continent","iso3"),
        vSize="population",
        vColor="GNI",
        type="value",
        bg.labels="red",
        title="전 세계 국민총소득")


### --- File: example_32.R --- ###
# Using the 'state.x77' matrix
# 데이터프레임으로 변환
DF <- data.frame(state.x77)
str(DF)

# symbols() 함수를 이용한 버블차트 시각화
symbols(DF$Illiteracy, DF$Murder,
        circles=DF$Population,
        inches=0.7,
        fg="white",
        bg="lightgray",
        lwd=1,
        xlab="문맹률(%)",
        ylab="살인률(%)",
        main="50개 주의 인구대비 문맹률에 따른 살인비율 분포")

# text() 함수를 이용한 주별 표시
text(DF$Illiteracy, DF$Murder,
     rownames(DF), cex=0.6, col=rainbow(12))


### --- File: example_33.R --- ###
# Using the 'state.x77' matrix
# 데이터프레임으로 변환
DF <- data.frame(state.x77)

# symbols() 함수를 이용한 버블차트 시각화
symbols(DF$Income, DF$Life.Exp,
        circles=DF$Population,
        inches=0.7,
        fg="black",
        bg="white",
        lwd=1,
        xlab="소득",
        ylab="평균 수명",
        main="50개 주의 인구대비 소득과 평균 수명과의 관계")

# text() 함수를 이용한 주별 표시
text(DF$Income, DF$Life.Exp,
     rownames(DF), cex=0.6, col=rainbow(12))


### --- File: example_34.R --- ###
# Using the 'Titanic' 배열
str(Titanic)

# mosaicplot() 함수를 이용한 시각화
mosaicplot(~Class + Survived, 
           data = Titanic,
           xlab="선실등급(Class)", 
           ylab="생존여부(Survived)",
           color=c("pink", "lightblue"),
           cex = 1,
           dir = c("v","h"))


### --- File: example_35.R --- ###
# Using the 'Boston Housing' data frame
# 패키지를 설치했으면 library() 함수를 통해 로딩해야 함
library(ggplot2) #ggplot() 함수를 사용할 경우 필요함
library(mlbench) #'BostonHousing' 데이터 셋을 활용할 경우 필요함

data("BostonHousing")
str(BostonHousing)

# 범죄율과 주택가격 변수만 추출
DF <- BostonHousing[ ,c("crim", "medv")]

# 산점도를 이용하여 시각화
ggplot(DF, aes(x=medv, y=crim)) + 
  geom_point(pch=1, cex=2, col="red")


### --- File: example_36.R --- ###
# Using the 'iris' data frame
library(ggplot2)

ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) +
  geom_point(size=3) +
  ggtitle("꽃잎의 길이와 폭") + 
  theme(plot.title = element_text(size=16, face="bold", color="steelblue"))+
  labs(x="꽃잎의 길이(Petal.Length)", y="꽃잎의 폭(Petal.Width)")


### --- File: example_37.R --- ###
# Using the 'mtcars' data frame
library(ggplot2)
str(mtcars)

ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)),
           position = "dodge") + 
  theme(legend.position = "bottom") +
  scale_fill_discrete(name = "변속기", 
                      labels=c("automatic", "manual")) +
  labs(x = "실린더 수(4, 6, 8)",
       y = "자동차 수",
       title = "실린더 수에 따른 자동차 분석")


### --- File: example_38.R --- ###
# Using the 'iris' data frame
library(ggplot2)

ggplot(iris, aes(x=Sepal.Width, fill=Species, color=Species)) +
  geom_histogram(binwidth = 0.5, position="dodge") +
  theme(legend.position="top") +
  labs(x="꽃받침의 폭(Sepal.Width)", y="")


### --- File: example_39.R --- ###
library(ggplot2)

setwd("D:/source")
DF <- read.csv("coffee_monthly_sales.csv")
str(DF)

ggplot(data = DF, aes(x = Menu, y = No, fill = Menu)) +
  geom_boxplot() +
  stat_summary(fun = "mean", geom = "point", 
               shape = 21, size = 3, fill = "red") +
  theme(axis.title.x = element_blank()) +
  labs(title = "한양커피숍의 판매량", y = "수량")


### --- File: example_40.R --- ###
# Using the 'state.x77' matrix
library(ggplot2)

# 매트릭스를 데이터프레임으로 변환
DF <- data.frame(state.x77)

ggplot(data = DF, 
       aes(x = c(1:50), y = Frost, color = rownames(DF))) +
  geom_point(size=3) +
  theme(axis.title.x = element_blank(), 
        legend.title = element_blank()) +
  labs(title = "미국 50개 주의 서리 내린 회수 분포",
       y = "서리가 내린 날(일)")

