rs <- data.frame()

for (i in 1:20){
  rs[i, 1] <- dpois(i,3)
  rs[i, 2] <- dpois(i,5)
  rs[i, 3] <- dpois(i,10)
}

plot(rs[,1], type="b", pch=1, col="red", xlab="X", ylab="f(x)")
lines(rs[,2],type="b", pch=2, col="green")
lines(rs[,3],type="b", pch=3, col="blue")
legend(x="topright", 
       legend=c("¥ë = 3", "¥ë = 5", "¥ë = 10"),
       col=c("red", "green", "blue"),
       pch=c(1, 2, 3), cex=1)