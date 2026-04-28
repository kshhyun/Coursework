# P(-1 <= X <= 1)
pnorm(q=c(1), mean=0, sd=1)
pnorm(q=c(-1), mean=0, sd=1)
pnorm(q=c(1), mean=0, sd=1) - pnorm(q=c(-1), mean=0, sd=1)

# P(-2 <= X <= 2)
pnorm(q=c(2), mean=0, sd=1)
pnorm(q=c(-2), mean=0, sd=1)
pnorm(q=c(2), mean=0, sd=1) - pnorm(q=c(-2), mean=0, sd=1)

# P(-3 <= X <= 3)
pnorm(q=c(3), mean=0, sd=1)
pnorm(q=c(-3), mean=0, sd=1)
pnorm(q=c(3), mean=0, sd=1) - pnorm(q=c(-3), mean=0, sd=1)


# lower.tail=TRUE/FALSE
pnorm(q=c(1), mean=0, sd=1, lower.tail = TRUE)
pnorm(q=c(1), mean=0, sd=1, lower.tail = FALSE)
