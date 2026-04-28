# 산술연산과 주석 -----------------
6-2.5  # 3.5
8/2    # 4
8%%3   # 2
2^3    # 8

# 수학함수 ------------------------
# 로그함수
log(2) + 3      # 3.693147
log(10)         # 2.302585
log(10, base=2) # 3.321928

sqrt(36)      # 6
sqrt(-3)      # NaN

max(3,9,5)    # 9
max()         # -Inf
min(3,9,5)    # 3
min()         # Inf

abs(-11.5)    # 11.5
factorial(5)  # 120
sin(pi/2)     # 1

#====================================
# 숫자형
a <- 10
b <- 20
c <- a + b
print(c)   # 30

d <- "A"
e <- a + d #서로 다른 자료형(숫자 <-> 문자)의 연산은 오류 발생
print(e)

#문자형 '' 또는 "" 사용
size_1 <- "M"
size_2 <- 'L'
menu_1 <-  "Americano"
menu_2 <- 'Latte'
print(size_1)
print(size_2)
print(menu_1)
print(menu_2)

#논리형
a < b   # True
a | b   # True
a & b   # True
a == b  # False
a != b  # True

#====================================
# Vector - Java, C와 달리 인덱스 1부터 시작
# Vector를 생성하는 함수의 활용 
a <- c(1:20)
b <- seq(1, 15)
c <- seq(1, 30, by=2)
print(c)

menu <- c('Americano', 'Cappuccino')
d <- rep(menu, times=2)
num <- c(1,3,5)
e <- rep(num, times=3)

x1 <- c(2,4,6,8,10,12,14,16)
x1[1]
x1[6]
x2 <- c(1:5)
x3 <- c("KIM", "LEE", "JUNG", "PARK")

# 3인덱스 7 값 -> 88로 교환 
x1[3] <- 88
x3[4] <- "CHOI"

# seq(0)
x4 <- c(1,2,3,10:15)
x5 <- seq(1, 10, by=2) #증가값
x6 <- seq(10, 1, by=-2) #감소값
x7 <- c(1,2,7, seq(1,10,2), 7:9)
print(x7)

# rep()
x8 <- rep(x2,3) #x2를 3만큼 반복
print(x8)
x9 <- c(10,2,4, seq(1,7,3), rep(x2,2), 90)
print(x9)

# 변수에 할당X -> 일회성(console에 바로 출력)
rep(x = c(2,3,4), times = 2)
rep(x = "a", times = 3)

#names() : 벡터에 이름 부여 -> 크게 활용되지는 X
grade <- c(3, 4, 4)
names(grade) <- c("Kim", "Park", "Park")
grade

#벡터에서 조건에 맞는 데이터 추출
score <- c(98, 90, 88, 77, 96, 90, 99, 58, 96, 97)
x1 <- score[c(1,3,7)]   # 1, 3, 7인덱스 값 추출
x2 <- score[seq(1,10,2)] #홀수값 추출
x3 <- score[seq(1,10, by=2)] #홀수값 추출
x4 <- score[c(1:3, seq(3,10,3))] # 1~3까지, 3, 6, 9 추출
x5 <- score[-c(3,6,9)]  # 3,6,9 값 제외 추출

# 벡터와 숫자 연산
n <- c(1,2,5)
n1 <- 2*n
n2 <- (3*n)+5

# 벡터와 벡터 연산
z1 <- c(1,5,8,4)
z2 <- c(3,7,5,6)
z3 <- z1*5 + z2       # 8 32 45 26

# 관계연산자 practice
x <- c(1,2,3,2,2,1,3,6,2,4,3,7,3,2,1)
y <- sum(x==2)  # x에서 조건을 충족하는 원소의 개수
z <- (x==2)     # x에서 2인 것은 참
a <- x[x>5]     # x가 5보다 큰 것 출력
b <- sum(x[x>5])
cond <- x[x>2 & x<=5]
c <- sum(cond)

