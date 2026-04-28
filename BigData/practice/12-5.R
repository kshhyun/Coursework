library(ggplot2)

Month <- c(1:12)
Americano <- c(28, 19, 13, 19, 13, 22, 25, 23, 24, 16, 20, 22)
Latte <- c(15, 21, 28, 16, 10, 23, 29, 15, 10, 11, 15, 14)
Cappuccino <- c(22, 12, 15, 14, 21, 26, 17, 19, 19, 24, 17, 30)
Mocha <- c(11, 20, 29, 20, 28, 17, 11, 11, 15, 15, 20, 10)
Esspresso <- c(14, 14, 10, 9, 11, 13, 12, 11, 10, 12, 11, 10)
DF <- data.frame(Month, Americano, Latte, Cappuccino, Mocha, Esspresso)

ggplot(data = DF, aes(x = Month, y = Americano)) +
  geom_bar(stat="identity", width=0.7, fill="blue")