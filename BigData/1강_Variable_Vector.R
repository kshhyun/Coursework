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
x5 <- score[-c(3,6,9)]. # 3,6,9 값 제외 추출

# Vector 숫자 연산
n <- c(1,2,5)
n1 <- 2*n
n2 <- (3*n)+5