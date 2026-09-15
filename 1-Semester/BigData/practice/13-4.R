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

