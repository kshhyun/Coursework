#이항분포 함수 ------------
dbinom(2, 10, 0.5)
pbinom(2, 10, 0.5)

#포아송분포 함수------------ 평균을 벗어나는 순간 수치 내려감
dpois(6, 10)
ppois(6, 10)

#평균 λ에 따른 포아송 분포의 예 ------------
rs <- data.frame()

for (i in 1:20){
  rs[i, 1] <- dpois(i,3)
  rs[i, 2] <- dpois(i,5)
  rs[i, 3] <- dpois(i,10)
  rs[i, 4] <- dpois(i,40)
}

plot(rs[,1], type="b", pch=1, col="red", xlab="X", ylab="f(x)")
lines(rs[,2],type="b", pch=2, col="green")
lines(rs[,3],type="b", pch=3, col="blue")
lines(rs[,4],type="b", pch=4, col="pink")
legend(x="topright", 
       legend=c("λ = 3", "λ = 5", "λ = 10"),
       col=c("red", "green", "blue", "pink"),
       pch=c(1, 2, 3, 4), cex=1)

#표준정규분포의 PDF와 CDF ------------
par(mfrow=c(2, 1))

#Normal distribution, X~N(0,1)
x <- seq(-3, 3, length=500)
probability <- dnorm(x, mean=0, sd=1)
plot(x, probability, type='l', col="red", 
     main="Normal distribution, X~N(0,1)")

#Cumulative normal distribution, X~N(0,1)
probability <- pnorm(x, mean=0, sd=1)
plot(x, probability, type='l', col="green", 
     main="Cumulative normal distribution, X~N(0,1)")

# 표준정규분포의 구간 면적 ------------
# P(-1 <= z <= 1)
pnorm(q=c(1), mean=0, sd=1)
pnorm(q=c(-1), mean=0, sd=1)
pnorm(q=c(1), mean=0, sd=1) - pnorm(q=c(-1), mean=0, sd=1)

# P(-2 <= z <= 2)
pnorm(q=c(2), mean=0, sd=1)
pnorm(q=c(-2), mean=0, sd=1)
pnorm(q=c(2), mean=0, sd=1) - pnorm(q=c(-2), mean=0, sd=1)

# P(-3 <= z <= 3)
pnorm(q=c(3), mean=0, sd=1)
pnorm(q=c(-3), mean=0, sd=1)
pnorm(q=c(3), mean=0, sd=1) - pnorm(q=c(-3), mean=0, sd=1)


# lower.tail=TRUE/FALSE
pnorm(q=c(1), mean=0, sd=1, lower.tail = TRUE)
pnorm(q=c(1), mean=0, sd=1, lower.tail = FALSE)

# Random number generation from normal distribution X~N(0, 1) ------------
# 임의 난수 개수에 따른 확률분포
par(mfrow=c(1,3))
x <- rnorm(10, mean=0, sd=1)
hist(x, col=rainbow(10), freq=F)
lines(density(x), lwd=2)

x <- rnorm(100, mean=0, sd=1)
hist(x, col=rainbow(10), freq=F)
lines(density(x), lwd=2)

x <- rnorm(500, mean=0, sd=1)
hist(x, col=rainbow(10), freq=F)
lines(density(x), lwd=2)

#표준정규분포와 t-분포 ------------ [1-7]
library(ggplot2)

ggplot(data.frame(x=c(-3,3)), aes(x=x)) +
  stat_function(fun=dnorm, colour="red", linewidth=1) +
  stat_function(fun=dt, args=list(df=9), colour="green", linewidth=1) +  
  stat_function(fun=dt, args=list(df=3), colour="blue", linewidth=1) +
  stat_function(fun=dt, args=list(df=1), colour="magenta", linewidth=1) +
  annotate("segment", x=1.5, xend=2, y=0.4, yend=0.4, colour="red", linewidth=1) +
  annotate("segment", x=1.5, xend=2, y=0.37, yend=0.37, colour="green", linewidth=1) + 
  annotate("segment", x=1.5, xend=2, y=0.34, yend=0.34, colour="blue", linewidth=1) +
  annotate("segment", x=1.5, xend=2, y=0.31, yend=0.31, colour="magenta", linewidth=1) +  
  annotate("text", x=2.4, y=0.4, label="N(0,1)") +
  annotate("text", x=2.4, y=0.37, label="t(9)") + 
  annotate("text", x=2.4, y=0.34, label="t(3)") + 
  annotate("text", x=2.4, y=0.31, label="t(1)") +   
  ggtitle("정규분포와 t-분포") +
  labs(y="p(x)")





