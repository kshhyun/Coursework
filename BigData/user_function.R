#사용자 정의 함수 구현

#사칙연산 결과를 구하는 함수
four_arithmetic <- function(x, y){
  n1 <- x + y
  n2 <- x - y
  n3 <- x * y
  n4 <- x / y
  
  return(list(add = n1, sub = n2, mul = n3, div = n4))
}

#1부터 n까지 짝수의 합과 홀수의 합을 구하는 함수
even_odd_sum <- function(n){
  sum1 <- 0
  sum2 <- 0
  for(i in 1:n){
    if(i%%2 == 0){
      sum1 <- sum1 + i  #짝수 합
    }else{
      sum2 <- sum2 + i  #홀수 합
    }
  }
  result <- c(sum1, sum2)
  return(result)
}

#가로의 합과 세로의 합을 구하는 함수(1)
rcs_1 <- function(N, M){
  f <- N*M
  z <- matrix(1:f, nrow=N, ncol=M, byrow=T)
  rs <- c() #행의 합이 저장되는 벡터 초기화
  cs <- c() #열의 합이 저장되는 벡터 초기화  
  
  #행의 합
  for(i in 1:N){
    sum <- 0
    for(j in 1:M){
      sum <- sum + z[i, j]
    }
    rs[i] <- sum
  }
  
  #열의 합
  for(j in 1:M){
    sum <- 0
    for(i in 1:N){
      sum <- sum + z[i, j]
    }
    cs[j] <- sum
  }
  
  cs <- c(cs, 0) #CS의 끝에 0을 추가(경고 제거용)
  r <- cbind(z, rs)
  result <- rbind(r, cs)
  
  return(result)
}

#가로의 합과 세로의 합을 구하는 함수(2)
rcs_2 <- function(N, M){
  f <- N*M
  z <- matrix(1:f, nrow=N, ncol=M, byrow=T)
  rs <- c() #행의 합이 저장되는 벡터 초기화
  cs <- c() #열의 합이 저장되는 벡터 초기화

  rs <- apply(z, 1, sum) #행의 합
  cs <- apply(z, 2, sum) #열의 합
  
  cs <- c(cs, 0) #CS의 끝에 0을 추가(경고 제거용)
  r <- cbind(z, rs)
  result <- rbind(r, cs)
  
  return(result)  
}

#성적을 처리하는 사용자 함수 정의
score_table <- function(name, id, class, score, unit){
  grade <- c()
  rating <- c()
  n <- length(score)
  total <- 0.0
  for(i in 1:n){
    if(score[i] >= 95){
      grade[i] <- "A+"
      rating[i] <- 4.5
    }else if(score[i] >= 90){
      grade[i] <- "A0"
      rating[i] <- 4.0
    }else if(score[i] >= 85){
      grade[i] <- "B+"
      rating[i] <- 3.5
    }else if(score[i] >= 80){
      grade[i] <- "B0"
      rating[i] <- 3.0
    }else if(score[i] >= 75){
      grade[i] <- "C+"
      rating[i] <- 2.5
    }else if(score[i] >= 70){
      grade[i] <- "C0"
      rating[i] <- 2.0
    }else if(score[i] >= 65){
      grade[i] <- "D+"
      rating[i] <- 1.5
    }else if(score[i] >= 60){
      grade[i] <- "D0"
      rating[i] <- 1.0
    }else{
      grade[i] <- "F"
      rating[i] <- 0.0
    }
    
    #전체 평점
    total <- total + rating[i]*unit[i];
  }  
  
  #평균 평점
  mean_rating <- total / sum(unit)
  
  #처리결과 리스트로 표현
  result <- list(NAME=name, ID=id, CLASS=class, MR=mean_rating, SCORE=score, GRADE=grade)
  
  return(result)
}
