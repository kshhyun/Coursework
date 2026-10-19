# Z-검정 함수
# x-bar : 표본평균
# s : 표본 표준편차
# n : 표본의 개수
# mu : 모집단 평균
# method=1(단측검정), method=2(양측검정)
z.test <- function(x_bar, s, n, mu, method)
{
  #검정 통계량
  z <- (x_bar - mu)/(s/sqrt(n))
  
  #p_value
  #단측 검정
  if(method==1){
    p_value <- 1-pnorm(z, 0, 1)
  }
  
  #양측 검정
  if(method==2){
    p_value <- 2*(1-pnorm(z, 0, 1))
  }

  cat("\n","z value is",z,"\n")  
  cat("\n","p value is",p_value,"\n")
}