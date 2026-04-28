#산술연산자
a <- 134
b <- 12
c <- a+b
d <- a*b
e <- a/b
f <- a%%b
g <- a^3

#수학함수
a <- log(10)             #natural log(base=e)
b <- log(10, base=10)    #common log(base=10)
c <- log(10, base=2)     #base=2
d <- sqrt(100)
e <- sin(30)
f <- max(1, 54, 7, 9, 45, 90, 33)
print(a)
cat("상용로그 log(10) = ", b)
print(d)
print(e)
print(f)

#논리형 변수
score <- 94
grade <- score > 95
print(grade)

score_1 <- 88
grade_1 <- score_1 > 80 & score_1 < 90
print(grade_1)

#Factor 형
blood <- c("A", "A", "AB", "O", "B", "O", "B", "AB", "A", "AB")
a <- factor(blood) #범주형 데이터로 변환
print(a)

#벡터연습
x1 <- c(1, 5, 7, 3, 9, 10, 11, 67, 7, 8)
x2 <- c(1:5)
x3 <- c("KIM", "LEE", "JUNG", "PARK")
x1[3] <- 88
x3[4] <- "CHOI"
x4 <- c(1, 2, 3, 10:15)
x5 <- seq(1, 10, by=2)   #증가 값
x6 <- seq(10, 1, by=-2)  #감소 값
x7 <- c(1, 2, 7, seq(1, 10, 2), 7:9)
print(x7)
x8 <- rep(x2, 3)
print(x8)
x9 <- c(10, 2, 4, seq(1, 7, 3), rep(x2, 2), 90)
print(x9)

#names() 함수
names(x2) <- c("A", "B", "C", "D", "E")
print(x2)
x2[2] <- 10
x2["D"] <- 20
print(x2)

#벡터에서 조건에 맞는 데이터 추출하기
score <- c(98, 90, 88, 77, 96, 90, 99, 58, 96, 97)
y1 <- score[c(1, 3, 7)]            #1, 3, 7인덱스 값 추출
y2 <- score[seq(1, 10, 2)]         #홀수 인덱스 값 추출
y3 <- score[c(1:3, seq(3, 10, 3))] #1, 2, 3, 3, 6, 9 추출
y4 <- score[-c(3, 6, 9)]           #3, 6, 9를 제외하고 추출

#벡터의 연산(산술 연산) : 수치형 벡터만 적용됨
z1 <- c(1, 5, 8, 4)
z2 <- c(3, 7, 5, 6)
a <- z1*5 + z2

#관계연산자 연습
x <- c(1, 2, 3, 2, 2, 1, 3, 6, 2, 4, 3, 7, 3, 2, 1)
y <- sum(x==2) #x에서 조건을 충족하는 원소의 개수
z <- (x==2) #x에서 2인 것은 참, 나머지는 거짓
a <- x[x>5] #x에서 5보다 큰 값만 추출
b <- sum(x[x>5])
cond <- x[x>2 & x<=5] #2보다 크고 5보다 작거나 같은 데이터 추출
c <- sum(cond)

#list 연습
a <- "KIM"
b <- "202600012"
c <- "S"
d <- c(78, 99, 98, 90, 88)
stu <- list(name=a, ID=b, class=c, grade=d) #리스트 구조로 생성
stu$name <- "LEE"
stu$grade[4] <- 95

#matrix 연습
a <- c(3, 5, 7, 34, 89, 3, 9, 11, 32, 88, 99, 4, 6, 8, 10)
b <- matrix(a, nrow=3, ncol=5) #3행 5열의 매트릭스 생성(열 우선)
c <- matrix(a, nrow=3, ncol=5, byrow=T) #행 우선 매트릭스 생성
c[2, 3] <- 77              #2행 3열
c[ , 2] <- c(4, 66, 90)    #[1, 2], [2, 2], [3, 2]
b[2, c(1, 5)] <- c(10, 10) #[2, 1], [2, 5]
b[1, -c(1:4)] <- 100       #[1, 5]
b[3, seq(1, 5, 2)] <- c(200, 250, 300)  #[3, 1], [3, 3], [3, 5]

#매트릭스의 행과 열이름 부여
score <- c(89, 90, 99, 88, 76, 90, 94, 83, 89, 67, 93, 88)
x <- matrix(score, nrow=3, ncol=4)
colnames(x) <- c("KIM", "LEE", "PARK", "CHOI") #열이름
rownames(x) <- c("MATH", "ENG", "KOR")         #행이름
t(x) #행, 열 변환
a <- x["KOR", 3]      #[3, 3]
b <- x["KOR", "PARK"] #[3, 3]
c <- x[ , "KIM"]      #[ , 1]
sum(c)

#매트릭스에서 rbind(), cbind() 함수 사용
y <- matrix(1:20, nrow=4, ncol=5)
y
y1 <- c(11:14)
y2 <- c(21:25)
n1 <- cbind(y, y1) #열벡터 추가
n2 <- rbind(y, y2) #행벡터 추가

#data frame 연습
score <- c(90, 87, 88, 99, 77, 98, 87, 93)
grade <- c("A0", "B+", "B+", "A+", "C+", "A+", "B+", "A0")
df <- data.frame(score, grade)
str(iris)        #요약정보
head(iris)       #앞에서부터 6개 출력
tail(iris)       #뒤에서부터 6개 출력
nrow(iris)       #행의 개수
dim(iris)        #행, 열 개수
summary(iris)    #기술통계량(평균, 중앙값 등)
subset(iris, Sepal.Length > 6.5)
colSums(iris[2])
colMeans(iris[c(1, 3)])

#파일 저장/읽기
str(quakes)
my_quakes <- subset(quakes, mag > 5.5)