#====================================
# List
a <- "KIM"
b <- "202600012"
c <- "S"
d <- c(78,99,98,90,88)
stu <- list(name=a, ID=b, class=c, grade=d) #리스트 구조로 생성
# stu$ #stu의 멤버 명칭을 보여줌 -> name, ID 등
stu$name <- "Lee"
stu$grade[4] <- 95 # 4번째 인덱스에 접근해 점수 변경
stu[1] # 리스트에 저장된 1번째 내용 출력
stu[4] # 리스트에 저장된 4번째 내용 출력
# stu[1] 방법보다는 $변수명을 지칭하는 방법 추천

#====================================
# Factor
gender <- c("남", "여", "남", "여", "여")
group <- factor(gender)
group

#====================================
# Matrix
a <- c(3,5,7,34,89,3,9,11,32,88,99,4,6,8,10)
b <- matrix(a, nrow=3, ncol=5)   # 3행 5열의 매트릭스 생성(열 우선)
c <- matrix(a, nrow=3, ncol=5, byrow = T)  #행 우선 매트릭스 생성
c[2,3] <- 77             # 2행 3열
c[ ,2] <- c(4, 66, 90)   # [1,2], [2,2], [3,2]
b[2, c(1,5)] <- c(10,10) # 2행의 1열, 5열 [2,1], [2,5]
b[1, -c(1:4)] <- 100     # [1,5]
b[3, seq(1,5,2)] <- c(200, 250, 300) # [3,1], [3,3], [3,5]

score <- c(89,90,99,88,76,90,94,83,89,67,93,88)
x <- matrix(score, nrow=3, ncol=4)
colnames(x) <- c('KIM', 'LEE', 'PARK', 'CHOI')
rownames(x) <- c('MATH','ENG', 'KOR')
t(x)  # 행, 열 변환 -> mtrix() 빼고는 행열변환 잘 안 씀
a <- x['KOR', 3]       # [3,3]
b <- x['KOR', 'PARK']  # [3,3]
c <- x[ ,'KIM']        # [ ,1] KIM 열의 모든 행
c
sum(a)
sum(c)

x2 <- t(x)

# matrix - cbind(), rbind()
y <- matrix(1:20, nrow=4, ncol=5)
y1 <- c(11:14)
y2 <- (21:25)
n1 <- cbind(y, y1) # 열벡터 추가
n2 <- rbind(y, y2) # 행벡터 추가

y[1:2,]  # 1~2행 모든 열

#====================================
# data frame 연습
score <- c(90, 87, 88, 99, 77,98, 87,93)
grade <- c('A0', 'B+', 'B+', 'A+', 'C+', 'A+', 'B+', 'A0')
df <- data.frame(score, grade)
str <- (iris) #요약정보
str(iris)
head(iris)    # 앞에서부터 6개 출력
tail(iris)    # 뒤에서부터 6개 출력
nrow(iris)    # 행의 개수
dim(iris)     # 행, 열 개수
summary(iris) #기술통계량(평균, 중앙값 등)
subset(iris, Sepal.Length > 6.5)
colSums(iris[2])
colMeans(iris[c(1, 3)])

#====================================
# File 저장 및 읽기
str(quakes)
my_quakes <- subset(quakes, mag > 5.5)

setwd("/Users/hyun/Study/CourseWork/Coursework/BigData/work")
write.csv(my_quakes, "my_quakes.csv", row.names = F)
new_quakes <- read.csv("my_quakes.csv")
new_quakes

#====================================
# 조건문if
a <- 'LEE'
if ( a == 'LEE') {
  cat('동일합니다.')
}

# if-else
a <- 10
b <- 20
if (a>b) {
  cat('a는 b보다 크다')
} else {
  cat('a는 b보다 작다')
}

# ifelse
c <- ifelse(a>b, a, b)
print(c)

