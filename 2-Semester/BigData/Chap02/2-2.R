x <- c(94.5, 94, 95, 96, 96, 97, 96.5, 98, 95, 96)
x_bar <- mean(x)
s <- sd(x)
mu <- 95

#t-value
t <- (x_bar - mu)/(s/sqrt(length(x)))

#t-test
t.test(x, alternative = "greater", mu=95)

#z-test
setwd("D:/")
source("z_test.R")
z.test(22.5, 4, 64, 21.5, 1)