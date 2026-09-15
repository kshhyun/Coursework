#Using the 'Boston Housing' data frame
library(mlbench)
data("BostonHousing")
str(BostonHousing)
DF <- BostonHousing[ ,c("crim", "rm", "dis", "tax", "ptratio", "medv")]

#Max and Min
val_max <- max(DF$medv)
val_min <- min(DF$medv)
val_dif <- val_max - val_min

# H : High price, M : Medium price, L : Low price
factor_medv <- c( )
for(i in 1:nrow(DF)){
  if(DF$medv[i] >= (val_dif*0.75)){
    factor_medv[i] <- "H"
  }else if(DF$medv[i] <= (val_dif*0.25)){
    factor_medv[i] <- "L"
  }else{
    factor_medv[i] <- "M"
  }
}

factor_medv <- factor(factor_medv, levels = c("H", "M", "L"))
DF <- data.frame(DF, factor_medv)

vars <- c("rm", "medv")
target <- DF[ , vars]
point <- as.integer(DF$factor_medv)
color <- c("red", "green", "blue")
remark <- c("H","M", "L")
plot(target, main="주택가격에 따른 룸의 개수 산포도",
     xlab="룸의 개수", ylab="타운 수",
     pch = point, col = color[point])

legend(x="topleft", ncol=3, legend=c("H,", "M,", "L"), 
       col=c("red", "green", "blue"), pch=c(1,2,3), 
       bg = "white", cex = 1)

cor(DF$rm, DF$medv)