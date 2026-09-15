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

boxplot(DF$rm~DF$factor_medv, 
        main="ÁÖÅÃ °¡°Ý°ú Æò±Õ ·ëÀÇ °³¼ö", xlab="ÁÖÅÃ °¡°Ý", 
        ylab="Æò±Õ ·ëÀÇ °³¼ö", col="green")