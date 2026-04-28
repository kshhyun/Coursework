#Using the 'Boston Housing' data frame
library(ggplot2)
library(mlbench)
data("BostonHousing")
DF <- BostonHousing[ ,c("crim", "medv")]
str(DF)
ggplot(DF,
       aes(x=medv, y=crim)) + 
       geom_point(pch=1, cex=2, col="red")
