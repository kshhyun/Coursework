#using the 'D:/source/adv_sales.csv' file 
setwd("~/Study/CourseWork/Coursework/BigData/CSV")
DF <- read.csv("adv_sales.csv")
par(family="AppleGothic")
str(DF)

time <- DF$ADV
sales <- DF$Sales
plot(time, sales, main="광고 시간과 판매량 추이", 
     xlab="시간(분)", ylab="판매량(잔)", pch=22,
     col="blue", bg="red", cex=1.5)