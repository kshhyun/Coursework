#bal(blood alcohol level)
bottle <- c(5, 2, 9, 8, 3, 7, 3, 5, 3, 5)
bal <- c(0.1, 0.03, 0.19, 0.12, 0.04, 0.095, 0.07, 0.06, 0.02, 0.05)
table <- data.frame(bottle, bal)

plot(table, main="음주정도와 혈중알콜농도의 산포도",
     xlab="음주량(bottle)",
     ylab="혈중알콜농도(bal)",
     pch=19, col="red")

res <- lm(bal~bottle, data=table)
abline(res, lwd=2, col="blue")
cor(bottle, bal)