setwd("D:/work") #경로 설정
write.csv(my_quakes, "my_quakes.csv", row.names = F) #save
new_quakes <- read.csv("my_quakes.csv")              #read
new_quakes

#조건문
#if
a <- "LEE"
if(a == "LEE"){
  cat("동일합니다!")
}

#if~else
a <- 10
b <- 20
if(a > b){
  cat("a는 b보다 크다")
}else{
  cat("a는 b보다 작다")  
}

#ifelse
c <- ifelse(a>b, a, b)
print(c)

#if~else~if(다중 if)
s <- 98
if(s>=95){
  g <- "A+"
}else if(s>=90){
  g <- "A0"
}else if(s>=85){
  g <- "B+"
}else if(s>=80){
  g <- "B0"
}else if(s>=75){
  g <- "C+"
}else if(s>=70){
  g <- "C0"
}else if(s>=65){
  g <- "D+"
}else if(s>=60){
  g <- "D0"
}else{
  g <- "F"
}
print(g)

#반복문
#for
sum <- 0
for(i in 1:100){
  sum <- sum + i
}
cat("1~100의 합 = ", sum)

#1~100까지 짝수의 합과 홀수의 합(1)
even_sum <- 0
odd_sum <- 0
for(i in 1:100){
  if(i %% 2 == 0){
    even_sum <- even_sum + i
  }
  else{
    odd_sum <- odd_sum + i    
  }
}
cat("짝수의 합 = ", even_sum)
cat("홀수의 합 = ", odd_sum)

#1~100까지 짝수의 합과 홀수의 합(2)
even_sum <- 0
odd_sum <- 0
for(i in seq(1, 100, 2)){
  odd_sum <- odd_sum + i
}
for(i in seq(2, 100, 2)){
  even_sum <- even_sum + i
}
cat("짝수의 합 = ", even_sum)
cat("홀수의 합 = ", odd_sum)

#중첩 for 반복문
#1~20 매트릭스의 행과 열의 합(1)
z <- matrix(1:20, nrow=5, ncol=4, byrow=T)
r1 <- sum(z[1, ])
r2 <- sum(z[2, ])
r3 <- sum(z[3, ])
r4 <- sum(z[4, ])
r5 <- sum(z[5, ])
rs <- c(r1, r2, r3, r4, r5) #vector of each row sums

c1 <- sum(z[ , 1])
c2 <- sum(z[ , 2])
c3 <- sum(z[ , 3])
c4 <- sum(z[ , 4])
cs <- c(c1, c2, c3, c4, 0) #vector of each column sums

z1 <- cbind(z, rs)  #행의 합을 오른쪽 끝열에 추가
z2 <- rbind(z1, cs) #열의 합을 아래쪽 끝행에 추가

for(i in 1:6){
  for(j in 1:5){
    cat(z2[i, j])
  }
  cat("\n")
}

#1~20 매트릭스의 행과 열의 합(2)
N <- 7
M <- 6
f <- N*M
z <- matrix(1:f, nrow=N, ncol=M, byrow=T)
rs <- c() #empty vector
cs <- c() #empty vector
for(i in 1:N){
  sum <- 0
  for(j in 1:M){
    sum <- sum + z[i, j]    
  }
  rs[i] <- sum #각 행의 합
}

for(j in 1:M){
  sum <- 0
  for(i in 1:N){
    sum <- sum + z[i, j]  #각 열의 합  
  }
  cs[j] <- sum
}
cs <- c(cs, 0)      #cs 벡터의 맨끝에 0 값 추가
z1 <- cbind(z, rs)  #행의 합을 오른쪽 끝열에 추가
z2 <- rbind(z1, cs) #열의 합을 아래쪽 끝행에 추가

#1~N*M 매트릭스의 행과 열의 합(3)
N <- 7
M <- 6
f <- N*M
z <- matrix(1:f, nrow=N, ncol=M, byrow=T)
rs <- c() #empty vector
cs <- c() #empty vector
#rs <- apply(z, 1, sum) #각 행의 합
rs <- rowSums(z)
#cs <- apply(z, 2, sum) #각 열의 합
cs <- colSums(z)
cs <- c(cs, 0)      #cs 벡터의 맨끝에 0 값 추가
z1 <- cbind(z, rs)  #행의 합을 오른쪽 끝열에 추가
z2 <- rbind(z1, cs) #열의 합을 아래쪽 끝행에 추가

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

#사용자 정의함수 호출
setwd("D:/work")        #경로 설정
source("user_function.R") #사용자 정의 함수 include
r1 <- four_arithmetic(20, 30)
r2 <- even_odd_sum(1000)
r3 <- rcs_1(3, 4)
r4 <- rcs_2(3, 4)

score <- c(78, 88, 56, 90, 99, 87, 89, 94, 88, 77)
unit <- c(3, 2, 2, 3, 2, 3, 1, 2, 3, 3) #이수단위
name <- "KIM"
id <- "20250010"
class <- "S"
r5 <- score_table(name, id, class, score, unit)

score <- c(88, 88, 90, 90, 99, 87, 89, 94, 88, 77)
name <- "LEE"
id <- "20250011"
class <- "S"
r6 <- score_table(name, id, class, score, unit)

#데이터추출 테스트
setwd("D:/work/CSV")    #경로 설정
Hanyang_Coffee <- read.csv("coffee_info.csv")

Hanyang_Coffee[2]
Hanyang_Coffee[1:3]
Hanyang_Coffee[c(2,3,5)]
Hanyang_Coffee[1, 3]
Hanyang_Coffee[1:2, 3]
Hanyang_Coffee[c(2,3,5), 5]
Hanyang_Coffee["Beans"]
Hanyang_Coffee[2:5, "Beans"]
Hanyang_Coffee$Beans
Hanyang_Coffee[Hanyang_Coffee$Beans == "Arabica", ]




































