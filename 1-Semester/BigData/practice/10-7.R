month <- c(1:12)
late <- c(5, 8, 7, 9, 4, 6, 12, 13, 8, 6, 6, 4)

plot(month, late, main="월별 지각생 추이", type="l",
     lty=1, lwd=2, xlab="Month", ylab="지각 회수",
     col="blue")