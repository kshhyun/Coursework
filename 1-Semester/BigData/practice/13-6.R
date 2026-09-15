# Random number generation from normal distribution X~N(0, 1)

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