# if-else-if [다중 if]
s <- 98
if(s>=95){
  g <- "A+"
} else if (s>=90) {
  g <- "A0"
} else if (s>=85) {
  g <- "B+"
} else if (s>=80) {
  g <- "B0"
} else if (s>=75) {
  g <- "C+"
} else if (s>=70) {
  g <- "C0"
} else if (s>=65) {
  g <- "D+"
} else if (s>=60) {
  g <- "D0"
} else {
  g <- "F"
}
print(g)

#====================================
# for 반복문
sum <- 0
for(i in 1:100) {
  sum <- sum + i
}
cat("1~100의 합 =", sum)

# 1~100 짝수의 합 / 홀수의 합
even_sum <- 0
add_sum <- 0
for(i in 1:100) {
  if( i %% 2 == 0) {
    even_sum <- even_sum + i
  } else {
    add_sum <- add_sum + i
  }
}
cat("1~100 짝수합 =", even_sum)
cat("1~100 홀수합 =", add_sum)

# 1~100 짝수의 합 / 홀수의 합(2)
even_sum <- 0
add_sum <- 0
for(i in seq(1, 100, 2)) {
  add_sum <- add_sum + i
}
for(i in seq(2, 100, 2)) {
  even_sum <- even_sum + i
}
cat('홀수=', add_sum, ' / 짝수=', even_sum)

#중첩 for 반복문
# 아래는 반복문을 사용하지 않으면 얼마나 복잡한지에 대한 예시(???)
z <- matrix(1:20, nrow = 5, ncol=4, byrow=T)
r1 <- sum(z[1, ])
r2 <- sum(z[2, ])
r3 <- sum(z[3, ])
r4 <- sum(z[4, ])
r5 <- sum(z[5, ])
# 행의 합을 통해 벡터 r 생성
rs <- c(r1,r2,r3,r4,r5) #vector of each row sums

c1 <- sum(z[ ,1])
c2 <- sum(z[ ,2])
c3 <- sum(z[ ,3])
c4 <- sum(z[ ,4])
cs <- c(c1,c2,c3,c4,0)

z1 <- cbind(z,rs) #행의 합을 오른쪽 끝열에 추가
z2 <- rbind(z1,cs) #열의 합을 아래쪽 끝열에 추가

for (i in 1:6) {
  for(j in 1:5){
    cat(z2[i, j])
  }
  cat("\n")
}

#1~20 matrix 행과 열의 합(2)
z <- matrix(1:20, nrow = 5, ncol = 4, byrow = T)
rs <- c() #empty vector
cs <- c() #empty vector
for (i in 1:5) {
  sum <- 0
  for (j in 1:4) {
    sum <- sum +z[i, j]
  }
  rs[i] <- sum #각 행의 합
}

for (j in 1:4) {
  sum <- 0
  for (i in 1:5) {
    sum <- sum +z[i, j]
  }
  cs[j] <- sum #각 열의 합
}
cs <- c(cs,0)
z1 <- cbind(z,rs) #행의 합을 오른쪽 끝열에 추가
z2 <- rbind(z1,cs) #열의 합을 아래쪽 끝열에 추가

# Q1. 아래 코드에서 어떤 Part를 수정해야 열의 합이 얻어질까? (실행X)
for (i in 1:5) {
  sum <- 0
  for (j in 1:4) {
    sum <- sum +z[i, j]
  }
  rs[i] <- sum #각 열의 합
}

# Q1. answer
for (j in 1:4) {
  sum <- 0
  for (i in 1:5) {
    sum <- sum +z[i, j]
  }
  cs[j] <- sum #각 열의 합
}

cs <- c(cs,0)
z1 <- cbind(z,rs) #행의 합을 오른쪽 끝열에 추가
z2 <- rbind(z1,cs) #열의 합을 아래쪽 끝열에 추가

#1~N*M matrix 행과 열의 합 - 위 코드와 동일한 값 출력됨
N <- 5
M <- 4
f <- N*M
zz <- matrix(1:f, nrow = N, ncol = M, byrow = T)
rs <- c() #empty vector
cs <- c() #empty vector
for (i in 1:N) {
  sum <- 0
  for (j in 1:M) {
    sum <- sum +zz[i, j]
  }
  rs[i] <- sum #각 행의 합
}

