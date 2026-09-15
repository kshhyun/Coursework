month <- c(1:12)
late_A <- c(5, 8, 7, 9, 4, 6, 12, 13, 8, 6, 6, 4)
late_B <- c(2, 5, 10, 5, 8, 5, 3, 10, 9, 3, 4, 2)
late_C <- c(4, 6, 2, 3, 3, 5, 4, 8, 10, 2, 5, 2)

plot(month, late_A, main="월별 지각생 추이", type="b",
     lty=3, lwd=1, xlab="Month", ylab="지각 회수",
     col="red", ylim=c(1, 15))

lines(month, late_B, type="b", lty=3, col="green", ylim=c(1, 15))
lines(month, late_C, type="b", lty=3, col="blue", ylim=c(1, 15))