for (j in 1:M) {
  sum <- 0
  for (i in 1:N) {
    sum <- sum +zz[i, j]
  }
  cs[j] <- sum #각 열의 합
}
cs <- c(cs,0)  #cs 벡터의 맨끝에 0값 추가
zz1 <- cbind(zz,rs) #행의 합을 오른쪽 끝열에 추가
zz2 <- rbind(zz1,cs) #열의 합을 아래쪽 끝열에 추가

#====================================
# while
sum <- 0
for(i in 1:100){     # i가 1부터 100까지 1씩 증가 -> 반복
  if(i %% 2 == 0) next # i를 2로 나눈 나머지가 0 -> 짝수라면 아래 과정 생략
  sum <- sum + i
}
cat("1부터 100까지 홀수의 합 = ", sum, "\n")  # 2500

#====================================
#apply
#1~N*M matrix 행과 열의 합(3)
N <- 7
M <- 6
f <- N*M
zzz <- matrix(1:f, nrow = N, ncol = M, byrow = T)
rs <- c() #empty vector
cs <- c() #empty vector
rs <- apply(zzz, 1, sum) # 각 행의 합
cs <- apply(zzz, 2, sum) # 각 열의 합
cs <- c(cs,0)  #cs 벡터의 맨끝에 0값 추가
zzz1 <- cbind(zzz,rs) #행의 합을 오른쪽 끝열에 추가
zzz2 <- rbind(zzz1,cs) #열의 합을 아래쪽 끝열에 추가

#====================================
#while() 반복문
#1+2+3+........ 합이 500을 넘을 때,
#더해진 마지막 숫자는?
sum <- 0
i <- 1
while(T){
  sum <- sum + i
  if(sum > 500) break
  i <- i + 1
}
cat("1+2+3+.....+", i, "=", sum, "\n")

#====================================
# 사용자 정의함수 호출
setwd("~/Study/CourseWork/Coursework/BigData")  #경로설정
source("user_function.R")                       #사용자 정의 함수 include
r1 <- four_arithmetic(20, 30)
r2 <- even_odd_sum(1000)
r3 <- rcs_1(5, 8)
r4 <- rcs_2(8, 3)

score <- c(78, 88, 56, 90, 99, 87, 89, 94, 88, 77)
unit <- c(3, 2, 2, 3, 2, 3, 1, 2, 3, 3) # 이수단위
name <- "KIM"
id <- "20250010"
class <- "S"
r5 <- score_table(name, id, class, score, unit)

score <- c(88, 88, 90, 90, 99, 87, 89, 94, 88, 77)
name <- "LEE"
id <- "20250011"
class <- "S"
r6 <- score_table(name, id, class, score, unit)

# 데이터 추출 테스트
setwd("~/Study/CourseWork/Coursework/BigData/CSV")    #경로 설정
Hanyang_Coffee <- read.csv("coffee_info.csv")

r1 <- Hanyang_Coffee[2]           # 2열 데이터 출력
r2 <- Hanyang_Coffee[1:3]         # 1~3열 데이터 추출
r3 <- Hanyang_Coffee[c(2,3,5)]    # 2, 3, 5열
r4 <- Hanyang_Coffee[1, 3]        # 1행 3열
r5 <- Hanyang_Coffee[1:2, 3]      # 1~2행, 3열
r6 <- Hanyang_Coffee[c(2,3,5), 5] # 2, 3, 5행/5열
r7 <- Hanyang_Coffee["Beans"]     # 변수 이름이 Beans인 열
r8 <- Hanyang_Coffee[2:5, "Beans"]# 2~5행까지 열이름이 Beans
r9 <- Hanyang_Coffee$Beans
r10 <- Hanyang_Coffee[Hanyang_Coffee$Beans == "Arabica", ]

